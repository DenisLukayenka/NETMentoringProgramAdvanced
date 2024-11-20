using System.Text.Json;
using Azure.Messaging.ServiceBus;
using Cart.Service.BusinessLogic.Services.Abstractions;
using Cart.Service.Platform.Serialization;
using Lunis.SharedLibs.Catalog.OutboxMessages;

namespace Cart.Service.BackgroundServices;

internal class OutboxMessageListener(
    IServiceScopeFactory serviceScopeFactory,
    ServiceBusClient busClient,
    ILogger<OutboxMessageListener> logger) : BackgroundService
{
    private const int NotFoundMessageDelayMilliseconds = 10_000;
    private readonly ServiceBusReceiver receiver = busClient.CreateReceiver(Constants.ProductsQueueName);

    private static JsonSerializerOptions _serializationOptions = new JsonSerializerOptions()
    {
        TypeInfoResolver = AppJsonSerializerContext.Default
    };

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                var busMessage = await receiver.ReceiveMessageAsync(cancellationToken: stoppingToken);
                if (busMessage is null)
                {
                    await Task.Delay(NotFoundMessageDelayMilliseconds, stoppingToken);
                    continue;
                }

                using var _ = logger.BeginScope(
                    "Received new message {MessageId} from message bus. CorrelationId: {CorrelationId}",
                    busMessage.MessageId,
                    busMessage.CorrelationId);

                using var serviceScope = serviceScopeFactory.CreateScope();
                var handler = serviceScope.ServiceProvider.GetRequiredService<IOutboxMessageHandler>();

                var outboxMessage = busMessage!.Body.ToObjectFromJson<BaseMessage>(_serializationOptions);

                await handler.Handle(outboxMessage, stoppingToken);

                await receiver.CompleteMessageAsync(busMessage, cancellationToken: stoppingToken);

                logger.LogInformation("Message processed successfuly");
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Cannot process message");
            }
        }
    }
}

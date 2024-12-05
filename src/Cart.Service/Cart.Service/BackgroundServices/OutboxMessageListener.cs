using System.Diagnostics.CodeAnalysis;
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
    private static readonly JsonSerializerOptions _serializationOptions = new()
    {
        TypeInfoResolver = AppJsonSerializerContext.Default
    };

    [UnconditionalSuppressMessage("Trimming", "IL2026:Members annotated with 'RequiresUnreferencedCodeAttribute' require dynamic access otherwise can break functionality when trimming application code", Justification = "<Pending>")]
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        await using var receiver = busClient.CreateReceiver(Constants.ProductsQueueName);

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                logger.LogInformation("Looking for messages");

                var busMessage = await receiver.ReceiveMessageAsync(cancellationToken: stoppingToken);
                if (busMessage is null)
                {
                    await Task.Delay(NotFoundMessageDelayMilliseconds, stoppingToken);
                    continue;
                }

                logger.LogInformation("Message found, starting processing");

                using var _ = logger.BeginScope(
                    "Received new message {MessageId} from message bus. CorrelationId: {CorrelationId}",
                    busMessage.MessageId,
                    busMessage.CorrelationId);

                using var serviceScope = serviceScopeFactory.CreateScope();
                var handler = serviceScope.ServiceProvider.GetRequiredService<IOutboxMessageHandler>();

                var outboxMessage = busMessage!.Body.ToObjectFromJson<BaseMessage>(_serializationOptions);

                await handler.Handle(outboxMessage, stoppingToken);

                await receiver.CompleteMessageAsync(busMessage, cancellationToken: stoppingToken);

                logger.LogInformation("Message processed successfully");
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Cannot process message");
            }
        }
    }
}

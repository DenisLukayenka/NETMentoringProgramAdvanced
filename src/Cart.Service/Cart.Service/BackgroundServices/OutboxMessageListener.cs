

using Azure.Messaging.ServiceBus;

namespace Cart.Service.BackgroundServices;

internal class OutboxMessageListener(ServiceBusClient busClient) : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        var receiver = busClient.CreateReceiver("ProductUpdatedEvent", new ServiceBusReceiverOptions()
        {
            ReceiveMode = ServiceBusReceiveMode.PeekLock
        });

        while (true)
        {
            var message = await receiver.ReceiveMessageAsync(cancellationToken: stoppingToken);
            var body = message.Body.ToString();

            Console.WriteLine(body);

            await receiver.CompleteMessageAsync(message, cancellationToken: stoppingToken);
        }
    }
}

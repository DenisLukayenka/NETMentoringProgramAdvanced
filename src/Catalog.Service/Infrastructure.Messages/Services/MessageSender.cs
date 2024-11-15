using ApplicationCore.Common.Interfaces;
using Azure.Messaging.ServiceBus;
using Domain.Events;

namespace Infrastructure.Messages.Services;

internal class MessageSender(ServiceBusClient busClient) : IMessageSender
{
    private static Dictionary<string, string> _eventQueueMap = new()
    {
        { nameof(ProductDeletedEvent), nameof(ProductDeletedEvent)},
        { nameof(ProductUpdatedEvent), nameof(ProductUpdatedEvent)},
    };

    public async Task SendOutboxEvent(BaseEvent outboxEvent, CancellationToken cancellationToken)
    {
        var queueName = _eventQueueMap[outboxEvent.Discriminator];
        var sender = busClient.CreateSender(queueName);

        var busMessage = new ServiceBusMessage(outboxEvent.Discriminator);

        await sender.SendMessagesAsync([busMessage], cancellationToken);
    }
}

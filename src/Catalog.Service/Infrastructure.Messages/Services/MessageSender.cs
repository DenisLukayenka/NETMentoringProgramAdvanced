using System.Text.Json;
using ApplicationCore.Common.Interfaces;
using Azure.Messaging.ServiceBus;
using Lunis.SharedLibs.Catalog.OutboxMessages;

namespace Infrastructure.Messages.Services;

internal class MessageSender(ServiceBusClient busClient) : IMessageSender
{
    public async Task SendMessage(string queueName, BaseMessage message, CancellationToken cancellationToken)
    {
        var sender = busClient.CreateSender(queueName);
        var payload = JsonSerializer.Serialize(message);

        var busMessage = new ServiceBusMessage(payload);

        await sender.SendMessagesAsync([busMessage], cancellationToken);
    }
}

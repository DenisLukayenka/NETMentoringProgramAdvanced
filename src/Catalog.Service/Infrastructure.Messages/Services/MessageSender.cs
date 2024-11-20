using System.Text.Json;
using ApplicationCore.Common.Interfaces;
using Azure.Messaging.ServiceBus;
using Lunis.SharedLibs.Catalog.OutboxEvents;

namespace Infrastructure.Messages.Services;

internal class MessageSender(ServiceBusClient busClient) : IMessageSender
{
    private const string CatalogQueueName = "Catalog.Service.OutboxEvents";

    public async Task SendOutboxEvent(BaseMessage message, CancellationToken cancellationToken)
    {
        var sender = busClient.CreateSender(CatalogQueueName);
        var payload = JsonSerializer.Serialize(message);

        var busMessage = new ServiceBusMessage(payload);

        await sender.SendMessagesAsync([busMessage], cancellationToken);
    }
}

using Lunis.SharedLibs.Catalog.OutboxMessages;

namespace ApplicationCore.Common.Interfaces;

public interface IMessageSender
{
    Task SendMessage(string queueName, BaseMessage message, CancellationToken cancellationToken);
}

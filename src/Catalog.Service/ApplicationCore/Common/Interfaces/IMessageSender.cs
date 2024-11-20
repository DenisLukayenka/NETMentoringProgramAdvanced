using Lunis.SharedLibs.Catalog.OutboxEvents;

namespace ApplicationCore.Common.Interfaces;

public interface IMessageSender
{
    Task SendOutboxEvent(BaseMessage message, CancellationToken cancellationToken);
}

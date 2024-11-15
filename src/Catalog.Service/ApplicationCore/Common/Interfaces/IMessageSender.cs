using Domain.Events;

namespace ApplicationCore.Common.Interfaces;

public interface IMessageSender
{
    Task SendOutboxEvent(BaseEvent outboxEvent, CancellationToken cancellationToken);
}

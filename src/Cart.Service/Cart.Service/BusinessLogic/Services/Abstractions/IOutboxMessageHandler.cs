using Lunis.SharedLibs.Catalog.OutboxMessages;

namespace Cart.Service.BusinessLogic.Services.Abstractions;

public interface IOutboxMessageHandler
{
    Task Handle(BaseMessage? message, CancellationToken cancellationToken);
}

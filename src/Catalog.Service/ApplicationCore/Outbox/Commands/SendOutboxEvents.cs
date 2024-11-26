using ApplicationCore.Outbox.Mappings;
using Domain.Events;
using Lunis.SharedLibs.Catalog.OutboxMessages;

namespace ApplicationCore.Outbox.Commands;

public record SendOutboxMessagesCommand() : IRequest;

public class SendOutboxMessagesHandler(IOutboxEventsRepository repository, IMessageSender messageSender) : IRequestHandler<SendOutboxMessagesCommand>
{
    // The method does not guarantee one message per one db record
    public async Task Handle(SendOutboxMessagesCommand request, CancellationToken cancellationToken)
    {
        var entity = await GetNextUnprocessedEvent(cancellationToken);

        while (entity != null)
        {
            var message = entity.Map();
            await messageSender.SendMessage(Constants.ProductsQueueName, message, cancellationToken);

            await MarkEventAsProcessed(entity, cancellationToken);
            entity = await GetNextUnprocessedEvent(cancellationToken);
        }
    }

    private async Task<BaseEvent?> GetNextUnprocessedEvent(CancellationToken cancellationToken)
    {
        var entity = await repository.GetNextUnprocessed(cancellationToken);

        return entity;
    }

    private async Task MarkEventAsProcessed(BaseEvent entity, CancellationToken cancellationToken)
    {
        entity.Processed = true;
        entity.ProcessedDate = DateTime.UtcNow;

        await repository.Update(entity, cancellationToken);
    }
}

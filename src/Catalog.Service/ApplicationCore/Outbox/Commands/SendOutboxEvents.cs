using Domain.Events;

namespace ApplicationCore.Outbox.Commands;

public record SendOutboxEventsCommand() : IRequest;

public class SendOutboxEventsHandler(IOutboxEventsRepository repository) : IRequestHandler<SendOutboxEventsCommand>
{
    public async Task Handle(SendOutboxEventsCommand request, CancellationToken cancellationToken)
    {
        var entity = await GetNextUnprocessedEvent(cancellationToken);

        while (entity != null)
        {
            // TODO: Send message to Azure Message Queue

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

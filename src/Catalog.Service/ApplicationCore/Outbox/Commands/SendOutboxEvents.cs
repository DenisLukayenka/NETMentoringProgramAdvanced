using Domain.Events;

namespace ApplicationCore.Outbox.Commands;

public record SendOutboxEventsCommand() : IRequest;

public class SendOutboxEventsHandler(IOutboxEventsRepository repository, IMessageSender messageSender) : IRequestHandler<SendOutboxEventsCommand>
{
    // The method does not guarantee one message per one db record
    public async Task Handle(SendOutboxEventsCommand request, CancellationToken cancellationToken)
    {
        var entity = await GetNextUnprocessedEvent(cancellationToken);

        while (entity != null)
        {
            await messageSender.SendOutboxEvent(entity, cancellationToken);

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

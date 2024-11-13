using Domain.Events;

namespace ApplicationCore.Common.Interfaces;

public interface IOutboxEventsRepository
{
    public Task<BaseEvent?> GetNextUnprocessed(CancellationToken cancellationToken);
    public Task Update(BaseEvent outboxEvent, CancellationToken cancellationToken);
}

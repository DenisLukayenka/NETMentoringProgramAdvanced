using ApplicationCore.Common.Interfaces;
using Domain.Events;
using Infrastructure.Database.Abstractions;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Database.Data.Repositories;

internal class OutboxEventsRepository(IApplicationDbContext context) : IOutboxEventsRepository
{
    public async Task<BaseEvent?> GetNextUnprocessed(CancellationToken cancellationToken)
    {
        var entity = await context
            .Events
            .AsNoTracking()
            .FirstOrDefaultAsync(x => x.Processed == false, cancellationToken);

        return entity;
    }

    public async Task Update(BaseEvent outboxEvent, CancellationToken cancellationToken)
    {
        context.Events.Update(outboxEvent);

        await context.SaveChangesAsync(cancellationToken);
    }
}

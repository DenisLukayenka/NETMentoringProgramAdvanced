using Domain.Entities;
using Domain.Events;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using System.Text.Json;

namespace Infrastructure.Data.Interceptors;

public class PopulateEventsInterceptor : SaveChangesInterceptor
{
    public override InterceptionResult<int> SavingChanges(DbContextEventData eventData, InterceptionResult<int> result)
    {
        TrackProductsEvents(eventData.Context, default).GetAwaiter().GetResult();

        return base.SavingChanges(eventData, result);
    }

    public override async ValueTask<InterceptionResult<int>> SavingChangesAsync(DbContextEventData eventData, InterceptionResult<int> result, CancellationToken cancellationToken = default)
    {
        await TrackProductsEvents(eventData.Context, cancellationToken).ConfigureAwait(false);
        return await base.SavingChangesAsync(eventData, result, cancellationToken).ConfigureAwait(false);
    }

    public async Task TrackProductsEvents(DbContext? context, CancellationToken cancellationToken = default)
    {
        if (context is null)
            return;

        var deletedProductEvents = context
            .ChangeTracker
            .Entries<Product>()
            .Where(x => x.State == EntityState.Deleted)
            .Select(x => new ProductDeletedEvent(x.Entity.Id))
            .ToList();

        var updatedProductEvents = context
            .ChangeTracker
            .Entries<Product>()
            .Where(x => x.State == EntityState.Modified)
            .Select(x => new ProductUpdatedEvent(JsonSerializer.Serialize(x.Entity)))
            .ToList();

        await context.AddRangeAsync(deletedProductEvents, cancellationToken);
        await context.AddRangeAsync(updatedProductEvents, cancellationToken);
    }
}

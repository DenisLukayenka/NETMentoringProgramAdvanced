using Domain.Entities;
using Domain.Events;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Abstractions;

internal interface IApplicationDbContext
{
    DbSet<Category> Categories { get; }
    DbSet<Product> Products { get; }
    DbSet<BaseEvent> Events { get; }

    Task<int> SaveChangesAsync(CancellationToken cancellationToken);
}

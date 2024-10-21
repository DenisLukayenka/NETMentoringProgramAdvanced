using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Abstractions;

internal interface IApplicationDbContext
{
    DbSet<Category> Categories { get; }
    DbSet<Product> Products { get; }
    Task<int> SaveChangesAsync(CancellationToken cancellationToken);
}

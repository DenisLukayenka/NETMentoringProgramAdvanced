using ApplicationCore.Common.Interfaces;
using Domain.Entities;
using Infrastructure.Abstractions;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data.Repositories;

internal class ProductRepository(IApplicationDbContext context) : IProductRepository
{
    public async Task<Product> Add(Product product, CancellationToken cancellationToken = default)
    {
        context.Products.Add(product);
        await context.SaveChangesAsync(cancellationToken);

        return product;
    }

    public async Task Delete(Product product, CancellationToken cancellationToken = default)
    {
        context.Products.Remove(product);
        await context.SaveChangesAsync(cancellationToken);
    }

    public async Task<Product> Get(int id, CancellationToken cancellationToken = default)
    {
        var entity = await context.Products
            .Where(x => x.Id == id)
            .AsNoTracking()
            .FirstAsync(cancellationToken);

        return entity;
    }

    public async Task<Product[]> List(CancellationToken cancellationToken = default)
    {
        var entities = await context.Products
            .AsNoTracking()
            .ToArrayAsync(cancellationToken);

        return entities;
    }

    public async Task Update(Product product, CancellationToken cancellationToken = default)
    {
        context.Products.Update(product);
        await context.SaveChangesAsync(cancellationToken);
    }
}

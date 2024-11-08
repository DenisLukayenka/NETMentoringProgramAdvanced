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

    public async Task<Product[]> List(int? categoryId, int currentPage, int pageSize, CancellationToken cancellationToken = default)
    {
        var skipCount = pageSize * currentPage;

        IQueryable<Product> products = context.Products;

        if (categoryId.HasValue)
        {
            products = products
                .Where(x => x.CategoryId == categoryId);
        }

        // Apply pagination
        products = products
            .OrderBy(x => x.Id)
            .Skip(skipCount)
            .Take(pageSize);

        var entities = await products
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

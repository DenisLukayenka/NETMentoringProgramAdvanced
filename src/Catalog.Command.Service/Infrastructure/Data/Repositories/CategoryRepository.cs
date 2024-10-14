using ApplicationCore.Common.Interfaces;
using Domain.Entities;
using Infrastructure.Abstractions;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Data.Repositories;

internal class CategoryRepository(IApplicationDbContext context) : ICategoryRepository
{
    public async Task<Category> Add(Category category, CancellationToken cancellationToken = default)
    {
        context.Categories.Add(category);
        await context.SaveChangesAsync(cancellationToken);

        return category;
    }

    public async Task Delete(Category category, CancellationToken cancellationToken = default)
    {
        context.Categories.Remove(category);
        await context.SaveChangesAsync(cancellationToken);
    }

    public async Task<Category> Get(int id, CancellationToken cancellationToken = default)
    {
        var entity = await context.Categories
            .Where(x => x.Id == id)
            .AsNoTracking()
            .FirstAsync(cancellationToken);

        return entity;
    }

    public async Task<Category[]> List(CancellationToken cancellationToken = default)
    {
        var entities = await context.Categories
            .AsNoTracking()
            .ToArrayAsync(cancellationToken);

        return entities;
    }

    public async Task Update(Category category, CancellationToken cancellationToken = default)
    {
        context.Categories.Update(category);
        await context.SaveChangesAsync(cancellationToken);
    }
}

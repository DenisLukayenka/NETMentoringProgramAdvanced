using Domain.Entities;

namespace ApplicationCore.Common.Interfaces;

public interface ICategoryRepository
{
    Task<Category> Get(int id, CancellationToken cancellationToken = default);
    Task<Category[]> List(int? parentCategory, CancellationToken cancellationToken = default);
    Task<Category> Add(Category category, CancellationToken cancellationToken = default);
    Task Update(Category category, CancellationToken cancellationToken = default);
    Task Delete(Category category, CancellationToken cancellationToken = default);
}

using Domain.Entities;

namespace ApplicationCore.Interfaces;

public interface ICategoryRepository
{
    Task<Category> Get(int id, CancellationToken cancellationToken = default);
    Task<Category[]> List(CancellationToken cancellationToken = default);
    Task<Category> Add(Category category, CancellationToken cancellationToken = default);
    Task Update(Category category, CancellationToken cancellationToken = default);
    Task Delete(int id, CancellationToken cancellationToken = default);
}

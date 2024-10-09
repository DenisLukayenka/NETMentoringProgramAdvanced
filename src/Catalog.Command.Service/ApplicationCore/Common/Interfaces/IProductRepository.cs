using Domain.Entities;

namespace ApplicationCore.Common.Interfaces;

public interface IProductRepository
{
    Task<Product> Get(int id, CancellationToken cancellationToken = default);
    Task<Product[]> List(CancellationToken cancellationToken = default);

    Task<Product> Add(Product category, CancellationToken cancellationToken = default);
    Task Update(Product category, CancellationToken cancellationToken = default);
    Task Delete(int id, CancellationToken cancellationToken = default);
}

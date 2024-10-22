using Domain.Entities;

namespace ApplicationCore.Common.Interfaces;

public interface IProductRepository
{
    Task<Product> Get(int id, CancellationToken cancellationToken = default);
    Task<Product[]> List(int? categoryId, int currentPage, int pageSize, CancellationToken cancellationToken = default);

    Task<Product> Add(Product product, CancellationToken cancellationToken = default);
    Task Update(Product product, CancellationToken cancellationToken = default);
    Task Delete(Product product, CancellationToken cancellationToken = default);
}

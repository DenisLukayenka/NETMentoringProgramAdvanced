using ApplicationCore.Common.Interfaces;
using Domain.Entities;

namespace ApplicationCore.Products.Queries.ListProducts;

public record ListProductsQuery : IRequest<Product[]>;

public class ListProductsQueryHandler(IProductRepository repository) : IRequestHandler<ListProductsQuery, Product[]>
{
    public async Task<Product[]> Handle(ListProductsQuery request, CancellationToken cancellationToken)
    {
        var products = await repository.List(cancellationToken);

        return products;
    }
}

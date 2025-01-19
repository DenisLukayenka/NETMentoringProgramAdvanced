using Domain.Entities;

namespace ApplicationCore.Products.Queries.ListProducts;

public record ListProductsQuery(int? CategoryId, int? CurrentPage, int? PageSize) : IRequest<Product[]>;

public class ListProductsQueryHandler(IProductRepository repository) : IRequestHandler<ListProductsQuery, Product[]>
{
    private const int DefaultCurrentPage = 0;
    private const int DefaultPageSize = 10;

    public async Task<Product[]> Handle(ListProductsQuery request, CancellationToken cancellationToken)
    {
        var products = await repository.List(
            request.CategoryId,
            request.CurrentPage.GetValueOrDefault(DefaultCurrentPage),
            request.PageSize.GetValueOrDefault(DefaultPageSize),
            cancellationToken);

        return products;
    }
}

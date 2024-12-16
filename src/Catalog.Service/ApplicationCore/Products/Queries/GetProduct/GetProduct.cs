using Domain.Entities;

namespace ApplicationCore.Products.Queries.GetProduct;

public record GetProductQuery(int ProductId) : IRequest<Product>;

public class GetProductQueryHandler(IProductRepository repository) : IRequestHandler<GetProductQuery, Product>
{
    public async Task<Product> Handle(GetProductQuery request, CancellationToken cancellationToken)
    {
        var product = await repository.Get(request.ProductId, cancellationToken);
        if (product is null)
            throw new EntityNotFoundException();

        return product;
    }
}

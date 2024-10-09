using ApplicationCore.Common.Interfaces;
using Domain.Entities;

namespace ApplicationCore.Products.Queries.GetProductById;

public record GetProductByIdQuery(int ProductId) : IRequest<Product>;

public class GetProductByIdQueryHandler(IProductRepository repository) : IRequestHandler<GetProductByIdQuery, Product>
{
    public async Task<Product> Handle(GetProductByIdQuery request, CancellationToken cancellationToken)
    {
        var product = await repository.Get(request.ProductId, cancellationToken);
        if (product is null)
            throw new EntityNotFoundException();

        return product;
    }
}

using Domain.Entities;

namespace ApplicationCore.Products.Commands.CreateProduct;

public record CreateProductCommand(
    string Name,
    string Description,
    string? Image,
    int CategoryId,
    decimal Price,
    int Amount) : IRequest<int>;

public class CreateProductCommandHandler(
    IProductRepository productRepository,
    ICategoryRepository categoryRepository) : IRequestHandler<CreateProductCommand, int>
{
    public async Task<int> Handle(CreateProductCommand request, CancellationToken cancellationToken)
    {
        var category = await categoryRepository.Get(request.CategoryId, cancellationToken);
        if (category is null)
            throw new EntityNotFoundException();

        var entity = new Product()
        {
            Name = request.Name,
            Description = request.Description,
            Image = request.Image,
            Category = category,
            Price = request.Price,
            Amount = request.Amount
        };

        entity = await productRepository.Add(entity, cancellationToken);

        return entity.Id;
    }
}

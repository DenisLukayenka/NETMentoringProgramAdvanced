namespace ApplicationCore.Products.Commands.UpdateProduct;

public record UpdateProductCommand(
    int ProductId,
    string? Name,
    string? Description,
    string? Image,
    int? CategoryId,
    decimal? Price,
    int? Amount) : IRequest;

public class UpdateProductCommandHandler(
    IProductRepository productRepository,
    ICategoryRepository categoryRepository) : IRequestHandler<UpdateProductCommand>
{
    public async Task Handle(UpdateProductCommand request, CancellationToken cancellationToken)
    {
        var entity = await productRepository.Get(request.ProductId, cancellationToken);
        if (entity is null)
            throw new EntityNotFoundException();

        if (!string.IsNullOrEmpty(request.Name))
        {
            entity.Name = request.Name;
        }
        if (!string.IsNullOrEmpty(request.Description))
        {
            entity.Description = request.Description;
        }
        if (!string.IsNullOrEmpty(request.Image))
        {
            entity.Image = request.Image;
        }
        if (request.CategoryId.HasValue)
        {
            var category = await categoryRepository.Get(request.CategoryId.Value, cancellationToken);
            if (category is null)
                throw new EntityNotFoundException();

            entity.CategoryId = category.Id;
        }
        if (request.Price.HasValue)
        {
            entity.Price = request.Price.Value;
        }
        if (request.Amount.HasValue)
        {
            entity.Amount = request.Amount.Value;
        }

        await productRepository.Update(entity, cancellationToken);
    }
}

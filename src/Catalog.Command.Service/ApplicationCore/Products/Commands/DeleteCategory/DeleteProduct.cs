namespace ApplicationCore.Products.Commands.DeleteProduct;

public record DeleteProductCommand(int ProductId) : IRequest;

public class DeleteProductCommandHandler(IProductRepository repository) : IRequestHandler<DeleteProductCommand>
{
    public async Task Handle(DeleteProductCommand request, CancellationToken cancellationToken)
    {
        var entity = await repository.Get(request.ProductId, cancellationToken);

        if (entity is null)
            throw new EntityNotFoundException();

        await repository.Delete(entity, cancellationToken);
    }
}

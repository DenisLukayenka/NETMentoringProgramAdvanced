using ApplicationCore.Common.Interfaces;

namespace ApplicationCore.Categories.Commands.DeleteCategory;

public record DeleteCategoryCommand(int CategoryId) : IRequest;

public class DeleteCategoryCommandHandler(ICategoryRepository repository) : IRequestHandler<DeleteCategoryCommand>
{
    public async Task Handle(DeleteCategoryCommand request, CancellationToken cancellationToken)
    {
        var entity = await repository.Get(request.CategoryId, cancellationToken);

        if (entity is null)
            throw new EntityNotFoundException();

        await repository.Delete(entity.Id, cancellationToken);
    }
}

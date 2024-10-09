using ApplicationCore.Common.Interfaces;

namespace ApplicationCore.Categories.Commands.UpdateCategory;

public record UpdateCategoryCommand(int CategoryId, string? Name, string? Image) : IRequest;

public class UpdateCategoryCommandHandler(ICategoryRepository repository) : IRequestHandler<UpdateCategoryCommand>
{
    public async Task Handle(UpdateCategoryCommand request, CancellationToken cancellationToken)
    {
        var entity = await repository.Get(request.CategoryId, cancellationToken);

        if (entity is null)
            throw new EntityNotFoundException();

        if (!string.IsNullOrEmpty(request.Name))
        {
            entity.Name = request.Name;
        }

        if (!string.IsNullOrEmpty(request.Image))
        {
            entity.Image = request.Image;
        }

        await repository.Update(entity, cancellationToken);
    }
}

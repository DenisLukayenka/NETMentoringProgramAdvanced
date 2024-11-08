using Domain.Entities;

namespace ApplicationCore.Categories.Commands.CreateCategory;

public record CreateCategoryCommand(string Name, string? Image, int? ParentCategoryId) : IRequest<Category>;

public class CreateCategoryCommandHandler(ICategoryRepository repository) : IRequestHandler<CreateCategoryCommand, Category>
{
    public async Task<Category> Handle(CreateCategoryCommand request, CancellationToken cancellationToken)
    {
        Category? parentCategory = null;
        if (request.ParentCategoryId.HasValue)
        {
            parentCategory = await repository.Get(request.ParentCategoryId.Value, cancellationToken);
            if (parentCategory is null)
                throw new EntityNotFoundException();
        }

        var entity = new Category()
        {
            Name = request.Name,
            Image = request.Image,
            ParentCategoryId = parentCategory?.Id
        };

        entity = await repository.Add(entity, cancellationToken);

        return entity;
    }
}

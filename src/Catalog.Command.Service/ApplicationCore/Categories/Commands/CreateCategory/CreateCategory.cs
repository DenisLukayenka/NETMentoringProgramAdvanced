using ApplicationCore.Common.Interfaces;
using Domain.Entities;

namespace ApplicationCore.Categories.Commands.CreateCategory;

public record CreateCategoryCommand(string Name, string? Image, int? ParentCategoryId) : IRequest<int>;

public class CreateCategoryCommandHandler(ICategoryRepository repository) : IRequestHandler<CreateCategoryCommand, int>
{
    public async Task<int> Handle(CreateCategoryCommand request, CancellationToken cancellationToken)
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
            ParentCategory = parentCategory
        };

        entity = await repository.Add(entity, cancellationToken);

        return entity.Id;
    }
}

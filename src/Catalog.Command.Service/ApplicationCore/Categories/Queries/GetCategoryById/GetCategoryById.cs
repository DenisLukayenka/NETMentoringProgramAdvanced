using ApplicationCore.Common.Interfaces;
using Domain.Entities;

namespace ApplicationCore.Categories.Queries.GetCategoryById;

public record GetCategoryByIdQuery(int CategoryId) : IRequest<Category>;

public class GetCategoryByIdQueryHandler(ICategoryRepository categoryRepository) : IRequestHandler<GetCategoryByIdQuery, Category>
{
    public async Task<Category> Handle(GetCategoryByIdQuery request, CancellationToken cancellationToken)
    {
        var category = await categoryRepository.Get(request.CategoryId, cancellationToken);
        if (category is null)
            throw new EntityNotFoundException();

        return category;
    }
}

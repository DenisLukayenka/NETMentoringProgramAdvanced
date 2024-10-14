using Domain.Entities;

namespace ApplicationCore.Categories.Queries.ListCategories;

public record ListCategoriesQuery : IRequest<Category[]>;

public class ListCategoriesQueryHandler(ICategoryRepository categoryRepository) : IRequestHandler<ListCategoriesQuery, Category[]>
{
    public async Task<Category[]> Handle(ListCategoriesQuery request, CancellationToken cancellationToken)
    {
        var categories = await categoryRepository.List(cancellationToken);

        return categories;
    }
}

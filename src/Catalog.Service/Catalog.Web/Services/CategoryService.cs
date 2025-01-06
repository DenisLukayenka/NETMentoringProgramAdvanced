using Catalog.Web.Models;
using Catalog.Web.Options;
using Microsoft.Identity.Abstractions;

namespace Catalog.Web.Services;

public class CategoryService(
    IDownstreamApi categoryApi,
    IHttpContextAccessor contextAccessor) : ICategoryService
{
    public async Task Create(Category category, CancellationToken cancellationToken)
    {
        var context = contextAccessor.HttpContext;

        await categoryApi.PostForUserAsync(
            serviceName: nameof(DownstreamApisOptions.CategoriesCreate),
            input: category,
            user: context.User,
            cancellationToken: cancellationToken);
    }

    public async Task<IEnumerable<Category>> List(CancellationToken cancellationToken)
    {
        var context = contextAccessor.HttpContext;

        var categories = await categoryApi.CallApiForUserAsync<Category[]>(nameof(DownstreamApisOptions.CategoriesList), user: context.User, cancellationToken: cancellationToken);

        return categories ?? [];
    }
}

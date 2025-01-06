using Catalog.Web.Models;

namespace Catalog.Web.Services;

public interface ICategoryService
{
    Task<IEnumerable<Category>> List(CancellationToken cancellationToken);
    Task Create(Category category, CancellationToken cancellationToken);
}

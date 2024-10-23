using ApplicationCore.Categories.Queries.ListCategories;

namespace Catalog.Queries.Categories;

public class ListCategories(ILogger<ListCategories> logger, IMediator sender)
{
    [Function("ListCategories")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "categories")] HttpRequest req,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("C# HTTP trigger function processed a request.");

        var categories = await sender.Send(new ListCategoriesQuery(), cancellationToken);

        return new OkObjectResult(categories);
    }
}

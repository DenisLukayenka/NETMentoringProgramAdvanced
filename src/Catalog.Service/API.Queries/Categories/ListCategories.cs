using ApplicationCore.Categories.Queries.ListCategories;

namespace API.Queries.Categories;

public class ListCategories(ILogger<ListCategories> logger, IMediator sender)
{
    [Function("ListCategories")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "get", Route = "categories")] HttpRequest req,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(ListCategories));

        var categories = await sender.Send(new ListCategoriesQuery(), cancellationToken);

        return new OkObjectResult(categories);
    }
}

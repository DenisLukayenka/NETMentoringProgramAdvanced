using ApplicationCore.Categories.Commands.CreateCategory;

namespace Catalog.Commands.Categories;

public class CreateCategory(ILogger<CreateCategory> logger, IMediator sender)
{
    [Function("CreateCategory")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "categories")] HttpRequest req,
        [FromBody] CreateCategoryCommand command,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("C# HTTP trigger function processed a request.");

        var category = await sender.Send(command, cancellationToken);

        return new OkObjectResult(category)
        {
            StatusCode = (int)HttpStatusCode.Created
        };
    }
}

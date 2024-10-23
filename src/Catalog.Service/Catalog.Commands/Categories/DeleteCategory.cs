using ApplicationCore.Categories.Commands.DeleteCategory;

namespace Catalog.Commands.Categories;

public class DeleteCategory(ILogger<UpdateCategory> logger, IMediator sender)
{
    [Function("DeleteCategory")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "delete", Route = "categories/{categoryId:int}")] HttpRequest req,
        int categoryId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("C# HTTP trigger function processed a request.");

        var command = new DeleteCategoryCommand(categoryId);
        await sender.Send(command, cancellationToken);

        return new OkResult();
    }
}
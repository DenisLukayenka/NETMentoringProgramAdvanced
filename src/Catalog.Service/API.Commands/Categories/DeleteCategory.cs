using ApplicationCore.Categories.Commands.DeleteCategory;

namespace API.Commands.Categories;

public class DeleteCategory(ILogger<UpdateCategory> logger, IMediator sender)
{
    [Function("DeleteCategory")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "delete", Route = "categories/{categoryId:int}")] HttpRequest req,
        int categoryId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(DeleteCategory));

        var command = new DeleteCategoryCommand(categoryId);
        await sender.Send(command, cancellationToken);

        return new OkResult();
    }
}

using ApplicationCore.Categories.Commands.UpdateCategory;

namespace API.Commands.Categories;

public class UpdateCategory(ILogger<UpdateCategory> logger, IMediator sender)
{
    [Function("UpdateCategory")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "put", Route = "categories/{categoryId:int}")] HttpRequest req,
        [FromBody] UpdateCategoryCommand command,
        int categoryId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(UpdateCategory));

        command = command with
        {
            CategoryId = categoryId,
        };

        await sender.Send(command, cancellationToken);

        return new OkResult();
    }
}

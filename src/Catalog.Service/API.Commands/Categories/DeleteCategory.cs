using ApplicationCore.Categories.Commands.DeleteCategory;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.OpenApi.Models;

namespace API.Commands.Categories;

public class DeleteCategory(ILogger<UpdateCategory> logger, IMediator sender)
{
    [Function(nameof(DeleteCategory))]
    [OpenApiOperation(operationId: nameof(DeleteCategory), tags: ["Categories"])]
    [OpenApiParameter(nameof(categoryId), Required = true, In = ParameterLocation.Path, Type = typeof(int))]
    [OpenApiResponseWithoutBody(statusCode: HttpStatusCode.OK)]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "delete", Route = "categories/{categoryId:int}")] HttpRequest req,
        int categoryId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(DeleteCategory));

        var command = new DeleteCategoryCommand(categoryId);
        await sender.Send(command, cancellationToken);

        return new OkResult();
    }
}

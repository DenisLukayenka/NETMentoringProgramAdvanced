using ApplicationCore.Categories.Commands.UpdateCategory;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.OpenApi.Models;

namespace API.Commands.Categories;

public class UpdateCategory(ILogger<UpdateCategory> logger, IMediator sender)
{
    [Function(nameof(UpdateCategory))]
    [OpenApiOperation(operationId: nameof(UpdateCategory), tags: ["Categories"])]
    [OpenApiParameter(nameof(categoryId), Required = true, In = ParameterLocation.Path, Type = typeof(int))]
    [OpenApiRequestBody(MediaTypeNames.Application.Json, typeof(UpdateCategoryCommand))]
    [OpenApiResponseWithoutBody(statusCode: HttpStatusCode.OK)]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "put", Route = "categories/{categoryId:int}")] HttpRequest req,
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

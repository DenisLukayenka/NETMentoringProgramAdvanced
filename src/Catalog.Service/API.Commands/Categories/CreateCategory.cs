using ApplicationCore.Categories.Commands.CreateCategory;
using Domain.Entities;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;

namespace API.Commands.Categories;

public class CreateCategory(ILogger<CreateCategory> logger, IMediator sender)
{
    [Function(nameof(CreateCategory))]
    [OpenApiOperation(operationId: nameof(CreateCategory), tags: ["Categories"])]
    [OpenApiRequestBody(MediaTypeNames.Application.Json, typeof(CreateCategoryCommand))]
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.Created, contentType: MediaTypeNames.Application.Json, bodyType: typeof(Category))]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "post", Route = "categories")] HttpRequest req,
        [FromBody] CreateCategoryCommand command,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(CreateCategory));

        var category = await sender.Send(command, cancellationToken);

        return new OkObjectResult(category)
        {
            StatusCode = (int)HttpStatusCode.Created
        };
    }
}

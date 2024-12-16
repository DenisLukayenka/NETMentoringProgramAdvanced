using ApplicationCore.Categories.Queries.ListCategories;
using Domain.Entities;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;

namespace API.Queries.Categories;

public class ListCategories(ILogger<ListCategories> logger, IMediator sender)
{
    [Function(nameof(ListCategories))]
    [OpenApiOperation(operationId: nameof(ListCategories), tags: ["Categories"])]
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: MediaTypeNames.Application.Json, bodyType: typeof(Category[]))]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "get", Route = "categories")] HttpRequest req,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(ListCategories));

        var categories = await sender.Send(new ListCategoriesQuery(), cancellationToken);

        return new OkObjectResult(categories);
    }
}

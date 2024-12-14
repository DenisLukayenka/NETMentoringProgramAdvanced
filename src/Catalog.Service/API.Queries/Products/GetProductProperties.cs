using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;

namespace API.Queries.Products;

public class GetProductProperties(ILogger<GetProductProperties> logger)
{
    [Function(nameof(GetProductProperties))]
    [OpenApiOperation(operationId: nameof(GetProductProperties), tags: ["Products"])]
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: MediaTypeNames.Application.Json, bodyType: typeof(Dictionary<string, string>))]
    [OpenApiResponseWithoutBody(statusCode: HttpStatusCode.NotFound)]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products/{productId:int}/properties")] HttpRequest req)
    {
        logger.LogInformation("{FunctionName} was called", nameof(GetProductProperties));

        var properties = new Dictionary<string, string>
        {
            { "category", "TestCategory" },
            { "model", "s10" },
            { "quantity", "100" }
        };

        return new OkObjectResult(properties);
    }
}

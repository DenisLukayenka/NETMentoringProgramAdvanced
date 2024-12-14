using ApplicationCore.Products.Queries.GetProduct;
using Domain.Entities;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;

namespace API.Queries.Products;

public class GetProduct(ILogger<GetProduct> logger, IMediator sender)
{
    [Function(nameof(GetProduct))]
    [OpenApiOperation(operationId: nameof(GetProduct), tags: ["Products"])]
    [OpenApiParameter(nameof(productId), Required = true, In = ParameterLocation.Path, Type = typeof(int))]
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: MediaTypeNames.Application.Json, bodyType: typeof(Product))]
    [OpenApiResponseWithoutBody(statusCode: HttpStatusCode.NotFound)]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products/{productId:int}")] HttpRequest req,
        int productId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(GetProduct));

        var product = await sender.Send(new GetProductQuery(productId), cancellationToken);

        return new OkObjectResult(product);
    }
}

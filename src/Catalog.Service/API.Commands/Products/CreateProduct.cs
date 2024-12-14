using ApplicationCore.Products.Commands.CreateProduct;
using Domain.Entities;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;

namespace API.Commands.Products;

public class CreateProduct(ILogger<CreateProduct> logger, IMediator sender)
{
    [Function(nameof(CreateProduct))]
    [OpenApiOperation(operationId: nameof(CreateProduct), tags: ["Products"])]
    [OpenApiRequestBody(MediaTypeNames.Application.Json, typeof(CreateProductCommand))]
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.Created, contentType: MediaTypeNames.Application.Json, bodyType: typeof(Product))]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "products")] HttpRequest req,
        [FromBody] CreateProductCommand command,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(CreateProduct));

        var product = await sender.Send(command, cancellationToken);

        return new OkObjectResult(product)
        {
            StatusCode = (int)HttpStatusCode.Created
        };
    }
}

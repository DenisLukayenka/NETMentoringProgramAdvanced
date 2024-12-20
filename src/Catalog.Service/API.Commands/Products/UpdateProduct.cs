using ApplicationCore.Products.Commands.UpdateProduct;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.OpenApi.Models;

namespace API.Commands.Products;

public class UpdateProduct(ILogger<UpdateProduct> logger, IMediator sender)
{
    [Function(nameof(UpdateProduct))]
    [OpenApiOperation(operationId: nameof(UpdateProduct), tags: ["Products"])]
    [OpenApiParameter(nameof(productId), Required = true, In = ParameterLocation.Path, Type = typeof(int))]
    [OpenApiRequestBody(MediaTypeNames.Application.Json, typeof(UpdateProductCommand))]
    [OpenApiResponseWithoutBody(statusCode: HttpStatusCode.OK)]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Function, "put", Route = "products/{productId:int}")] HttpRequest req,
        [FromBody] UpdateProductCommand command,
        int productId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(UpdateProduct));

        command = command with
        {
            ProductId = productId
        };

        await sender.Send(command, cancellationToken);

        return new OkResult();
    }
}

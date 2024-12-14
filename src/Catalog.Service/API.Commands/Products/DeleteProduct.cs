using ApplicationCore.Products.Commands.DeleteProduct;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;
using Microsoft.OpenApi.Models;

namespace API.Commands.Products;

public class DeleteProduct(ILogger<DeleteProduct> logger, IMediator sender)
{
    [Function(nameof(DeleteProduct))]
    [OpenApiOperation(operationId: nameof(DeleteProduct), tags: ["Products"])]
    [OpenApiParameter(nameof(productId), Required = true, In = ParameterLocation.Path, Type = typeof(int))]
    [OpenApiResponseWithoutBody(statusCode: HttpStatusCode.OK)]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "delete", Route = "products/{productId:int}")] HttpRequest req,
        int productId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(DeleteProduct));

        var command = new DeleteProductCommand(productId);
        await sender.Send(command, cancellationToken);

        return new OkResult();
    }
}

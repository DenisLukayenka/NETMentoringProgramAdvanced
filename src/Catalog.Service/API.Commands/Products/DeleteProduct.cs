using ApplicationCore.Products.Commands.DeleteProduct;

namespace API.Commands.Products;

public class DeleteProduct(ILogger<DeleteProduct> logger, IMediator sender)
{
    [Function("DeleteProduct")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "delete", Route = "products/{productId:int}")] HttpRequest req,
        int productId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("C# HTTP trigger function processed a request.");

        var command = new DeleteProductCommand(productId);
        await sender.Send(command, cancellationToken);

        return new OkResult();
    }
}

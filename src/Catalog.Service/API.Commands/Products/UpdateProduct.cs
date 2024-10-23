using ApplicationCore.Products.Commands.UpdateProduct;

namespace API.Commands.Products;

public class UpdateProduct(ILogger<UpdateProduct> logger, IMediator sender)
{
    [Function("UpdateProduct")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "put", Route = "products/{productId:int}")] HttpRequest req,
        [FromBody] UpdateProductCommand command,
        int productId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("C# HTTP trigger function processed a request.");

        command = command with
        {
            ProductId = productId
        };

        await sender.Send(command, cancellationToken);

        return new OkResult();
    }
}

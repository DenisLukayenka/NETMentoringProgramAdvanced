using ApplicationCore.Products.Queries.GetProduct;

namespace API.Queries.Products;

public class GetProduct(ILogger<GetProduct> logger, IMediator sender)
{
    [Function("GetProduct")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products/{productId:int}")] HttpRequest req,
        int productId,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(GetProduct));

        var products = await sender.Send(new GetProductQuery(productId), cancellationToken);

        return new OkObjectResult(products);
    }
}

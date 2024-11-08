using ApplicationCore.Products.Commands.CreateProduct;

namespace API.Commands.Products;

public class CreateProduct(ILogger<CreateProduct> logger, IMediator sender)
{
    [Function("CreateProduct")]
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

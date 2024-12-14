namespace API.Queries.Products;

public class GetProductProperties(ILogger<GetProductProperties> logger)
{
    [Function("GetProductProperties")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products/{productId:int}/properties")] HttpRequest req)
    {
        logger.LogInformation("{FunctionName} was called", nameof(GetProductProperties));

        var properties = new Dictionary<string, string>
        {
            { "category", "TestCategory" }
        };

        return new OkObjectResult(properties);
    }
}

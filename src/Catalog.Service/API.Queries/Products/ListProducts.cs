using ApplicationCore.Products.Queries.ListProducts;

namespace API.Queries.Products;

public class ListProducts(ILogger<ListProducts> logger, IMediator sender)
{
    [Function("ListProducts")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products")] HttpRequest req,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(ListProducts));

        var currentPage = GetQueryParam(req, nameof(ListProductsQuery.CurrentPage));
        var pageSize = GetQueryParam(req, nameof(ListProductsQuery.PageSize));
        var categoryId = GetQueryParam(req, nameof(ListProductsQuery.CategoryId));

        var products = await sender.Send(new ListProductsQuery(categoryId, currentPage, pageSize), cancellationToken);

        return new OkObjectResult(products);
    }

    private static int? GetQueryParam(HttpRequest req, string key)
    {
        int? value = null;
        if (int.TryParse(req.Query[key].ToString(), out var parsedValue))
            value = parsedValue;

        return value;
    }
}

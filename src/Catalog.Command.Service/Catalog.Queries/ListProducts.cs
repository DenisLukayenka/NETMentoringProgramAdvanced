using ApplicationCore.Products.Queries.ListProducts;

namespace Catalog.Queries;

public class ListProducts(ILogger<ListProducts> logger, IMediator sender)
{
    [Function("ListProducts")]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products/{categoryId:int?}")] HttpRequest req,
        int? categoryId)
    {
        logger.LogInformation("C# HTTP trigger function processed a request.");
        int? currentPage = null;
        if (int.TryParse(req.Query[nameof(ListProductsQuery.CurrentPage)].ToString(), out var parsedCurrentPage))
            currentPage = parsedCurrentPage;

        int? pageSize = null;
        if (int.TryParse(req.Query[nameof(ListProductsQuery.PageSize)].ToString(), out var parsedPageSize))
            pageSize = parsedPageSize;

        var products = await sender.Send(new ListProductsQuery(categoryId, currentPage, pageSize));

        return new OkObjectResult(products);
    }
}

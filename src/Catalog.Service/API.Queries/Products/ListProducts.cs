using ApplicationCore.Products.Queries.ListProducts;
using Domain.Entities;
using Microsoft.Azure.WebJobs.Extensions.OpenApi.Core.Attributes;

namespace API.Queries.Products;

public class ListProducts(ILogger<ListProducts> logger, IMediator sender)
{
    [Function(nameof(ListProducts))]
    [OpenApiOperation(operationId: nameof(ListProducts), tags: ["Products"])]
    [OpenApiParameter(nameof(ListProductsQuery.PageSize), Required = false, In = ParameterLocation.Query, Type = typeof(int?))]
    [OpenApiParameter(nameof(ListProductsQuery.CategoryId), Required = false, In = ParameterLocation.Query, Type = typeof(int?))]
    [OpenApiParameter(nameof(ListProductsQuery.CurrentPage), Required = false, In = ParameterLocation.Query, Type = typeof(int?))]
    [OpenApiResponseWithBody(statusCode: HttpStatusCode.OK, contentType: MediaTypeNames.Application.Json, bodyType: typeof(Product[]))]
    public async Task<IActionResult> Run(
        [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = "products")] HttpRequest req,
        int? pageSize,
        int? categoryId,
        int? currentPage,
        CancellationToken cancellationToken)
    {
        logger.LogInformation("{FunctionName} was called", nameof(ListProducts));

        var products = await sender.Send(new ListProductsQuery(categoryId, currentPage, pageSize), cancellationToken);

        return new OkObjectResult(products);
    }
}

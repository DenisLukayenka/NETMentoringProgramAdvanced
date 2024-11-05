using Cart.Service.BusinessLogic.Services.Abstractions;

namespace Cart.Service.Endpoints;

public static class CartEndpointsV2
{
    private const string CartEndpointsPrefix = "Carts";

    public static WebApplication RegisterCartEndpointsV2(this WebApplication app)
    {
        var endpointsVersion = new Asp.Versioning.ApiVersion(2, 0);
        var versionSet = app.NewApiVersionSet().Build();

        var cartApi = app
            .MapGroup("/api/v{version:apiVersion}")
            .WithApiVersionSet(versionSet)
            .MapToApiVersion(endpointsVersion);

        cartApi
            .MapGet("/carts/{cartId}", GetCartItems)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(GetCartItems)}")
            .Produces<Models.Cart[]>(StatusCodes.Status200OK);

        return app;
    }

    private static async Task<Ok<Models.CartItem[]>> GetCartItems(
        [FromRoute] string cartId,
        [FromServices] ICartService cartService,
        CancellationToken cancellationToken)
    {
        var cart = await cartService.Get(cartId, cancellationToken);

        return TypedResults.Ok(cart?.Items ?? []);
    }
}

using Cart.Service.BusinessLogic.Services.Abstractions;

namespace Cart.Service.Endpoints;

public static class CartItemEndpoints
{
    private const string CartEndpointsPrefix = "CartItems";

    public static WebApplication RegisterCartItemsEndpoints(this WebApplication app)
    {
        var versionSet = app.NewApiVersionSet().Build();

        var cartItemsApi = app
            .MapGroup("/api/v{version:apiVersion}")
            .WithApiVersionSet(versionSet)
            .IsApiVersionNeutral();

        cartItemsApi
            .MapPost("/carts/{cartId}/items", AddCartItem)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(AddCartItem)}")
            .Produces(StatusCodes.Status204NoContent);

        cartItemsApi
            .MapDelete("/carts/{cartId}/items/{itemId:int}", DeleteCartItem)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(DeleteCartItem)}")
            .Produces(StatusCodes.Status204NoContent);

        return app;
    }

    private static async Task<NoContent> AddCartItem(
        [FromRoute] string cartId,
        [FromBody] Models.CartItem item,
        [FromServices] ICartItemService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Add(cartId, item, cancellationToken);

        return TypedResults.NoContent();
    }

    private static async Task<NoContent> DeleteCartItem(
        [FromRoute] string cartId,
        [FromRoute] int itemId,
        [FromServices] ICartItemService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Remove(cartId, itemId, cancellationToken);

        return TypedResults.NoContent();
    }
}

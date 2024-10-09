using Cart.Service.Services.Abstractions;
using Microsoft.AspNetCore.Mvc;

namespace Cart.Service.Endpoints;

public static class CartEndpoints
{
    private const string CartEndpointsPrefix = "Carts";

    public static WebApplication RegisterCartEndpoints(this WebApplication app)
    {
        var cartApi = app.MapGroup("/api");

        cartApi
            .MapGet("cart/{cartId}/items", ListCartItems)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(ListCartItems)}")
            .Produces<Models.Cart[]>(StatusCodes.Status200OK);

        cartApi
            .MapPost("cart/{cartId}/item", AddCartItem)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(AddCartItem)}")
            .Produces(StatusCodes.Status204NoContent);

        cartApi
            .MapDelete("cart/{cartId}/item/{itemId:int}", RemoveCartItem)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(RemoveCartItem)}")
            .Produces(StatusCodes.Status204NoContent);

        cartApi
            .MapDelete("cart/{cartId}/items/clear", ClearCartItems)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(ClearCartItems)}")
            .Produces(StatusCodes.Status204NoContent);

        return app;
    }

    private static async Task<IResult> ListCartItems(
        [FromRoute] string cartId,
        [FromServices] ICartItemService cartService,
        CancellationToken cancellationToken)
    {
        var carts = await cartService.List(cartId, cancellationToken);

        return Results.Ok(carts);
    }

    private static async Task<IResult> AddCartItem(
        [FromRoute] string cartId,
        [FromBody] Models.CartItem item,
        [FromServices] ICartItemService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Add(cartId, item, cancellationToken);

        return Results.NoContent();
    }

    private static async Task<IResult> RemoveCartItem(
        [FromRoute] string cartId,
        [FromRoute] int itemId,
        [FromServices] ICartItemService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Remove(cartId, itemId, cancellationToken);

        return Results.NoContent();
    }

    private static async Task<IResult> ClearCartItems(
        [FromRoute] string cartId,
        [FromServices] ICartItemService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Clear(cartId, cancellationToken);

        return Results.NoContent();
    }
}

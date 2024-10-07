using Cart.Service.Services.Abstractions;
using Microsoft.AspNetCore.Mvc;

namespace Cart.Service.Endpoints;

public static class CartEndpoints
{
    private const string CartEndpointsPrefix = "Carts";

    public static WebApplication RegisterCartEndpoints(this WebApplication app)
    {
        var cartApi = app.MapGroup("/carts");

        cartApi
            .MapGet("/{userId}", ListCarts)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(ListCarts)}")
            .Produces<Models.Cart[]>(StatusCodes.Status200OK);

        cartApi
            .MapPost("/{userId}", AddCart)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(AddCart)}")
            .Produces(StatusCodes.Status204NoContent);

        cartApi
            .MapPost("/{userId}/{cartId:int}", RemoveCart)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(RemoveCart)}")
            .Produces(StatusCodes.Status204NoContent);

        cartApi
            .MapPost("/{userId}/clear", ClearCarts)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(ClearCarts)}")
            .Produces(StatusCodes.Status204NoContent);

        return app;
    }

    private static async Task<IResult> ListCarts(
        [FromRoute] string userId,
        [FromServices] ICartService cartService,
        CancellationToken cancellationToken)
    {
        var carts = await cartService.ListByUser(userId, cancellationToken);

        return Results.Ok(carts);
    }

    private static async Task<IResult> AddCart(
        [FromRoute] string userId,
        [FromBody] Models.Cart cart,
        [FromServices] ICartService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Add(userId, cart, cancellationToken);

        return Results.NoContent();
    }

    private static async Task<IResult> RemoveCart(
        [FromRoute] string userId,
        [FromRoute] int cartId,
        [FromServices] ICartService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Remove(userId, cartId, cancellationToken);

        return Results.NoContent();
    }

    private static async Task<IResult> ClearCarts(
        [FromRoute] string userId,
        [FromServices] ICartService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Clear(userId, cancellationToken);

        return Results.NoContent();
    }
}

using Cart.Service.BusinessLogic.Services.Abstractions;
using Microsoft.AspNetCore.Mvc;

namespace Cart.Service.Endpoints;

public static class CartEndpoints
{
    private const string CartEndpointsPrefix = "Carts";

    public static WebApplication RegisterCartEndpoints(this WebApplication app)
    {
        var versionOne = new Asp.Versioning.ApiVersion(1, 0);
        var versionTwo = new Asp.Versioning.ApiVersion(2, 0);
        var versionSet = app
            .NewApiVersionSet()
            .HasApiVersion(versionOne)
            .HasApiVersion(versionTwo)
            .Build();

        var cartApi = app.MapGroup("/api/v{version:apiVersion}");

        cartApi
            .MapGet("/carts/{cartId}", GetCart)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(GetCart)}")
            .Produces<Models.Cart[]>(StatusCodes.Status200OK)
            .WithApiVersionSet(versionSet)
            .MapToApiVersion(versionOne);

        cartApi
            .MapGet("/carts/{cartId}", GetCartItems)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(GetCartItems)}")
            .Produces<Models.Cart[]>(StatusCodes.Status200OK)
            .WithApiVersionSet(versionSet)
            .MapToApiVersion(versionTwo);

        cartApi
            .MapDelete("/carts/{cartId}", ClearCart)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(ClearCart)}")
            .Produces(StatusCodes.Status204NoContent)
            .WithApiVersionSet(versionSet)
            .IsApiVersionNeutral();

        return app;
    }

    private static async Task<IResult> GetCart(
        [FromRoute] string cartId,
        [FromServices] ICartService cartService,
        CancellationToken cancellationToken)
    {
        var cart = await cartService.Get(cartId, cancellationToken);

        if (cart is null)
            return Results.NotFound();

        return Results.Ok(cart);
    }

    private static async Task<IResult> GetCartItems(
        [FromRoute] string cartId,
        [FromServices] ICartService cartService,
        CancellationToken cancellationToken)
    {
        var cart = await cartService.Get(cartId, cancellationToken);

        return Results.Ok(cart?.Items ?? []);
    }

    private static async Task<IResult> ClearCart(
        [FromRoute] string cartId,
        [FromServices] ICartItemService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Clear(cartId, cancellationToken);

        return Results.NoContent();
    }
}

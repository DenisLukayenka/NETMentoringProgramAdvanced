using Cart.Service.BusinessLogic.Services.Abstractions;
using Microsoft.AspNetCore.Mvc;

namespace Cart.Service.Endpoints;

public static class CartItemEndpoints
{
    private const string CartEndpointsPrefix = "CartItems";

    public static WebApplication RegisterCartItemsEndpoints(this WebApplication app)
    {
        var versionSet = app.NewApiVersionSet()
            .IsApiVersionNeutral()
            .ReportApiVersions()
            .Build();

        var cartItemsApi = app.MapGroup("/api/v{version:apiVersion}");

        cartItemsApi
            .MapPost("/carts/{cartId}/items", AddCartItem)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(AddCartItem)}")
            .Produces(StatusCodes.Status204NoContent)
            .WithApiVersionSet(versionSet);

        cartItemsApi
            .MapDelete("/carts/{cartId}/items/{itemId:int}", DeleteCartItem)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(DeleteCartItem)}")
            .Produces(StatusCodes.Status204NoContent)
            .WithApiVersionSet(versionSet);

        return app;
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

    private static async Task<IResult> DeleteCartItem(
        [FromRoute] string cartId,
        [FromRoute] int itemId,
        [FromServices] ICartItemService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Remove(cartId, itemId, cancellationToken);

        return Results.NoContent();
    }
}

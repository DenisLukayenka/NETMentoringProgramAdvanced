using Cart.Service.BusinessLogic.Services.Abstractions;
using Microsoft.AspNetCore.Mvc;

namespace Cart.Service.Endpoints;

public static class CartEndpointsV2
{
    private const string CartEndpointsPrefix = "Carts";

    public static WebApplication RegisterCartEndpointsV2(this WebApplication app)
    {
        var versionTwo = new Asp.Versioning.ApiVersion(2, 0);
        var versionSet = app
            .NewApiVersionSet()
            .HasApiVersion(new Asp.Versioning.ApiVersion(1, 0))
            .HasApiVersion(versionTwo)
            .Build();

        var cartApi = app.MapGroup("/api/v{version:apiVersion}");

        cartApi
            .MapGet("/carts/{cartId}", GetCartItems)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(GetCartItems)}")
            .Produces<Models.Cart[]>(StatusCodes.Status200OK)
            .WithApiVersionSet(versionSet)
            .MapToApiVersion(versionTwo);

        return app;
    }

    private static async Task<IResult> GetCartItems(
        [FromRoute] string cartId,
        [FromServices] ICartService cartService,
        CancellationToken cancellationToken)
    {
        var cart = await cartService.Get(cartId, cancellationToken);

        return Results.Ok(cart?.Items ?? []);
    }
}

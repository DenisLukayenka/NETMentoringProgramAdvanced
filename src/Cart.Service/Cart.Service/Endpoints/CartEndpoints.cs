using Cart.Service.BusinessLogic.Services.Abstractions;
using Cart.Service.Mappings;
using Cart.Service.ViewModels;

namespace Cart.Service.Endpoints;

public static class CartEndpoints
{
    private const string CartEndpointsPrefix = "Carts";

    public static WebApplication RegisterCartEndpoints(this WebApplication app)
    {
        var endpointVersion = new Asp.Versioning.ApiVersion(1, 0);
        var versionSet = app.NewApiVersionSet().Build();

        var cartApi = app
            .MapGroup("/api/v{version:apiVersion}")
            .WithApiVersionSet(versionSet);

        cartApi
            .MapGet("/carts/{cartId}", GetCart)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(GetCart)}")
            .Produces<Models.Cart[]>(StatusCodes.Status200OK)
            .HasApiVersion(endpointVersion)
            .MapToApiVersion(endpointVersion);

        cartApi
            .MapDelete("/carts/{cartId}", ClearCart)
            .WithTags(CartEndpointsPrefix)
            .WithName($"{CartEndpointsPrefix}_{nameof(ClearCart)}")
            .Produces(StatusCodes.Status204NoContent)
            .IsApiVersionNeutral();

        return app;
    }

    private static async Task<Results<Ok<ModelResponse<Models.Cart>>, NotFound>> GetCart(
        [FromRoute] string cartId,
        [FromServices] ICartService cartService,
        CancellationToken cancellationToken)
    {
        var cart = await cartService.Get(cartId, cancellationToken);

        if (cart is null)
            return TypedResults.NotFound();

        var response = cart.MapToResponse();

        return TypedResults.Ok(response);
    }

    private static async Task<NoContent> ClearCart(
        [FromRoute] string cartId,
        [FromServices] ICartItemService cartService,
        CancellationToken cancellationToken)
    {
        await cartService.Clear(cartId, cancellationToken);

        return TypedResults.NoContent();
    }
}

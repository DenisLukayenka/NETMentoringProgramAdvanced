using Cart.Service.ViewModels;

namespace Cart.Service.Mappings;

internal static class CartMapping
{
    public static ModelResponse<Models.Cart> MapToResponse(this Models.Cart cart)
    {
        var response = new ModelResponse<Models.Cart>()
        {
            Payload = cart,
            Actions = [
                new ()
                {
                    Method = HttpMethods.Delete,
                    Rel = HttpMethods.Delete,
                    Uri = $"/carts/{cart.Id}"
                }
            ]
        };

        return response;
    }
}

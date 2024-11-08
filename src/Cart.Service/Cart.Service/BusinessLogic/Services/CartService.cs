using Cart.Service.BusinessLogic.Services.Abstractions;
using Cart.Service.DataAccess.Repositories.Abstractions;

namespace Cart.Service.BusinessLogic.Services;

public class CartService(
    ICartRepository repository,
    ILogger<CartService> logger) : ICartService
{
    public async Task<Models.Cart?> Get(string cartId, CancellationToken cancellationToken)
    {
        logger.LogInformation("{MethodName} method was called", nameof(Get));

        var cart = await repository.Get(cartId, cancellationToken);
        return cart;
    }
}

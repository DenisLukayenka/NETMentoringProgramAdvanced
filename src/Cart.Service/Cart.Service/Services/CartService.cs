using Cart.Service.Repositories.Abstractions;
using Cart.Service.Services.Abstractions;

namespace Cart.Service.Services;

internal class CartService(ICartRepository repository) : ICartService
{
    public async Task<Models.Cart[]> ListByUser(string userId, CancellationToken cancellationToken)
    {
        var carts = await repository.List(userId, cancellationToken);
        return carts;
    }

    public async Task Add(string userId, Models.Cart cart, CancellationToken cancellationToken)
    {
        await repository.Add(userId, cart, cancellationToken);
    }

    public async Task Clear(string userId, CancellationToken cancellationToken)
    {
        await repository.Clear(userId, cancellationToken);
    }

    public async Task Remove(string userId, int id, CancellationToken cancellationToken)
    {
        await repository.Remove(userId, id, cancellationToken);
    }
}

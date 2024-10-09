using Cart.Service.Repositories.Abstractions;
using Cart.Service.Services.Abstractions;

namespace Cart.Service.Services;

internal class CartItemService(ICartRepository repository) : ICartItemService
{
    public async Task<Models.CartItem[]> List(string cartId, CancellationToken cancellationToken)
    {
        var cart = await repository.Get(cartId, cancellationToken);
        return cart?.Items ?? [];
    }

    #region Add

    public async Task Add(string cartId, Models.CartItem cartItem, CancellationToken cancellationToken)
    {
        var currentCart = await repository.Get(cartId, cancellationToken);

        if (currentCart is null)
        {
            currentCart = InitEmptyCart(cartId, cartItem);
        }
        else
        {
            AddItemToCart(currentCart, cartItem);
        }

        await repository.Upsert(cartId, currentCart, cancellationToken);
    }

    private static Models.Cart InitEmptyCart(string cartId, Models.CartItem cartItem)
    {
        var cart = new Models.Cart()
        {
            Id = cartId,
            Items = [cartItem]
        };

        return cart;
    }

    private static void AddItemToCart(Models.Cart cart, Models.CartItem item)
    {
        var existingCartItem = cart.Items.FirstOrDefault(x => x.ItemId == item.ItemId);
        if (existingCartItem != null)
        {
            existingCartItem.Quantity += 1;
        }
        else
        {
            cart.Items = [.. cart.Items, item];
        }
    }

    #endregion

    public async Task Remove(string cartId, int id, CancellationToken cancellationToken)
    {
        var currentCart = await repository.Get(cartId, cancellationToken);
        if (currentCart is null)
            return;

        var cartItem = currentCart.Items.FirstOrDefault(x => x.ItemId == id);
        if (cartItem is null)
            return;

        cartItem.Quantity -= 1;

        if (cartItem.Quantity <= 0)
        {
            currentCart.Items = currentCart.Items.Where(x => x.ItemId != id).ToArray();
        }

        await repository.Upsert(cartId, currentCart, cancellationToken);
    }

    public async Task Clear(string cartId, CancellationToken cancellationToken)
    {
        await repository.Remove(cartId, cancellationToken);
    }
}

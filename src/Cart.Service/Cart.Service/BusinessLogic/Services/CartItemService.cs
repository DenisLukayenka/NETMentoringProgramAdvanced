using Cart.Service.BusinessLogic.Services.Abstractions;
using Cart.Service.DataAccess.Repositories.Abstractions;
using FluentValidation;

namespace Cart.Service.BusinessLogic.Services;

internal class CartItemService(
    ICartRepository repository,
    ILogger<CartItemService> logger,
    IValidator<Models.CartItem> cartItemValidator) : ICartItemService
{
    public async Task<Models.CartItem[]> List(string cartId, CancellationToken cancellationToken)
    {
        logger.LogInformation("{MethodName} method was called", nameof(List));

        var cart = await repository.Get(cartId, cancellationToken);
        return cart?.Items ?? [];
    }

    #region Add

    public async Task Add(string cartId, Models.CartItem cartItem, CancellationToken cancellationToken)
    {
        logger.LogInformation("{MethodName} method was called", nameof(Add));
        cartItemValidator.ValidateAndThrow(cartItem);

        var currentCart = await repository.Get(cartId, cancellationToken);

        if (currentCart is null)
        {
            logger.LogInformation("Cart with cartItemId: {CartId} was not found. Initializing empty cart.", cartId);
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
            existingCartItem.Quantity += item.Quantity;
        }
        else
        {
            cart.Items = [.. cart.Items, item];
        }
    }

    #endregion

    public async Task Remove(string cartId, int cartItemId, CancellationToken cancellationToken)
    {
        logger.LogInformation("{MethodName} method was called", nameof(Remove));

        var currentCart = await repository.Get(cartId, cancellationToken);
        if (currentCart is null)
            return;

        var cartItem = currentCart.Items.FirstOrDefault(x => x.ItemId == cartItemId);
        if (cartItem is null)
            return;

        cartItem.Quantity -= 1;

        if (cartItem.Quantity <= 0)
        {
            currentCart.Items = currentCart.Items.Where(x => x.ItemId != cartItemId).ToArray();
        }

        await repository.Upsert(cartId, currentCart, cancellationToken);
    }

    public async Task Clear(string cartId, CancellationToken cancellationToken)
    {
        logger.LogInformation("{MethodName} method was called", nameof(Clear));
        await repository.Remove(cartId, cancellationToken);
    }
}

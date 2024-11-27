namespace Cart.Service.BusinessLogic.Services.Abstractions;

public interface ICartItemService
{
    Task<Models.CartItem[]> List(string cartId, CancellationToken cancellationToken);

    Task Add(string cartId, Models.CartItem cartItem, CancellationToken cancellationToken);

    Task Remove(string cartId, int cartItemId, CancellationToken cancellationToken);

    Task Clear(string cartId, CancellationToken cancellationToken);
}

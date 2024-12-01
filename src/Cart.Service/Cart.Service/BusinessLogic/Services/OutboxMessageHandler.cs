using Cart.Service.BusinessLogic.Services.Abstractions;
using Cart.Service.DataAccess.Repositories.Abstractions;
using Lunis.SharedLibs.Catalog.OutboxMessages;

namespace Cart.Service.BusinessLogic.Services;

public class OutboxMessageHandler(ICartRepository repository) : IOutboxMessageHandler
{
    public Task Handle(BaseMessage? message, CancellationToken cancellationToken)
    {
        ArgumentNullException.ThrowIfNull(message, nameof(message));

        return HandleAsync(message, cancellationToken);
    }

    private async Task HandleAsync(BaseMessage message, CancellationToken cancellationToken)
    {
        switch (message)
        {
            case ProductDeletedMessage deleteMessage:
                await DeleteItemFromCarts(deleteMessage.ProductId, cancellationToken);
                break;
            case ProductUpdatedMessage updateMessage:
                await UpdateItemInCarts(updateMessage.ProductId, updateMessage.Name, updateMessage.Price!, cancellationToken);
                break;
            default:
                throw new InvalidCastException($"Cannot process message of type: {message.GetType().Name}");
        }
    }

    private async Task UpdateItemInCarts(int itemId, string name, decimal price, CancellationToken cancellationToken)
    {
        var cart = await repository.GetNextOutdated(itemId, name, price, cancellationToken);

        while (cart != null)
        {
            var cartItem = cart.Items.First(x => x.ItemId == itemId);
            cartItem.Name = name;
            cartItem.Price = price;

            await repository.Upsert(cart.Id, cart, cancellationToken);

            cart = await repository.GetNextOutdated(itemId, name, price, cancellationToken);
        }
    }

    private async Task DeleteItemFromCarts(int itemId, CancellationToken cancellationToken)
    {
        var cart = await repository.GetNextOutdated(itemId, newName: null, newPrice: null, cancellationToken);

        while (cart != null)
        {
            cart.Items = cart.Items.Where(x => x.ItemId != itemId).ToArray();

            await repository.Upsert(cart.Id, cart, cancellationToken);

            cart = await repository.GetNextOutdated(itemId, newName: null, newPrice: null, cancellationToken);
        }
    }
}

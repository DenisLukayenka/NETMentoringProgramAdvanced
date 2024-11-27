namespace Cart.Service.DataAccess.Repositories.Abstractions;

public interface ICartRepository
{
    Task<Models.Cart?> Get(string cartId, CancellationToken cancellationToken);

    Task<Models.Cart?> GetNextOutdated(int itemId, string? newName, decimal? newPrice, CancellationToken cancellationToken);

    Task Upsert(string cartId, Models.Cart cart, CancellationToken cancellationToken);

    Task Remove(string cartId, CancellationToken cancellationToken);
}

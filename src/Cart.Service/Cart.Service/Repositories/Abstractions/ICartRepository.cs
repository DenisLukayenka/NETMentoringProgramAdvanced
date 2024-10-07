namespace Cart.Service.Repositories.Abstractions;

public interface ICartRepository
{
    Task<Models.Cart[]> List(string userId, CancellationToken cancellationToken);

    Task Add(string userId, Models.Cart cart, CancellationToken cancellationToken);
    Task Remove(string userId, int id, CancellationToken cancellationToken);

    Task Clear(string userId, CancellationToken cancellationToken);
}

namespace Cart.Service.Services.Abstractions;

public interface ICartService
{
    Task<Models.Cart[]> ListByUser(string userId, CancellationToken cancellationToken);
    Task Add(string userId, Models.Cart cart, CancellationToken cancellationToken);

    Task Remove(string userId, int id, CancellationToken cancellationToken);
    Task Clear(string userId, CancellationToken cancellationToken);
}

namespace Cart.Service.BusinessLogic.Services.Abstractions;

public interface ICartService
{
    Task<Models.Cart?> Get(string cartId, CancellationToken cancellationToken);
}

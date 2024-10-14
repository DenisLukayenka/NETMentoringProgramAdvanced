using Cart.Service.DataAccess.Repositories.Abstractions;
using StackExchange.Redis;
using StackExchange.Redis.Extensions.Core.Abstractions;

namespace Cart.Service.DataAccess.Repositories;

internal class CartRepository(IRedisDatabase database) : ICartRepository
{
    public async Task<Models.Cart?> Get(string cartId, CancellationToken cancellationToken)
    {
        var cart = await database.GetAsync<Models.Cart>(cartId, CommandFlags.PreferReplica);

        return cart;
    }

    public async Task Upsert(string cartId, Models.Cart cart, CancellationToken cancellationToken)
    {
        await database.ReplaceAsync(cartId, cart, When.Always, CommandFlags.DemandMaster);
    }

    public async Task Remove(string cartId, CancellationToken cancellationToken)
    {
        await database.RemoveAsync(cartId, CommandFlags.DemandMaster);
    }
}

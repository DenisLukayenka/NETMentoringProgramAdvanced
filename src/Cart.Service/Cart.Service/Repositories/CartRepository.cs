using Cart.Service.Repositories.Abstractions;
using StackExchange.Redis;
using StackExchange.Redis.Extensions.Core.Abstractions;

namespace Cart.Service.Repositories;

internal class CartRepository(IRedisDatabase database) : ICartRepository
{
    public async Task<Models.Cart[]> List(string userId, CancellationToken cancellationToken)
    {
        var carts = await database.GetAsync<Models.Cart[]>(userId, CommandFlags.PreferReplica);

        return carts ?? [];
    }

    public async Task Add(string userId, Models.Cart cart, CancellationToken cancellationToken)
    {
        var carts = await database.GetAsync<Models.Cart[]>(userId, CommandFlags.PreferReplica);

        carts ??= [];
        carts = [.. carts, cart];

        await database.AddAsync(userId, carts, When.Always);
        await database.ReplaceAsync(userId, carts, When.Always, CommandFlags.DemandMaster);
    }

    public async Task Remove(string userId, int id, CancellationToken cancellationToken)
    {
        var carts = await database.GetAsync<Models.Cart[]>(userId, CommandFlags.PreferReplica);

        if (carts is null || carts.Length == 0)
            return;

        carts = carts.Where(x => x.Id != id).ToArray();

        await database.ReplaceAsync(userId, carts, When.Always, CommandFlags.DemandMaster);
    }

    public async Task Clear(string userId, CancellationToken cancellationToken)
    {
        await database.RemoveAsync(userId, CommandFlags.DemandMaster);
    }
}

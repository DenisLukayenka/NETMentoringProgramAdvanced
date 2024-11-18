using Cart.Service.DataAccess.Repositories.Abstractions;
using Microsoft.Azure.Cosmos;

namespace Cart.Service.DataAccess.Repositories;

internal class CartRepository(Container dbContainer) : ICartRepository
{
    internal const string ContainerName = "Carts";

    internal static void InitRepository(Database database)
    {
        database
            .CreateContainerIfNotExistsAsync(
                id: CartRepository.ContainerName,
                partitionKeyPath: $"/{nameof(Models.Cart.Id).ToLowerInvariant()}",
                cancellationToken: default)
            .GetAwaiter()
            .GetResult();
    }

    public async Task<Models.Cart?> Get(string cartId, CancellationToken cancellationToken)
    {
        try
        {
            var cart = await dbContainer.ReadItemAsync<Models.Cart>(cartId, new PartitionKey(cartId), cancellationToken: cancellationToken);

            return cart;
        }
        catch (CosmosException ex) when (ex.StatusCode == System.Net.HttpStatusCode.NotFound)
        {
            return null;
        }
    }

    public async Task Upsert(string cartId, Models.Cart cart, CancellationToken cancellationToken)
    {
        await dbContainer.UpsertItemAsync(
            item: cart,
            partitionKey: new PartitionKey(cartId),
            cancellationToken: cancellationToken);
    }

    public async Task Remove(string cartId, CancellationToken cancellationToken)
    {
        await dbContainer.DeleteItemAsync<Models.Cart>(cartId, new PartitionKey(cartId), cancellationToken: cancellationToken);
    }
}

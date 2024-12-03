using Cart.Service.DataAccess.Repositories.Abstractions;
using Microsoft.Azure.Cosmos;
using Microsoft.Azure.Cosmos.Linq;

namespace Cart.Service.DataAccess.Repositories;

internal class CartRepository : ICartRepository
{
    internal const string ContainerName = "Carts";

    private readonly CosmosClient _cosmosClient;

    internal Container Container => _cosmosClient.GetDatabase(Registrations.DbName).GetContainer(ContainerName);

    public CartRepository(CosmosClient cosmosClient)
    {
        var databaseResponse = cosmosClient
            .CreateDatabaseIfNotExistsAsync(Registrations.DbName, cancellationToken: default)
            .GetAwaiter().GetResult();

        databaseResponse
            .Database
            .CreateContainerIfNotExistsAsync(
                id: ContainerName,
                partitionKeyPath: $"/{nameof(Models.Cart.Id).ToLowerInvariant()}")
            .GetAwaiter()
            .GetResult();

        _cosmosClient = cosmosClient;
    }

    public async Task<Models.Cart?> Get(string cartId, CancellationToken cancellationToken)
    {
        try
        {
            var cart = await Container.ReadItemAsync<Models.Cart>(cartId, new PartitionKey(cartId), cancellationToken: cancellationToken);

            return cart;
        }
        catch (CosmosException ex) when (ex.StatusCode == System.Net.HttpStatusCode.NotFound)
        {
            return null;
        }
    }

    public async Task<Models.Cart?> GetNextOutdated(int itemId, string? newName, decimal? newPrice, CancellationToken cancellationToken)
    {
        try
        {
            IQueryable<Models.Cart> queryable = Container.GetItemLinqQueryable<Models.Cart>();
            queryable = queryable
                .Where(x => x.Items.Any(i => i.ItemId == itemId));

            if (!string.IsNullOrEmpty(newName))
            {
                queryable = queryable
                    .Where(x => x.Items.Any(i => i.Name != newName));
            }

            if (newPrice.HasValue)
            {
                queryable = queryable
                    .Where(x => x.Items.Any(i => i.Price != newPrice.Value));
            }

            using var feed = queryable.ToFeedIterator();

            var cartResponse = await feed.ReadNextAsync(cancellationToken: cancellationToken);

            return cartResponse?.Resource?.FirstOrDefault();
        }
        catch (CosmosException ex) when (ex.StatusCode == System.Net.HttpStatusCode.NotFound)
        {
            return null;
        }
    }

    public async Task Upsert(string cartId, Models.Cart cart, CancellationToken cancellationToken)
    {
        await Container.UpsertItemAsync(
            item: cart,
            partitionKey: new PartitionKey(cartId),
            cancellationToken: cancellationToken);
    }

    public async Task Remove(string cartId, CancellationToken cancellationToken) => await Container.DeleteItemAsync<Models.Cart>(cartId, new PartitionKey(cartId), cancellationToken: cancellationToken);
}

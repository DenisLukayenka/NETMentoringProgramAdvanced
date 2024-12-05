using Cart.Service.DataAccess.Repositories.Abstractions;
using MongoDB.Driver;

namespace Cart.Service.DataAccess.Repositories;

public class CartRepository(IMongoDatabase database) : ICartRepository
{
    internal const string CollectionName = "Carts";

    protected IMongoCollection<Models.Cart> Collection => database.GetCollection<Models.Cart>(CollectionName);

    public async Task<Models.Cart?> Get(string cartId, CancellationToken cancellationToken)
    {
        var filter = Builders<Models.Cart>.Filter.Eq(x => x.Id, cartId);
        var options = new FindOptions<Models.Cart>()
        {
            AllowDiskUse = true,
            Limit = 1
        };

        var cursor = await Collection.FindAsync(filter, options, cancellationToken);
        var entity = await cursor.FirstOrDefaultAsync(cancellationToken);

        return entity;
    }

    public async Task<Models.Cart?> GetNextOutdated(int itemId, string? newName, decimal? newPrice, CancellationToken cancellationToken)
    {
        var filter = Builders<Models.Cart>.Filter.Where(x => x.Items.Any(i => i.ItemId == itemId));

        if (!string.IsNullOrEmpty(newName))
        {
            filter &= Builders<Models.Cart>.Filter.Where(x => x.Items.Any(i => i.Name != newName));
        }

        if (newPrice.HasValue)
        {
            filter &= Builders<Models.Cart>.Filter.Where(x => x.Items.Any(i => i.Price != newPrice.Value));
        }

        var options = new FindOptions<Models.Cart>()
        {
            AllowDiskUse = true,
            Limit = 1
        };

        var cursor = await Collection.FindAsync(filter, options, cancellationToken);
        var entity = await cursor.FirstOrDefaultAsync(cancellationToken);

        return entity;
    }

    public async Task Remove(string cartId, CancellationToken cancellationToken)
    {
        var filter = Builders<Models.Cart>.Filter.Eq(x => x.Id, cartId);
        await Collection.DeleteOneAsync(filter, cancellationToken);
    }

    public async Task Upsert(string cartId, Models.Cart cart, CancellationToken cancellationToken)
    {
        var filter = Builders<Models.Cart>.Filter.Eq(x => x.Id, cartId);
        var options = new FindOneAndReplaceOptions<Models.Cart>()
        {
            IsUpsert = true,
            ReturnDocument = ReturnDocument.After
        };

        await Collection.FindOneAndReplaceAsync(filter, cart, options, cancellationToken);
    }
}

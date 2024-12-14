using Cart.Service.DataAccess.Options;
using Cart.Service.DataAccess.Repositories;
using Cart.Service.DataAccess.Repositories.Abstractions;
using Microsoft.Extensions.Options;
using MongoDB.Bson;
using MongoDB.Bson.Serialization;
using MongoDB.Bson.Serialization.Serializers;
using MongoDB.Driver;

namespace Cart.Service.DataAccess;

public static class Registrations
{
    public const string DatabaseName = "mentoring-shop";

    public static IServiceCollection ConfigureDataAccessServices(this IServiceCollection services, IConfiguration configuration)
    {
        SetBsonDefaults();

        services.Configure<MongoDbOptions>(configuration.GetSection(MongoDbOptions.Position));

        services
            .AddSingleton<IMongoClient, MongoClient>(sp =>
            {
                var options = sp.GetRequiredService<IOptions<MongoDbOptions>>();

                return new MongoClient(options.Value.ConnectionString);
            })
            .AddSingleton(sp =>
            {
                var mongoClient = sp.GetRequiredService<IMongoClient>();
                var mongoDatabase = mongoClient.GetDatabase(DatabaseName);

                return mongoDatabase;
            })
            .AddSingleton<ICartRepository, CartRepository>();

        return services;
    }

    private static void SetBsonDefaults()
    {
        BsonSerializer.RegisterSerializer(new GuidSerializer(GuidRepresentation.Standard));
        BsonSerializer.RegisterSerializer(new DateTimeSerializer(BsonType.DateTime));
        BsonSerializer.RegisterSerializer(new DateTimeOffsetSerializer(BsonType.Document));

        BsonSerializer.RegisterSerializer(new ObjectSerializer(type => true));

        BsonClassMap.RegisterClassMap<Models.Cart>();
    }
}

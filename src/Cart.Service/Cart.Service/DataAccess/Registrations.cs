using System.Reflection;
using Azure.Identity;
using Cart.Service.DataAccess.Options;
using Cart.Service.DataAccess.Repositories;
using Cart.Service.DataAccess.Repositories.Abstractions;
using Cart.Service.Platform.Serialization;
using Microsoft.Azure.Cosmos;
using Microsoft.Extensions.Options;
using StackExchange.Redis.Extensions.Core.Abstractions;
using StackExchange.Redis.Extensions.Core.Configuration;
using StackExchange.Redis.Extensions.Core.Implementations;
using StackExchange.Redis.Extensions.System.Text.Json;

namespace Cart.Service.DataAccess;

public static class Registrations
{
    public const string DbName = "mentoring-shop";

    public static IServiceCollection ConfigureDataAccessServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<RedisOptions>(configuration.GetSection(RedisOptions.Position));
        services.Configure<CosmosDbOptions>(configuration.GetSection(CosmosDbOptions.Position));

        // Not important for now
        //services.RegisterRedisCache();

        services
            .AddSingleton<CosmosClient>(sp =>
            {
                var cosmosDbOptions = sp.GetRequiredService<IOptions<CosmosDbOptions>>().Value;

                var credential = new DefaultAzureCredential();
                var client = new CosmosClient(
                    accountEndpoint: cosmosDbOptions.Endpoint,
                    authKeyOrResourceToken: cosmosDbOptions.ResourceToken,
                    clientOptions: new CosmosClientOptions
                    {
                        ConnectionMode = ConnectionMode.Direct,
                        IdleTcpConnectionTimeout = TimeSpan.FromMinutes(60),
                        UseSystemTextJsonSerializerWithOptions = new System.Text.Json.JsonSerializerOptions()
                        {
                            TypeInfoResolver = AppJsonSerializerContext.Default
                        }
                    }
                );

                return client;
            })
            .AddSingleton<ICartRepository, CartRepository>();

        return services;
    }

    private static IServiceCollection RegisterRedisCache(this IServiceCollection services)
    {
        services
            .AddSingleton<IRedisConnectionPoolManager>(sp =>
            {
                var redisOptions = sp.GetRequiredService<IOptions<RedisOptions>>().Value;
                var configuration = new RedisConfiguration()
                {
                    ConnectionString = redisOptions.ConnectionString,
                    PoolSize = redisOptions.PoolSize,
                };

                var connectionManager = new RedisConnectionPoolManager(configuration);
                return connectionManager;
            })
            .AddSingleton<IRedisDatabase>(sp =>
            {
                var redisOptions = sp.GetRequiredService<IOptions<RedisOptions>>().Value;
                var connectionManager = sp.GetRequiredService<IRedisConnectionPoolManager>();
                var serializer = new SystemTextJsonSerializer(new System.Text.Json.JsonSerializerOptions()
                {
                    TypeInfoResolver = AppJsonSerializerContext.Default
                });

                var database = new RedisDatabase(
                    connectionPoolManager: connectionManager,
                    serializer: serializer,
                    serverEnumerationStrategy: new ServerEnumerationStrategy()
                    {
                        Mode = ServerEnumerationStrategy.ModeOptions.Single,
                        TargetRole = ServerEnumerationStrategy.TargetRoleOptions.Any,
                        UnreachableServerAction = ServerEnumerationStrategy.UnreachableServerActionOptions.Throw
                    },
                    dbNumber: redisOptions.DbNumber,
                    maxvalueLength: redisOptions.MaxValueLength,
                    keyPrefix: Assembly.GetEntryAssembly()!.GetName().Name);

                return database;
            });

        return services;
    }
}

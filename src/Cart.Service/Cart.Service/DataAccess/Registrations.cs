using Cart.Service.DataAccess.Options;
using Cart.Service.DataAccess.Repositories;
using Cart.Service.DataAccess.Repositories.Abstractions;
using Cart.Service.Platform.Serialization;
using Microsoft.Extensions.Options;
using StackExchange.Redis.Extensions.Core.Abstractions;
using StackExchange.Redis.Extensions.Core.Configuration;
using StackExchange.Redis.Extensions.Core.Implementations;
using StackExchange.Redis.Extensions.System.Text.Json;
using System.Reflection;

namespace Cart.Service.DataAccess;

public static class Registrations
{
    public static IServiceCollection ConfigureDataAccessServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<RedisOptions>(configuration.GetSection(RedisOptions.Position));

        services
            .AddTransient<ICartRepository, CartRepository>()
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

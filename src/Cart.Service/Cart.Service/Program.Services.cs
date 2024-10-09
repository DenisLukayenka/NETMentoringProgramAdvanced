using Cart.Service.Options;
using Cart.Service.Platform.OpenApi;
using Cart.Service.Platform.Serialization;
using Cart.Service.Repositories;
using Cart.Service.Repositories.Abstractions;
using Cart.Service.Services;
using Cart.Service.Services.Abstractions;
using Microsoft.Extensions.Options;
using StackExchange.Redis.Extensions.Core.Abstractions;
using StackExchange.Redis.Extensions.Core.Configuration;
using StackExchange.Redis.Extensions.Core.Implementations;
using StackExchange.Redis.Extensions.System.Text.Json;
using System.Reflection;

namespace Cart.Service;

public static class ProgramServices
{
    public static WebApplicationBuilder RegisterAppServices(this WebApplicationBuilder builder)
    {
        builder.Services.AddAppSerialization();
        builder.Services.Configure<RedisOptions>(builder.Configuration.GetSection(RedisOptions.Position));

        builder.Services.AddAppOpenApi(builder.Environment);

        builder.Services
            .AddTransient<ICartItemService, CartItemService>()
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

        return builder;
    }
}

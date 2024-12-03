using Azure.Identity;
using Cart.Service.DataAccess.Options;
using Cart.Service.DataAccess.Repositories;
using Cart.Service.DataAccess.Repositories.Abstractions;
using Cart.Service.Platform.Serialization;
using Microsoft.Azure.Cosmos;
using Microsoft.Extensions.Options;

namespace Cart.Service.DataAccess;

public static class Registrations
{
    public const string DbName = "mentoring-shop";

    public static IServiceCollection ConfigureDataAccessServices(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<CosmosDbOptions>(configuration.GetSection(CosmosDbOptions.Position));

        services
            .AddSingleton(sp =>
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
                            TypeInfoResolver = AppJsonSerializerContext.Default,
                        },
                    });

                return client;
            })
            .AddSingleton<ICartRepository, CartRepository>();

        return services;
    }
}

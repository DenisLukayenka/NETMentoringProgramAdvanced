using Azure.Messaging.ServiceBus;
using Cart.Service.BackgroundServices;
using Cart.Service.BusinessLogic;
using Cart.Service.DataAccess;
using Cart.Service.Options;
using Cart.Service.Platform;
using Cart.Service.Platform.Serialization;
using Cart.Service.Platform.Swagger;
using Cart.Service.Platform.Versioning;
using Microsoft.Extensions.Azure;
using Microsoft.Extensions.Options;

namespace Cart.Service;

public static class ProgramServices
{
    public static WebApplicationBuilder RegisterAppServices(this WebApplicationBuilder builder)
    {
        builder.Services.AddAppSerialization();
        builder.Services.AddAppProblemDetails();
        builder.Services.AddAppVersioning();
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddAppSwagger();

        builder.Services.Configure<MessageBusOptions>(builder.Configuration.GetSection(MessageBusOptions.Position));
        builder.Services.AddAzureClientsCore(false);
        builder.Services.AddSingleton(sp =>
        {
            var options = sp.GetRequiredService<IOptions<MessageBusOptions>>().Value;

            return new ServiceBusClient(options.ConnectionString);
        });

        builder.Services.AddHostedService<OutboxMessageListener>();
        builder.Services
            .ConfigureBusinessLogicServices(builder.Configuration)
            .ConfigureDataAccessServices(builder.Configuration);

        return builder;
    }
}

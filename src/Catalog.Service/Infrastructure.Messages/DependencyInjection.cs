using ApplicationCore.Common.Interfaces;
using Azure.Messaging.ServiceBus;
using Infrastructure.Messages.Options;
using Infrastructure.Messages.Services;
using Microsoft.Extensions.Azure;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;

namespace Infrastructure.Messages;

public static class DependencyInjection
{
    public static IServiceCollection ConfigureInfrastructureMessageBusServices(
        this IServiceCollection services,
        Action configureMessageBusOptions)
    {
        configureMessageBusOptions();

        services.AddAzureClientsCore(false);
        services.AddSingleton(sp =>
        {
            var options = sp.GetRequiredService<IOptions<MessageBusOptions>>().Value;

            return new ServiceBusClient(options.MessageBusConnectionString);
        });

        services
            .AddScoped<IMessageSender, MessageSender>();

        return services;
    }
}

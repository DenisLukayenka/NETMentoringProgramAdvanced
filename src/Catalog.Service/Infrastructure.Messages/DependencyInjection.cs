using ApplicationCore.Common.Interfaces;
using Infrastructure.Messages.Options;
using Infrastructure.Messages.Services;
using Microsoft.Extensions.Azure;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure.Messages;

public static class DependencyInjection
{
    public static IServiceCollection ConfigureInfrastructureMessageBusServices(
        this IServiceCollection services,
        MessageBusOptions options)
    {
        services
            .AddScoped<IMessageSender, MessageSender>()
            .AddAzureClients(builder =>
            {
                builder.AddServiceBusClient(options.MessageBusConnectionString);
            });

        return services;
    }
}

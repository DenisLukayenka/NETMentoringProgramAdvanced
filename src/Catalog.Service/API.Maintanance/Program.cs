using ApplicationCore;
using Infrastructure.Database;
using Infrastructure.Database.Options;
using Infrastructure.Messages;
using Infrastructure.Messages.Options;
using Microsoft.Azure.Functions.Worker.Builder;
using Microsoft.Extensions.Configuration;

var host = new HostBuilder()
    .ConfigureFunctionsWebApplication()
    .ConfigureServices((context, services) =>
    {
        services.AddApplicationInsightsTelemetryWorkerService();
        services.ConfigureFunctionsApplicationInsights();

        services.ConfigureInfrastructureServices(
            context.Configuration, configuration => services.Configure<SqlDatabaseOptions>(configuration.Bind));
        services.ConfigureInfrastructureMessageBusServices(
            () => services.Configure<MessageBusOptions>(context.Configuration.Bind));

        services.ConfigureAppServices();
    })
    .Build();

host.Run();
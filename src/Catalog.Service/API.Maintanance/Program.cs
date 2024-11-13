using ApplicationCore;
using Infrastructure;
using Infrastructure.Options;
using Microsoft.Azure.Functions.Worker.Builder;
using Microsoft.Extensions.Configuration;

var host = new HostBuilder()
    .ConfigureFunctionsWebApplication()
    .ConfigureServices((context, services) =>
    {
        services.AddApplicationInsightsTelemetryWorkerService();
        services.ConfigureFunctionsApplicationInsights();

        services.ConfigureAppServices();
        services.ConfigureInfrastructureServices(context.Configuration, configuration => services.Configure<SqlDatabaseOptions>(configuration.Bind));

    })
    .Build();

host.Run();
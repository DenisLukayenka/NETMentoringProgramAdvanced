using ApplicationCore;
using Infrastructure;
using Infrastructure.Options;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var host = new HostBuilder()
    .ConfigureFunctionsWebApplication()
    .ConfigureServices((context, services) =>
    {
        services.AddApplicationInsightsTelemetryWorkerService();
        services.ConfigureFunctionsApplicationInsights();

        services.ConfigureAppServices();
        services.ConfigureInfrastructureServices(context.Configuration, configuration => services.Configure<SqlDatabaseOptions>(configuration));

    })
    .Build();

host.Run();
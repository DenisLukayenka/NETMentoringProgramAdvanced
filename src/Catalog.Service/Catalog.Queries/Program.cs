using ApplicationCore;
using Infrastructure;
using Infrastructure.Options;

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
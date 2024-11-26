using ApplicationCore;
using Infrastructure.Database;
using Infrastructure.Database.Options;
using Microsoft.Extensions.Configuration;

var host = new HostBuilder()
    .ConfigureFunctionsWebApplication()
    .ConfigureServices((context, services) =>
    {
        services.AddApplicationInsightsTelemetryWorkerService();
        services.ConfigureFunctionsApplicationInsights();

        var sqlOptions = new SqlDatabaseOptions();
        context.Configuration.Bind(sqlOptions);

        services.ConfigureAppServices();
        services.ConfigureInfrastructureServices(sqlOptions);
    })
    .Build();

host.Run();
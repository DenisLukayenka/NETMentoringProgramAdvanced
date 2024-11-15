using ApplicationCore;
using Microsoft.Azure.Functions.Worker.Builder;

var host = new HostBuilder()
    .ConfigureFunctionsWebApplication()
    .ConfigureServices((context, services) =>
    {
        services.AddApplicationInsightsTelemetryWorkerService();
        services.ConfigureFunctionsApplicationInsights();

        services.ConfigureAppServices();
    })
    .Build();

host.Run();
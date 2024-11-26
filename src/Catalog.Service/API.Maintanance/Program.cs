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

        var messageBusOptions = new MessageBusOptions();
        context.Configuration.Bind(messageBusOptions);

        var sqlOptions = new SqlDatabaseOptions();
        context.Configuration.Bind(sqlOptions);

        services.ConfigureInfrastructureServices(sqlOptions);
        services.ConfigureInfrastructureMessageBusServices(messageBusOptions);

        services.ConfigureAppServices();
    })
    .Build();

host.Run();
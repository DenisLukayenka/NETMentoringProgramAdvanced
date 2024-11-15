using ApplicationCore.Common.Interfaces;
using Infrastructure.Database.Abstractions;
using Infrastructure.Database.Data;
using Infrastructure.Database.Data.Interceptors;
using Infrastructure.Database.Data.Repositories;
using Infrastructure.Database.Options;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Options;

namespace Infrastructure.Database;

public static class DependencyInjection
{
    public static IServiceCollection ConfigureInfrastructureServices(
        this IServiceCollection services,
        IConfiguration configuration,
        Action<IConfiguration> configureSqlDatabase)
    {
        configureSqlDatabase(configuration);

        services.AddDbContext<ApplicationDbContext>((sp, options) =>
        {
            options.AddInterceptors(sp.GetRequiredService<ISaveChangesInterceptor>());

            var sqlDatabase = sp.GetRequiredService<IOptions<SqlDatabaseOptions>>().Value;
            options.UseSqlServer(sqlDatabase.SqlDatabaseConnectionString);
        });

        services
            .AddScoped<IApplicationDbContext, ApplicationDbContext>()
            .AddScoped<ISaveChangesInterceptor, PopulateEventsInterceptor>()
            .AddScoped<ICategoryRepository, CategoryRepository>()
            .AddScoped<IProductRepository, ProductRepository>()
            .AddScoped<IOutboxEventsRepository, OutboxEventsRepository>();

        return services;
    }
}

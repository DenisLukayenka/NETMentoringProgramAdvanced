using ApplicationCore.Common.Interfaces;
using Infrastructure.Database.Abstractions;
using Infrastructure.Database.Data;
using Infrastructure.Database.Data.Interceptors;
using Infrastructure.Database.Data.Repositories;
using Infrastructure.Database.Options;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Diagnostics;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure.Database;

public static class DependencyInjection
{
    public static IServiceCollection ConfigureInfrastructureServices(
        this IServiceCollection services,
        SqlDatabaseOptions sqlOptions)
    {
        services.AddDbContext<ApplicationDbContext>((sp, options) =>
        {
            options.AddInterceptors(sp.GetRequiredService<ISaveChangesInterceptor>());
            options.UseSqlServer(sqlOptions.SqlDatabaseConnectionString);
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

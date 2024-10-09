using ApplicationCore.Common.Interfaces;
using Infrastructure.Abstractions;
using Infrastructure.Data;
using Infrastructure.Data.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection ConfigureInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
    {
        var connectionString = configuration.GetConnectionString("DefaultConnection");

        services.AddDbContext<ApplicationDbContext>((sp, options) =>
        {
            options.UseSqlServer(connectionString);
        });

        services
            .AddScoped<IApplicationDbContext, ApplicationDbContext>()
            .AddScoped<ICategoryRepository, CategoryRepository>()
            .AddScoped<IProductRepository, ProductRepository>();

        return services;
    }
}

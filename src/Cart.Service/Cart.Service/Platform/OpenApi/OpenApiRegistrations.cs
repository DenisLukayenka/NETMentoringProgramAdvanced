using System.Reflection;

namespace Cart.Service.Platform.OpenApi;

public static class OpenApiRegistrations
{
    public static IServiceCollection AddAppOpenApi(this IServiceCollection services, IHostEnvironment environment)
    {
        if (environment.IsDevelopment())
        {
            services.AddSwaggerDocument(settings =>
            {
                settings.Title = Assembly.GetExecutingAssembly().GetName().Name;
            });

            services.AddEndpointsApiExplorer();
            services.AddMvcCore().AddApiExplorer();
        }

        return services;
    }

    public static WebApplication UseAppSwagger(this WebApplication app)
    {
        if (app.Environment.IsDevelopment())
        {
            app.UseOpenApi();
            app.UseSwaggerUi();
        }

        return app;
    }
}

using Microsoft.Extensions.Options;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace Cart.Service.Platform.Swagger;

public static class SwaggerRegistrations
{
    public static IServiceCollection AddAppSwagger(this IServiceCollection services)
    {
        services.AddTransient<IConfigureOptions<SwaggerGenOptions>, ConfigureSwaggerOptions>();
        services.AddSwaggerGen(options => options.OperationFilter<SwaggerDefaultValues>());

        return services;
    }

    public static WebApplication UseAppSwagger(this WebApplication app)
    {
        app.UseSwagger();
        app.UseSwaggerUI(options =>
        {
            var documentDescriptions = app.DescribeApiVersions();

            foreach (var document in documentDescriptions)
            {
                var url = $"/swagger/{document.GroupName}/swagger.json";
                var name = document.GroupName;
                options.SwaggerEndpoint(url, name);
            }
        });

        return app;
    }
}

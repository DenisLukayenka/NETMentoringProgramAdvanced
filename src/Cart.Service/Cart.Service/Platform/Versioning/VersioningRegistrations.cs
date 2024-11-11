using Asp.Versioning;

namespace Cart.Service.Platform.Versioning;

internal static class VersioningRegistrations
{
    public static IServiceCollection AddAppVersioning(this IServiceCollection services)
    {
        services
            .AddApiVersioning(options =>
            {
                options.DefaultApiVersion = VersionConstants.DefaultApiVersion;
                options.ReportApiVersions = true;
                options.AssumeDefaultVersionWhenUnspecified = true;
                options.ApiVersionReader = new UrlSegmentApiVersionReader();
            })
            // Really ugly, we need reference on Asp.Versioning.Mvc
            // But seems there is no workaround for versioned OpenAPI specs and Swagger
            // https://github.com/dotnet/aspnet-api-versioning/issues/830#issuecomment-1329373598
            .AddApiExplorer(options =>
            {
                options.GroupNameFormat = "'v'VVV";
                options.DefaultApiVersion = VersionConstants.DefaultApiVersion;
                options.AddApiVersionParametersWhenVersionNeutral = true;
                options.SubstituteApiVersionInUrl = true;
            })
            .EnableApiVersionBinding();

        return services;
    }
}

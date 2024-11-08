using Asp.Versioning;

namespace Cart.Service.Platform.Versioning;

internal static class VersioningRegistrations
{
    public static IServiceCollection AddAppVersioning(this IServiceCollection services)
    {
        services.AddApiVersioning(options =>
        {
            options.DefaultApiVersion = VersionConstants.DefaultApiVersion;
            options.ReportApiVersions = true;
            options.AssumeDefaultVersionWhenUnspecified = true;
            options.ApiVersionReader = new UrlSegmentApiVersionReader();
        });

        return services;
    }
}

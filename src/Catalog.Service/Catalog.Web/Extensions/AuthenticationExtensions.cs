using System.IdentityModel.Tokens.Jwt;
using Catalog.Web.Options;
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.Identity.Web;

namespace Catalog.Web.Extensions;

public static class AuthenticationExtensions
{
    public static IServiceCollection AddApplicationAuthentication(this IServiceCollection services, IConfiguration configuration)
    {
        JwtSecurityTokenHandler.DefaultMapInboundClaims = false;

        services.Configure<CookiePolicyOptions>(options =>
        {
            options.CheckConsentNeeded = context => true;
            options.MinimumSameSitePolicy = SameSiteMode.Unspecified;
            options.HandleSameSiteCookieCompatibility();
        });

        services
            .AddAuthentication(OpenIdConnectDefaults.AuthenticationScheme)
            .AddMicrosoftIdentityWebApp(configuration, Constants.AzureAdB2C)
            .EnableTokenAcquisitionToCallDownstreamApi()
            .AddDownstreamApi(
                nameof(DownstreamApisOptions.CategoriesList),
                configuration.GetSection(DownstreamApisOptions.CategoriesListPosition))
            .AddDownstreamApi(
                nameof(DownstreamApisOptions.CategoriesCreate),
                configuration.GetSection(DownstreamApisOptions.CategoriesCreatePosition))
            .AddInMemoryTokenCaches();

        services.AddOptions();
        services.Configure<OpenIdConnectOptions>(configuration.GetSection(Constants.AzureAdB2C));

        return services;
    }
}

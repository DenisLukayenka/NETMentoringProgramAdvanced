using Cart.Service.BusinessLogic;
using Cart.Service.DataAccess;
using Cart.Service.Platform;
using Cart.Service.Platform.Serialization;
using Cart.Service.Platform.Swagger;
using Cart.Service.Platform.Versioning;

namespace Cart.Service;

public static class ProgramServices
{
    public static WebApplicationBuilder RegisterAppServices(this WebApplicationBuilder builder)
    {
        builder.Services.AddAppSerialization();
        builder.Services.AddAppProblemDetails();
        builder.Services.AddAppVersioning();
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddAppSwagger();

        builder.Services
            .ConfigureBusinessLogicServices(builder.Configuration)
            .ConfigureDataAccessServices(builder.Configuration);

        return builder;
    }
}

using Cart.Service.BusinessLogic;
using Cart.Service.DataAccess;
using Cart.Service.Platform;
using Cart.Service.Platform.Serialization;

namespace Cart.Service;

public static class ProgramServices
{
    public static WebApplicationBuilder RegisterAppServices(this WebApplicationBuilder builder)
    {
        builder.Services.AddAppSerialization();
        builder.Services.AddAppOpenApi(builder.Environment);
        builder.Services.AddAppProblemDetails();

        builder.Services
            .ConfigureBusinessLogicServices(builder.Configuration)
            .ConfigureDataAccessServices(builder.Configuration);

        return builder;
    }
}

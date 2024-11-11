using Cart.Service.Endpoints;
using Cart.Service.Platform.Swagger;

namespace Cart.Service;

public static class ProgramPipelines
{
    public static WebApplication UseAppPipeline(this WebApplication app)
    {
        app.RegisterCartEndpoints();
        app.RegisterCartEndpointsV2();
        app.RegisterCartItemsEndpoints();

        app.UseAppSwagger();

        return app;
    }
}
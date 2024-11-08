﻿using Cart.Service.Endpoints;

namespace Cart.Service;

public static class ProgramPipelines
{
    public static WebApplication UseAppPipeline(this WebApplication app)
    {
        app.RegisterCartEndpoints();
        app.RegisterCartEndpointsV2();
        app.RegisterCartItemsEndpoints();

        return app;
    }
}
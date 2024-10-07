﻿using Cart.Service.Endpoints;
using Cart.Service.Platform.OpenApi;

namespace Cart.Service;

public static class ProgramPipelines
{
    public static WebApplication UseAppPipeline(this WebApplication app)
    {
        app.RegisterCartEndpoints();
        app.UseAppSwagger();

        return app;
    }
}
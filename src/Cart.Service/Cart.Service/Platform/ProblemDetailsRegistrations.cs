using FluentValidation;
using Microsoft.AspNetCore.Diagnostics;

namespace Cart.Service.Platform;

public static class ProblemDetailsRegistrations
{
    public static IServiceCollection AddAppProblemDetails(this IServiceCollection services)
    {
        services.AddProblemDetails(options =>
        {
            options.CustomizeProblemDetails = ctx =>
            {
                var exception = ctx.HttpContext.Features.Get<IExceptionHandlerPathFeature>()?.Error;

                if (exception is ValidationException validationException)
                {
                    ctx.ProblemDetails.Status = StatusCodes.Status422UnprocessableEntity;
                    ctx.ProblemDetails.Detail = validationException.Message;
                    ctx.HttpContext.Response.StatusCode = StatusCodes.Status422UnprocessableEntity;
                }
            };
        });

        return services;
    }
}

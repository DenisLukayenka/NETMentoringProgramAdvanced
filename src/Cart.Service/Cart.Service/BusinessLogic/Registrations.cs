using Cart.Service.BusinessLogic.Services;
using Cart.Service.BusinessLogic.Services.Abstractions;
using Cart.Service.BusinessLogic.Validators;
using FluentValidation;

namespace Cart.Service.BusinessLogic;

public static class Registrations
{
    public static IServiceCollection ConfigureBusinessLogicServices(this IServiceCollection services, IConfiguration configuration)
    {
        services
            .AddTransient<IOutboxMessageHandler, OutboxMessageHandler>()
            .AddTransient<ICartService, CartService>()
            .AddTransient<ICartItemService, CartItemService>()
            .AddScoped<IValidator<Models.CartItem>, CartItemValidator>();

        return services;
    }
}

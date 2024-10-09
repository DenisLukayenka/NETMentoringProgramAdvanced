namespace Cart.Service.Platform.Serialization;

public static class SerializationRegistrations
{
    public static IServiceCollection AddAppSerialization(this IServiceCollection services)
    {
        services.ConfigureHttpJsonOptions(options =>
        {
            options.SerializerOptions.TypeInfoResolverChain.Insert(0, AppJsonSerializerContext.Default);
        });

        return services;
    }
}

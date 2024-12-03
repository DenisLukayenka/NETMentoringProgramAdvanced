namespace Cart.Service;

public static class Program
{
    public static void Main(string[] args)
    {
        WebApplication
            .CreateSlimBuilder(args)
            .RegisterAppServices()
            .Build()
            .UseAppPipeline()
            .Run();
    }
}

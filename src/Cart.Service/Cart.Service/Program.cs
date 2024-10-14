namespace Cart.Service
{
    public class Program
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
}

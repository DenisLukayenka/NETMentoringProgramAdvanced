using System.Reflection;

namespace Cart.Service
{
    public class Program
    {
        internal static Version CurrentVersion = Assembly.GetExecutingAssembly().GetName().Version!;

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

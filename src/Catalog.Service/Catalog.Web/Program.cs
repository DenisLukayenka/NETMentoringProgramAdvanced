using Catalog.Web.Extensions;
using Catalog.Web.Services;
using Microsoft.Identity.Web.UI;

namespace Catalog.Web;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddHttpContextAccessor();
        builder.Services.AddRazorPages();
        builder.Services
            .AddControllersWithViews()
            .AddMicrosoftIdentityUI();

        builder.Services.AddApplicationAuthentication(builder.Configuration);

        builder.Services.AddScoped<ICategoryService, CategoryService>();

        var app = builder.Build();

        app.UseHttpsRedirection();

        app.UseRouting();
        app.UseAuthentication();
        app.UseAuthorization();

        app.MapRazorPages();
        app.MapControllerRoute(
            name: "Category",
            pattern: "{controller=Category}/{action=Index}/{id?}");

        app.Run();
    }
}

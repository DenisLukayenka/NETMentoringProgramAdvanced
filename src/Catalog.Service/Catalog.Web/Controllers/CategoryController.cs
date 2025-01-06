using Catalog.Web.Models;
using Catalog.Web.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Catalog.Web.Controllers;

public class CategoryController(ICategoryService categoryService) : Controller
{
    public async Task<IActionResult> Index(CancellationToken cancellationToken)
    {
        var categories = await categoryService.List(cancellationToken);

        return View(categories);
    }

    [HttpGet]
    [Authorize]
    public IActionResult Create()
    {
        return View();
    }

    [HttpPost]
    [Authorize]
    public async Task<IActionResult> Create(Category category, CancellationToken cancellationToken)
    {
        await categoryService.Create(category, cancellationToken);

        return RedirectToAction(nameof(Index));
    }
}

using Microsoft.Identity.Abstractions;

namespace Catalog.Web.Options;

public class DownstreamApisOptions
{
    public const string Position = "DownstreamApis";
    public const string CategoriesListPosition = "DownstreamApis:CategoriesList";
    public const string CategoriesCreatePosition = "DownstreamApis:CategoriesCreate";

    public DownstreamApiOptions CategoriesList { get; set; }
    public DownstreamApiOptions CategoriesCreate { get; set; }
}

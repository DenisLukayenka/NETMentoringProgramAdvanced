using System.ComponentModel.DataAnnotations;

namespace Cart.Service.DataAccess.Options;

public sealed class CosmosDbOptions
{
    public const string Position = "CosmosDb";

    [Required]
    public required string Endpoint { get; set; }

    [Required]
    public required string ResourceToken { get; set; }
}

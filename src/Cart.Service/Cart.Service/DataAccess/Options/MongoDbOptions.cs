using System.ComponentModel.DataAnnotations;

namespace Cart.Service.DataAccess.Options;

public sealed class MongoDbOptions
{
    public const string Position = "MongoDb";

    [Required]
    public required string ConnectionString { get; set; }
}

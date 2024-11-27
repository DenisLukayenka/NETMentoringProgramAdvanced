using System.ComponentModel.DataAnnotations;

namespace Cart.Service.DataAccess.Options;

public sealed class RedisOptions
{
    public const string Position = "Redis";

    [Required]
    public string? ConnectionString { get; set; }

    public int DbNumber { get; set; } = 1;

    public uint MaxValueLength { get; set; } = int.MaxValue;

    public int PoolSize { get; set; } = 1;
}

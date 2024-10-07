namespace Cart.Service.Options;

public class RedisOptions
{
    public const string Position = "Redis";

    public string? ConnectionString { get; set; }

    public int DbNumber { get; set; } = 1;
    public uint MaxValueLength { get; set; } = int.MaxValue;

    public int PoolSize { get; set; } = 1;
}

namespace Cart.Service.Options;

public class MessageBusOptions
{
    public const string Position = "MessageBus";

    public bool Enabled { get; set; }

    public string? ConnectionString { get; set; }
}

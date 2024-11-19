namespace Cart.Service.Options;

public class MessageBusOptions
{
    public const string Position = "MessageBus";

    public required string ConnectionString { get; set; }
}

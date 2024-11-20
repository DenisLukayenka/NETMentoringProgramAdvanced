namespace Lunis.SharedLibs.Catalog.OutboxEvents;

public class ProductUpdatedEvent : BaseMessage
{
    public DateTime Date { get; set; }

    public int ProductId { get; set; }
    public string? Name { get; set; }
    public decimal? Price { get; set; }
}

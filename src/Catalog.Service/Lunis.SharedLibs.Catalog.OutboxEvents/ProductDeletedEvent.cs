namespace Lunis.SharedLibs.Catalog.OutboxEvents;

public class ProductDeletedEvent : BaseMessage
{
    public DateTime Date { get; set; }

    public int ProductId { get; set; }
}

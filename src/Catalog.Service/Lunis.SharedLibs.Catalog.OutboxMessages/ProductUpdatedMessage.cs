namespace Lunis.SharedLibs.Catalog.OutboxMessages;

public class ProductUpdatedMessage : BaseMessage
{
    public DateTime Date { get; set; }

    public int ProductId { get; set; }
    public string Name { get; set; }
    public decimal Price { get; set; }
}

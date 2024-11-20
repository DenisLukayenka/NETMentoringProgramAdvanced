namespace Lunis.SharedLibs.Catalog.OutboxMessages;

public class ProductDeletedMessage : BaseMessage
{
    public DateTime Date { get; set; }

    public int ProductId { get; set; }
}

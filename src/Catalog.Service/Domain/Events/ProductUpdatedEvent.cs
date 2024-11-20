namespace Domain.Events;

public class ProductUpdatedEvent : BaseEvent
{
    public ProductUpdatedEvent() { }

    public ProductUpdatedEvent(int productId, string? name = null, decimal? price = null)
    {
        ProductId = productId;
        Name = name;
        Price = price;
    }

    public int ProductId { get; set; }

    public string? Name { get; set; }
    public decimal? Price { get; set; }
}

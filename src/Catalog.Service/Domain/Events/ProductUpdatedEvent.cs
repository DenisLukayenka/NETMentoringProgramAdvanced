namespace Domain.Events;

public class ProductUpdatedEvent : BaseEvent
{
    public ProductUpdatedEvent() { }

    public ProductUpdatedEvent(int productId, string name, decimal price)
    {
        ProductId = productId;
        Name = name;
        Price = price;
    }

    public int ProductId { get; set; }

    public string Name { get; set; } = null!;
    public decimal Price { get; set; }
}

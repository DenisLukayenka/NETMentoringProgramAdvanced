namespace Domain.Events;

public class ProductDeletedEvent : BaseEvent
{
    public ProductDeletedEvent()
    {
    }

    public ProductDeletedEvent(int id)
    {
        ProductId = id;
    }

    public int ProductId { get; set; }
}

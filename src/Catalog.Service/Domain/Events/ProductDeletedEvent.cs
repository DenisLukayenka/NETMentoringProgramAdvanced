namespace Domain.Events;

public class ProductDeletedEvent : BaseEvent
{
    public ProductDeletedEvent()
    {
    }

    public ProductDeletedEvent(int id)
    {
        ResourceId = id;
    }

    public int ResourceId { get; set; }
}

namespace Domain.Events;

public class ProductDeletedEvent : BaseEvent
{
    public int ResourceId { get; set; }
}

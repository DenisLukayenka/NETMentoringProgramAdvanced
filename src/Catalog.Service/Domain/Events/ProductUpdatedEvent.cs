namespace Domain.Events;

public class ProductUpdatedEvent : BaseEvent
{
    public string Payload { get; set; }
}

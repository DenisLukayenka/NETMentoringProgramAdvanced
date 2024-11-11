namespace Domain.Events;

public class ProductUpdatedEvent : BaseEvent
{
    public ProductUpdatedEvent() { }

    public ProductUpdatedEvent(string payload)
    {
        Payload = payload;
    }

    public string Payload { get; set; }
}

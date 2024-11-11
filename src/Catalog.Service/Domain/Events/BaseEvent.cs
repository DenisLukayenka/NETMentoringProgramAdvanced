namespace Domain.Events;

public abstract class BaseEvent : BaseEntity
{
    public string Discriminator { get; set; }
    public DateTime CreatedDate { get; set; }

    public bool Processed { get; set; }
    public DateTime ProcessedDate { get; set; }
}

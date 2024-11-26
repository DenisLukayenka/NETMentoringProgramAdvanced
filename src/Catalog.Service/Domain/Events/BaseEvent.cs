namespace Domain.Events;

public abstract class BaseEvent : BaseEntity
{
    public string Discriminator { get; set; }
    public DateTime CreatedDate { get; set; } = DateTime.UtcNow;

    public bool Processed { get; set; } = false;
    public DateTime? ProcessedDate { get; set; }
}

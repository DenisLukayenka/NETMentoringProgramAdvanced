using Domain.Events;
using OutboxEvents = Lunis.SharedLibs.Catalog.OutboxEvents;

namespace ApplicationCore.Outbox.Mappings;

internal static class OutboxMappings
{
    public static OutboxEvents.BaseMessage Map(this BaseEvent outboxEvent)
    {
        if (outboxEvent is ProductDeletedEvent deletedEvent)
            return deletedEvent.Map();

        else if (outboxEvent is ProductUpdatedEvent updatedEvent)
            return updatedEvent.Map();

        throw new InvalidCastException("Unsupported Outbox event object received.");
    }

    public static OutboxEvents.ProductUpdatedEvent Map(this ProductUpdatedEvent outboxEvent)
        => new()
        {
            Date = outboxEvent.CreatedDate,
            ProductId = outboxEvent.ProductId,
            Name = outboxEvent.Name,
            Price = outboxEvent.Price
        };

    public static OutboxEvents.ProductDeletedEvent Map(this ProductDeletedEvent outboxEvent)
        => new()
        {
            Date = outboxEvent.CreatedDate,
            ProductId = outboxEvent.ProductId
        };
}

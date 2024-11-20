using System.Text.Json.Serialization;

namespace Lunis.SharedLibs.Catalog.OutboxEvents;

[JsonPolymorphic(UnknownDerivedTypeHandling = JsonUnknownDerivedTypeHandling.FallBackToNearestAncestor)]
[JsonDerivedType(typeof(ProductDeletedEvent), 1)]
[JsonDerivedType(typeof(ProductUpdatedEvent), 2)]
public abstract class BaseMessage
{
}

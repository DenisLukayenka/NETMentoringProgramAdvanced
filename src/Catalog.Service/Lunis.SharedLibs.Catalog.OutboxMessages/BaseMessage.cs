using System.Text.Json.Serialization;

namespace Lunis.SharedLibs.Catalog.OutboxMessages;

[JsonPolymorphic(UnknownDerivedTypeHandling = JsonUnknownDerivedTypeHandling.FallBackToNearestAncestor)]
[JsonDerivedType(typeof(ProductDeletedMessage), 1)]
[JsonDerivedType(typeof(ProductUpdatedMessage), 2)]
public abstract class BaseMessage
{
}

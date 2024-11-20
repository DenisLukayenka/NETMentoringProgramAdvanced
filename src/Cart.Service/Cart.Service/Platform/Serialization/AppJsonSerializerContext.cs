using System.Text.Json.Serialization;
using Cart.Service.DataAccess.Options;
using Cart.Service.ViewModels;
using Lunis.SharedLibs.Catalog.OutboxMessages;

namespace Cart.Service.Platform.Serialization;

[JsonSerializable(typeof(Models.Cart))]
[JsonSerializable(typeof(Models.Cart[]))]
[JsonSerializable(typeof(Models.CartItem))]
[JsonSerializable(typeof(Models.CartItem[]))]
[JsonSerializable(typeof(RedisOptions))]
[JsonSerializable(typeof(ModelResponse<Models.Cart>))]
[JsonSerializable(typeof(BaseMessage))]
[JsonSerializable(typeof(ProductUpdatedMessage))]
[JsonSerializable(typeof(ProductDeletedMessage))]
internal partial class AppJsonSerializerContext : JsonSerializerContext
{

}

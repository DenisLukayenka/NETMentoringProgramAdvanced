using System.Text.Json.Serialization;
using Cart.Service.DataAccess.Options;

namespace Cart.Service.Platform.Serialization;

[JsonSerializable(typeof(Models.Cart))]
[JsonSerializable(typeof(Models.Cart))]
[JsonSerializable(typeof(Models.CartItem))]
[JsonSerializable(typeof(Models.CartItem[]))]
[JsonSerializable(typeof(RedisOptions))]
internal partial class AppJsonSerializerContext : JsonSerializerContext
{

}

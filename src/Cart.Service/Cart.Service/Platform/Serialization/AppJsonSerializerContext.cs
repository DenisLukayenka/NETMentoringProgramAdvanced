using System.Text.Json.Serialization;
using Cart.Service.DataAccess.Options;
using Cart.Service.ViewModels;

namespace Cart.Service.Platform.Serialization;

[JsonSerializable(typeof(Models.Cart))]
[JsonSerializable(typeof(Models.CartItem))]
[JsonSerializable(typeof(Models.CartItem[]))]
[JsonSerializable(typeof(RedisOptions))]
[JsonSerializable(typeof(ModelResponse<Models.Cart>))]
internal partial class AppJsonSerializerContext : JsonSerializerContext
{

}

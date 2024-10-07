﻿using System.Text.Json.Serialization;

namespace Cart.Service.Platform.Serialization;

[JsonSerializable(typeof(Models.Cart[]))]
[JsonSerializable(typeof(Models.Cart))]
[JsonSerializable(typeof(Options.RedisOptions))]
internal partial class AppJsonSerializerContext : JsonSerializerContext
{

}

using Newtonsoft.Json;

namespace Cart.Service.Models;

public class Cart
{
    [JsonProperty("id")]
    public required string Id { get; set; }

    public CartItem[] Items { get; set; } = [];
}

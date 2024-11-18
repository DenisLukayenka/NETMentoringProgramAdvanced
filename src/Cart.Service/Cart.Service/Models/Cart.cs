using System.Text.Json.Serialization;

namespace Cart.Service.Models;

public class Cart
{
    [JsonPropertyName("id")]
    public required string Id { get; set; }

    public CartItem[] Items { get; set; } = [];
}

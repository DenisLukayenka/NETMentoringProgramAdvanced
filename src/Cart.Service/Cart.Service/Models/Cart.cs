namespace Cart.Service.Models;

public class Cart
{
    public required string Id { get; set; }

    public CartItem[] Items { get; set; } = [];
}

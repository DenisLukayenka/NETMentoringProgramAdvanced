namespace Cart.Service.Models;

public class Cart
{
    public int Id { get; set; }

    public required string Name { get; set; }
    public decimal Price { get; set; }
    public int Quantity { get; set; }

    public string? ImageUrl { get; set; }
    public string? ImageAlt { get; set; }
}

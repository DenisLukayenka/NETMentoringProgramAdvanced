﻿namespace Cart.Service.Models;

public class CartItem
{
    public int ItemId { get; set; }

    public required string Name { get; set; }

    public decimal Price { get; set; }

    public int Quantity { get; set; }

    public string? ImageUrl { get; set; }

    public string? ImageAlt { get; set; }
}

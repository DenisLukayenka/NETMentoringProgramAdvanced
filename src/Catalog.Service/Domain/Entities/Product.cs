namespace Domain.Entities;

public class Product : BaseEntity
{
    public string Name { get; set; } = null!;
    public string Description { get; set; } = null!;
    public string? Image { get; set; }
    public decimal Price { get; set; }
    public int Amount { get; set; }

    public int CategoryId { get; set; }
    public Category Category { get; set; } = null!;
}

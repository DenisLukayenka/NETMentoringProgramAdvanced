namespace Domain.Entities;

public class Product : BaseEntity
{
    public string Name { get; set; }
    public string Description { get; set; }
    public string? Image { get; set; }
    public Category Category { get; set; }
    public decimal Price { get; set; }
    public int Amount { get; set; }
}

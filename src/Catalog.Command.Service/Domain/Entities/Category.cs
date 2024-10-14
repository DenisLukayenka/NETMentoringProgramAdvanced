namespace Domain.Entities;

public class Category : BaseEntity
{
    public string Name { get; set; }
    public string? Image { get; set; }
    public Category? ParentCategory { get; set; }
    public IList<Product> Products { get; private set; } = [];
}

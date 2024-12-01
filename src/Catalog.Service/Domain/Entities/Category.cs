namespace Domain.Entities;

public class Category : BaseEntity
{
    public string Name { get; set; } = null!;
    public string? Image { get; set; }

    public int? ParentCategoryId { get; set; }
    public Category? ParentCategory { get; set; }
    public IList<Category> ChildCategories { get; set; } = [];

    public IList<Product> Products { get; private set; } = [];
}

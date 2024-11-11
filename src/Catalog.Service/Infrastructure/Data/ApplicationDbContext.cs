using Domain.Entities;
using Domain.Events;
using Infrastructure.Abstractions;
using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace Infrastructure.Data;

internal class ApplicationDbContext : DbContext, IApplicationDbContext
{
    public ApplicationDbContext()
    { }

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    { }

    public DbSet<Category> Categories => Set<Category>();
    public DbSet<Product> Products => Set<Product>();
    public DbSet<BaseEvent> Events => Set<BaseEvent>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
    }
}

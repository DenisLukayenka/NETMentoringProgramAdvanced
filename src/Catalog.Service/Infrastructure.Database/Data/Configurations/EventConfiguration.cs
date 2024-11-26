using Domain.Events;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Database.Data.Configurations;

public class EventConfiguration : IEntityTypeConfiguration<BaseEvent>
{
    public void Configure(EntityTypeBuilder<BaseEvent> builder)
    {
        builder
            .HasDiscriminator(x => x.Discriminator)
            .HasValue<ProductUpdatedEvent>(nameof(ProductUpdatedEvent))
            .HasValue<ProductDeletedEvent>(nameof(ProductDeletedEvent));
    }
}

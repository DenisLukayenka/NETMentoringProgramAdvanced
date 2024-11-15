using FluentValidation;

namespace ApplicationCore.Products.Commands.CreateProduct;

internal class CreateProductCommandValidator : AbstractValidator<CreateProductCommand>
{
    public CreateProductCommandValidator()
    {
        RuleFor(x => x.Name)
            .Cascade(CascadeMode.Stop)
            .NotEmpty()
            .MaximumLength(50);

        RuleFor(x => x.Image)
            .Must(MustBeValidUrl)
            .When(x => !string.IsNullOrEmpty(x.Image))
            .WithMessage("'{PropertyName}' is not valid url.");

        RuleFor(x => x.CategoryId)
            .NotEmpty();

        RuleFor(x => x.Price)
            .GreaterThan(0);

        RuleFor(x => x.Amount)
            .GreaterThan(0);
    }

    private static bool MustBeValidUrl(string? value)
    {
        try
        {
            var url = new Uri(value!);

            return true;
        }
        catch
        {
            return false;
        }
    }
}

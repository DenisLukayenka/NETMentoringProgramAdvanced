using FluentValidation;

namespace ApplicationCore.Categories.Commands.UpdateCategory;

internal class UpdateCategoryCommandValidator : AbstractValidator<UpdateCategoryCommand>
{
    public UpdateCategoryCommandValidator()
    {
        RuleFor(x => x.Name)
            .Cascade(CascadeMode.Stop)
            .NotEmpty()
            .MaximumLength(50);

        RuleFor(x => x.Image)
            .Must(MustBeValidUrl)
            .When(x => !string.IsNullOrEmpty(x.Image))
            .WithMessage("'{PropertyName}' is not valid url.");
    }

    private static bool MustBeValidUrl(string value)
    {
        try
        {
            var url = new Uri(value);

            return true;
        }
        catch
        {
            return false;
        }
    }
}

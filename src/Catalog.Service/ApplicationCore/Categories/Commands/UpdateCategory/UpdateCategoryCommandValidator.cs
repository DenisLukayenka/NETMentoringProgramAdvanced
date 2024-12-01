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
            .Must(value => value.IsValidUrl())
            .When(x => !string.IsNullOrEmpty(x.Image))
            .WithMessage("'{PropertyName}' is not valid url.");
    }
}

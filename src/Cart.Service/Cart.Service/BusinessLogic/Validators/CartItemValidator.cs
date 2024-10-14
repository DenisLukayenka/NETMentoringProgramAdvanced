using FluentValidation;

namespace Cart.Service.BusinessLogic.Validators;

public class CartItemValidator : AbstractValidator<Models.CartItem>
{
    public CartItemValidator()
    {
        RuleFor(x => x.ItemId)
            .NotEmpty();

        RuleFor(x => x.Name)
            .NotNull()
            .NotEmpty();

        RuleFor(x => x.Price)
            .GreaterThan(0);

        RuleFor(x => x.Quantity)
            .GreaterThan(0);
    }
}

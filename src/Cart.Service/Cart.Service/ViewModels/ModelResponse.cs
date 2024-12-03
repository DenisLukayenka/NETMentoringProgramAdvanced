namespace Cart.Service.ViewModels;

internal class ModelResponse<T>
{
    public required T Payload { get; set; }

    public ModelAction[] Actions { get; set; } = [];
}

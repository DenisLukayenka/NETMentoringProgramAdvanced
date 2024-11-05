namespace Cart.Service.ViewModels;

internal class ModelResponse<T>
{
    public T Payload { get; set; }
    public ModelAction[] Actions { get; set; }
}

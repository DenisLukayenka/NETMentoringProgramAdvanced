namespace ApplicationCore.Common.Exceptions;

[Serializable]
public class EntityNotFoundException : Exception
{
    public EntityNotFoundException()
        : this("Entity was not found.")
    {
    }

    public EntityNotFoundException(string message)
        : base(message)
    {
    }

    public EntityNotFoundException(string? message, Exception? innerException)
        : base(message, innerException)
    {
    }
}

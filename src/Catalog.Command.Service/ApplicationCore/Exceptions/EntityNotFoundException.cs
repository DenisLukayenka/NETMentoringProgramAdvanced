namespace ApplicationCore.Exceptions;

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
}

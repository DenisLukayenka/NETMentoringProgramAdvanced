namespace ApplicationCore.Common.Extensions;

internal static class StringExtensions
{
    public static bool IsValidUrl(this string? value)
    {
        if (string.IsNullOrEmpty(value))
            return true;

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

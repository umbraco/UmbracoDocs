namespace Umbraco.Docs.Preview.UI.MiscellaneousOurStuff
{
    public static class ConventionExtensions
    {
        public static string EnsureNoDotsInUrl(this string url)
        {
            return url.Replace(".", "_")
                .Replace("__", "..")
                .Replace("_md", "")
                .Replace("_png", ".png")
                .Replace("_jpg", ".jpg")
                .Replace("_pdf", ".pdf")
                .Replace("_gif", ".gif");
        }

        public static string UnderscoreToDot(this string str)
        {
            return str.Replace("_", ".");
        }
        public static string DotToUnderscore(this string str)
        {
            return str.Replace(".", "_");
        }

        public static string RemoveDash(this string str)
        {
            return str.Replace("-", " ");
        }

        public static string EnsureCorrectDocumentationText(this string str)
        {
            return str.Replace("documentation", "Documentation");
        }
    }
}

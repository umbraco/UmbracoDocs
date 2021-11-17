namespace Umbraco.Docs.Preview.UI.Services
{
    public interface IMarkdownService
    {
        string RenderMarkdown(string path, string folder);
    }
}

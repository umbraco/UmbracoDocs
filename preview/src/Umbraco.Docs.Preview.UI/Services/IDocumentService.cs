using System.Collections.Generic;

namespace Umbraco.Docs.Preview.UI.Services
{
    public interface IDocumentService
    {
        bool TryFindMarkdownFile(string slug, out string path);

        IEnumerable<string> GetAlternates(string path);
    }
}

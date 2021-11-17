using System.Collections.Generic;
using Umbraco.Docs.Preview.UI.MiscellaneousOurStuff;

namespace Umbraco.Docs.Preview.UI.Models
{
    public class DocumentationViewModel
    {
        public string Path { get; init; }
        public string FolderName { get; init; }
        public string Markup { get; init; }
        public DocumentationUpdater.SiteMapItem Navigation { get; init; }
        public List<string> Alternates { get; init; }


        public bool IsCurrent(string alternate)
        {
            return alternate.Equals(System.IO.Path.GetFileNameWithoutExtension(Path));
        }

        public override string ToString()
        {
            return Path;
        }
    }
}

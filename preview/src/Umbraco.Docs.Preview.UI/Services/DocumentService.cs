using System;
using System.IO;
using Microsoft.AspNetCore.Hosting;

namespace Umbraco.Docs.Preview.UI.Services
{
    public class DocumentService : IDocumentService
    {
        private readonly IWebHostEnvironment _env;
        private string _docsRoot;

        public DocumentService(IWebHostEnvironment env)
        {
            _env = env ?? throw new ArgumentNullException(nameof(env));
        }

        string DocsRoot
        {
            get
            {
                if (!string.IsNullOrEmpty(_docsRoot))
                    return _docsRoot;

                _docsRoot = _env.ContentRootPath.Split("preview")[0];

                return _docsRoot;
            }
        }

        public bool TryFindMarkdownFile(string slug, out string path)
        {
            if (slug == null)
            {
                path = Path.Combine(DocsRoot, "index.md");
                return System.IO.File.Exists(path);
            }

            path = Path.Combine(DocsRoot, Path.Combine(slug.Split("/"))) + ".md";
            if (System.IO.File.Exists(path))
            {
                return true;
            }

            path = Path.Combine(DocsRoot, Path.Combine(slug.Split("/")), "index.md");
            if (System.IO.File.Exists(path))
            {
                return true;
            }

            path = null;
            return false;
        }
    }
}

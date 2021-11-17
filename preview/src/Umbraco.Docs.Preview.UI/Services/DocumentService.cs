using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
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

        public string DocsRoot
        {
            get
            {
                if (!string.IsNullOrEmpty(_docsRoot))
                    return _docsRoot;

                _docsRoot = Path.GetDirectoryName(_env.ContentRootPath.Split("preview")[0]);

                return _docsRoot;
            }
        }

        public bool TryFindMarkdownFile(string slug, out string path)
        {
            if (slug == null)
            {
                path = Path.Combine(DocsRoot, "index.md");
                return File.Exists(path);
            }

            path = Path.Combine(DocsRoot, Path.Combine(slug.Split("/"))) + ".md";
            if (File.Exists(path))
            {
                return true;
            }

            path = Path.Combine(DocsRoot, Path.Combine(slug.Split("/")), "index.md");
            return File.Exists(path);
        }

        public IEnumerable<string> GetAlternates(string path)
        {
            // TODO: parse version numbers, might not even be worth it.
            var directory = Path.GetDirectoryName(path);

            return Directory
                .GetFiles(directory!)
                .Where(x =>
                {
                    var orig = Path.GetFileNameWithoutExtension(path);
                    var isVersioned = Regex.Match(orig, @"(.*?)-v\d");

                    var unVersioned = isVersioned.Success ? isVersioned.Groups[1].Value : orig;
                    var alt = Path.GetFileNameWithoutExtension(x);

                    return alt.StartsWith(unVersioned);
                })
                .Select(Path.GetFileNameWithoutExtension)
                .OrderBy(x => x);
        }

        public string GetDocumentFolder(string path)
        {
            var dir = Path.GetDirectoryName(path);

            if (DocsRoot.Equals(dir))
            {
                return string.Empty;
            }

            return dir!.Split(DocsRoot)[1].TrimStart(Path.DirectorySeparatorChar);
        }
    }
}

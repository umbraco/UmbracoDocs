using System.Linq;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Docs.Preview.UI.MiscellaneousOurStuff;
using Umbraco.Docs.Preview.UI.Models;
using Umbraco.Docs.Preview.UI.Services;


namespace Umbraco.Docs.Preview.UI.Controllers
{
    [Route("documentation")]
    public class DocumentationController : Controller
    {
        private readonly IDocumentService _docs;
        private readonly IMarkdownService _md;
        private readonly DocumentationUpdater _ourDocsUpdater;

        public DocumentationController(IDocumentService docs, IMarkdownService md, DocumentationUpdater ourDocsUpdater)
        {
            _docs = docs;
            _md = md;
            _ourDocsUpdater = ourDocsUpdater;
        }

        [HttpGet("{**slug}")]
        public IActionResult Index(string slug)
        {
            if (!$"{Request.Path}".EndsWith("/"))
            {
                return RedirectPermanent($"{Request.Path}/");
            }

            if (!_docs.TryFindMarkdownFile(slug, out var path))
            {
                return NotFound();
            }

            var folder = _docs.GetDocumentFolder(path);
            var model = new DocumentationViewModel
            {
                Path = path,
                FolderName = folder,
                Markup = _md.RenderMarkdown(path, folder),
                Navigation = _ourDocsUpdater.BuildSitemap(),
                Alternates = _docs.GetAlternates(path).ToList()
            };

            return View("DocumentationSubpage", model);
        }
    }
}

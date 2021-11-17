using Microsoft.AspNetCore.Mvc;
using Umbraco.Docs.Preview.UI.Models;
using Umbraco.Docs.Preview.UI.Services;


namespace Umbraco.Docs.Preview.UI.Controllers
{
    [Route("documentation")]
    public class DocumentationController : Controller
    {
        private readonly IDocumentService _docs;
        private readonly IMarkdownService _md;

        public DocumentationController(IDocumentService docs, IMarkdownService md)
        {
            _docs = docs;
            _md = md;
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

            var model = new DocumentationViewModel
            {
                Path = path,
                Markup = _md.RenderMarkdown(path)
            };

            return View("DocumentationSubpage", model);
        }
    }
}

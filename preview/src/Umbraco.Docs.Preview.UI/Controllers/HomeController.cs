using Microsoft.AspNetCore.Mvc;

namespace Umbraco.Docs.Preview.UI.Controllers
{

    public class HomeController : Controller
    {
        [HttpGet("")]
        public IActionResult Index()
        {
            return RedirectToActionPermanent("Index", "Documentation");
        }
    }
}

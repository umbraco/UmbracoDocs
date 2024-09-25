# Controller & Action Selection

When you make a page request to the MVC application, a controller is responsible for returning the response to that request. The controller can perform one or more actions. The controller action can return different types of action results based on the request.

## Default Controller Action

By default, Umbraco will execute every request via it's built-in default controller: `Umbraco.Cms.Web.Common.Controllers.RenderController`. Umbraco site automatically routes all the front-end requests via the `Index` action of the `RenderController`.

```csharp
using Umbraco.Cms.Web.Common.Controllers;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Umbraco.Cms.Core.Web;
using Microsoft.AspNetCore.Mvc;

namespace UmbracoProject.Controller;

public class HomePageController : RenderController
{

    public HomePageController(ILogger<RenderController> logger, ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor)
    : base(logger, compositeViewEngine, umbracoContextAccessor)
    {
    }
    public override IActionResult Index()
    {
        return CurrentTemplate(CurrentPage);
    }

    public IActionResult HomePage()
    {
        return CurrentTemplate(CurrentPage);
    }
}
```

## Change the Default Controllers

It is possible to implement a custom Controller to replace the default implementation to give complete control during the Umbraco request pipeline execution. You can configure Umbraco to use your implementation in a class. For example:

{% code title="MyRenderController.cs" lineNumbers="true" %}

```csharp
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;
using Umbraco.Cms.Web.Website.Controllers;

namespace YourProjectNamespace;

public class MyRenderController : RenderController
{
 public MyRenderController(
  ILogger<MyRenderController> logger,
  ICompositeViewEngine compositeViewEngine,
  IUmbracoContextAccessor umbracoContextAccessor)
  : base(logger, compositeViewEngine, umbracoContextAccessor)
 {
 }

 public override IActionResult Index() => Ok("MyRenderController Index method hit with CurrentPage.Name set to: " + CurrentPage?.Name);
}

public class MyComposer : IComposer
{
 public void Compose(IUmbracoBuilder builder)
 {
  builder.Services.Configure<UmbracoRenderingDefaultsOptions>(renderOptions
   => renderOptions.DefaultControllerType = typeof(MyRenderController));
 }
}
```

{% endcode %}

Ensure that the controller inherits from the base controller `Umbraco.Cms.Web.Common.Controllers.RenderController`. You can override the `Index` method to perform any customizations of your choice.

## Custom Controller Selection

You can create Custom controllers for different Document Types and Templates. This is termed 'Hijacking Umbraco Routes'. For details on how this process works, see the [Custom MVC Controllers (Umbraco Route Hijacking)](../../reference/routing/custom-controllers.md) article.

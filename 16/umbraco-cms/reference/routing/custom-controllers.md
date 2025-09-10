---
description: >-
  Use a custom MVC controller to handle and control incoming requests for
  content pages based on a specific Document Type, also called Route Hijacking.
---

# Custom MVC controllers (Umbraco Route Hijacking)

_Use a custom controller to handle and control incoming requests for content pages based on a specific Document Type_

## What is Umbraco Route Hijacking?

By default, all front-end requests to an Umbraco site are auto-routed via the 'Index' action of a core Controller: `Umbraco.Cms.Web.Common.Controllers.RenderController`. This core controller handles the incoming request, builds the associated PublishedContent model, and passes this to the appropriate Umbraco Template/MVC View.

It is however possible to implement a custom Controller to replace this default implementation to give complete control over this execution.

For example:

* To enrich the view model passed to the template with additional properties (from other published content items or outside Umbraco)
* To implement serverside paging
* To implement any custom/granular security
* To return alternative templates depending on some custom business logic

This replacement of the default controller can be made 'globally' for all requests (see last example). It can also be by _'hijacking'_ requests for types of pages based on their specific Document Type following this controller naming convention: `[DocumentTypeAlias]Controller`.

## Creating a custom controller

### Example: Hijacking route requests to a 'product' page

In the following example, imagine an Umbraco site with a set of 'product' pages created from a Document Type called 'Product Page' with an alias 'productPage'.

Create a custom locally declared controller in the Umbraco web application project named 'ProductPageController'.

Ensure that this controller inherits from the base controller `Umbraco.Cms.Web.Common.Controllers.RenderController`.

eg:

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;

namespace My.Website;

public class ProductPageController : RenderController
{
    public ProductPageController(ILogger<ProductPageController> logger, ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor)
        : base(logger, compositeViewEngine, umbracoContextAccessor)
    {
    }

    public override IActionResult Index()
    {
        // you are in control here!

        // return a 'model' to the selected template/view for this page.
        return CurrentTemplate(CurrentPage);
    }
}
```

All requests to any **product** pages in the site will be **hijacked** and routed through the custom ProductPageController.

If you prefer to use an async controller your need to override both the sync and the async Index()-methods. This is done to disable the default behavior from the base controller.

```csharp
public class ProductPageController : RenderController
{

    [NonAction]
    public sealed override IActionResult Index() => throw new NotImplementedException();
    public async Task<IActionResult> Index(CancellationToken cancellationToken)
    {
        await SomethingAsync(cancellationToken);
        return CurrentTemplate(CurrentPage);
    }
}
```

This example shows the default behavior that Umbraco's core RenderController provides. The 'Index' action of the controller is executed, and the CurrentTemplate helper sends the model containing the details of the published content item related to the request to the relevant template/view.

## Routing via template

A further convention is that if an action on the controller has a name that matches the template name, this action will be executed instead of the default 'Index' action.

### Example: Hijacking route requests to a 'product' for an alternative 'AMP' template

In this example, the Product Page Document Type has two templates 'ProductPage' and 'ProductAmpPage'. We can hijack and handle the requests to the two templates differently.

Create the Controller as before:

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;


namespace My.Website;

public class ProductPageController : RenderController
{
    public ProductPageController(ILogger<ProductPageController> logger, ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor)
        : base(logger, compositeViewEngine, umbracoContextAccessor)
    {
    }

    // Any request for the 'ProductAmpPage' template will be handled by this Action
    public IActionResult ProductAmpPage()
    {
        // Create AMP specific content here...
        return CurrentTemplate(CurrentPage);
    }

    public override IActionResult Index()
    {
        // you are in control here!

        // return a 'model' to the selected template/view for this page.
        return CurrentTemplate(CurrentPage);
    }
}
```

#### How can a page be requested via two different templates?

The page in Umbraco will have a single 'template' selected as it's default template, but it's possible to call this same page on a different template by adding `?altTemplate=othertemplatename` to the Url QueryString eg:

`/products/superfancyproduct/?altTemplate=ProductAmpPage`

### Summary - How the route hijacking convention works

* Document Type name = controller name
* Template name = action name (if no action matches or is not specified - then the 'Index' action will be executed).
* Controller Inherits from `Umbraco.Cms.Web.Common.Controllers.RenderController`

## Returning a view with a custom model

The steps to achieve this will differ, depending if your template views are using IPublishedContent or Modelsbuilder generated Models.

### Changing the @inherits directive of your template

By default, your Umbraco Template will be based on the `ContentModel` that the default `RenderController` passes through to it.

The default inherits statement:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
```

or if you are using **modelsbuilder**:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ProductPage>
```

`<>` contains a model generated for each Document Type to give strongly typed access to the Document Type properties in the template view.

To use a specific custom view model, the `@inherits` directive will need to be updated to reference your custom model using the `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<T>` format where 'T' is the type of your custom model.

So for example, if your custom model is of type 'MyProductViewModel' then your `@inherits` directive will look like:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<MyProductViewModel>
```

{% hint style="info" %}
Views will likely specify a master view to use as the common layout for the site HTML. When using a custom view model it's necessary to make sure this doesn't conflict with any implementation in the master layout view. Eg. if your master layout view is inheriting from a specific model `UmbracoViewPage<SpecificModel>` and using a property from SpecificModel that isn't available in your custom model an exception will be thrown. To avoid this you could:

* Keep your Master layout view 'generically typed', eg. only have `@inherits UmbracoViewPage`, and use Model.Value syntax to access properties. or
* Break the dependency on `Umbraco.Cms.Core.Models` in your master layout by having it instead inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ISomeInterface>`. This would be where ISomeInterface is implemented by all your models and contains the properties that the master layout view uses. or
* Ensure your custom models inherit from whichever class is used to strongly type the master layout view.
{% endhint %}

In most cases you will need your custom model to build upon the underlying existing PublishedContent model for the page. This can be achieved by making your custom model inherit from a special base class called `PublishedContentWrapped`:

```csharp
public class MyProductViewModel : PublishedContentWrapped
{
    // The PublishedContentWrapped accepts an IPublishedContent item as a constructor
    public MyProductViewModel(IPublishedContent content, IPublishedValueFallback publishedValueFallback) : base(content, publishedValueFallback)
    {
    }

    // Custom properties here...
    public int StockLevel { get; set; }
    public IEnumerable<Distributor> ProductDistributors { get; set; }
}
```

`PublishedContentWrapped` will take care of populating all the usual underlying Umbraco properties and means the `@Model.` syntax will continue to work in the layouts used by your template.

Using Modelsbuilder you will find that all the generated models have a constructor that takes an IPublishedContent item in a similar way:

```csharp
public class MyProductViewModel : ProductPage
{
    // The ProductPage model accepts an IPublishedContent item as a constructor
    public MyProductViewModel(IPublishedContent content, IPublishedValueFallback publishedValueFallback) : base(content, publishedValueFallback)
    {
    }

    // Custom properties here...
    public int StockLevel { get; set; }
    public IEnumerable<Distributor> ProductDistributors { get; set; }
}
```

{% hint style="info" %}
The models generated by Modelsbuilder are created as partial classes so it's possible to extend them by adding your own partial classes with matching signature.
{% endhint %}

We can now populate our custom view model in our controller and use the values from the custom model in our template view:

```csharp
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;
using My.Website.Models;


namespace My.Website;

public class ProductPageController : RenderController
{
    private readonly IVariationContextAccessor _variationContextAccessor;
    private readonly ServiceContext _serviceContext;
    public ProductPageController(ILogger<ProductPageController> logger, ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor, IVariationContextAccessor variationContextAccessor, ServiceContext context)
        : base(logger, compositeViewEngine, umbracoContextAccessor)
    {
        _variationContextAccessor = variationContextAccessor;
        _serviceContext = context;
    }

    public override IActionResult Index()
    {

            // you are in control here!
            // create our ViewModel based on the PublishedContent of the current request:
            // set our custom properties
            var productViewModel = new MyProductViewModel(CurrentPage, new PublishedValueFallback(_serviceContext, _variationContextAccessor))
            {
                StockLevel = 4,
                ProductDistributors = new List<Distributor>()
            };


            // return our custom ViewModel
            return CurrentTemplate(productViewModel);

    }
}
```

and in our template

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<MyProductViewModel>
@{
Layout = "Master";
}
<h1>@Model.Name</h1>

@(Model.Value<IHtmlString>("productDescription"))
// or using Modelsbuilder
@Model.ProductDescription

<dl>
<dt>Stock Level</dt>
<dd>@Model.StockLevel</dd>
<dt>Distributors</dt>
@foreach (var distributor in Model.Distributors){
<dd>@distributor.Name</dd>
}
```

## Processing QueryString values in the controller

You can also pass values directly into the controller action using the query string.

```
?page=1&andanotherthing=umbraco
```

The values in the `querystring` will be bound to the matching parameters defined in the controller's action:

```csharp
public class ProductListingPageController : Umbraco.Cms.Web.Common.Controllers.RenderController
{
   //notice how we are no longer overriding the Index action because the signature is now different to the base signature.
    [HttpGet]
    public IActionResult Index([FromQuery(Name = "page")] int page, [FromQuery(Name = "andAnotherThing")] string andAnotherThing)
    {
       var products = _madeUpProductService.GetProductsByPage(page);
       var productListingViewModel = new ProductListingViewModel(CurrentPage, new PublishedValueFallback(_serviceContext, _variationContextAccessor));
       productListingViewModel.Products = products;
       productListViewModel.Thing = andAnotherThing;

       return CurrentTemplate(productListViewModel);
    }
}
```

## Controller Injection

Injecting services into your controller constructors is possible with Umbraco's underlying dependency injection implementation. See [Services and Helpers](../../implementation/services/README.md#custom-services-and-helpers) for more info on this.

For example:

```csharp
public class ProductListingPageController : RenderController
{
    private readonly IMadeUpProductService _madeUpProductService;

    public ProductListingPageController(ILogger<RenderController> logger, ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor, IMadeUpProductService madeUpProductService)
    {
        _madeUpProductService = madeUpProductService;
    }

    public override IActionResult Index()
    {
        var products = _madeUpProductService.GetProductsByPage(page);
        ...
    }
}
```

To wire up a concrete instance of IMadeUpProductService, use a composer:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace MyWebsite.Composers;

public class RegisterSuperSiteServiceComposer : IUserComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IMadeUpProductService, MadeUpProductService>();
    }
}
```

See [Composing](../../implementation/composing.md) for further information.

## Replace Umbraco's default `RenderController`

You can replace Umbraco's default implementation of RenderController with your own custom controller for all MVC requests. This is possible by assigning your own default controller type in the Umbraco setup during initialization.

You can achieve this by updating the options for `UmbracoRenderingDefaultsOptions` in `Program.cs`.

First of all, you have to create your own controller. Your custom implementation of RenderController should either inherit from the core `RenderController` as in the examples above or implement the `IRenderController` interface.

Implement the `IRenderController`:

```csharp
public class MyRenderController : IRenderController
{
    public IActionResult Index()
    {
        return new OkObjectResult("Hello from your custom Render Controller");
    }
}
```

Or inherit from `RenderController`

```csharp
public class MyRenderController : RenderController
{
    public MyRenderController(ILogger<RenderController> logger, ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor)
        : base(logger, compositeViewEngine, umbracoContextAccessor)
    {
    }

    public override IActionResult Index()
    {
        // Add some custom logic here.
        return CurrentTemplate(CurrentPage);
    }
}
```

The last step is to configure Umbraco to use your implementation. You can do that in the `Program.cs` class.

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

builder.Services.Configure<UmbracoRenderingDefaultsOptions>(c =>
{
    c.DefaultControllerType = typeof(MyRenderController);
});
```

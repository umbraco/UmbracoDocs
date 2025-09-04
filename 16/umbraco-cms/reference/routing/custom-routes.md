---
description: "Setting up your own controllers and routes that exist alongside the Umbraco pipeline."
---

# Custom MVC Routes

_Documentation about how to setup your own custom controllers and routes that need to exist alongside the Umbraco pipeline_

## Where to put your routing logic?

There's two places you can specify your routing, depending on whether it's in the context of a package, or your own site. If it's your own site you can do it in the `Program.cs` file, within the `WithEndpoints` method call like so:

```csharp
app.UseUmbraco()
    .WithMiddleware(u =>
    {
        u.UseBackOffice();
        u.UseWebsite();
    })
    .WithEndpoints(u =>
    {
        // This is where to put the custom routing

        u.UseBackOfficeEndpoints();
        u.UseWebsiteEndpoints();
    });
```

If you're creating a package you won't have access to the `Program.cs` file. Instead you must use a composer, for an example of this, see the example below.

## User defined routes

Umbraco doesn't interfere with any user defined routes that you wish to have. Your custom routes to your own custom controllers will work perfectly and seamlessly alongside Umbraco's routes.

## Custom routes within the Umbraco pipeline

For a request to be considered executing in an Umbraco context, and therefore the Umbraco pipeline, it needs to have an HTTP request feature with the type `UmbracoRouteValues`, all the information required for Umbraco to handle the request is stored there. The question is now, how do we add this request feature? There's three possibilities:

1. Do it manually - This requires that you have a custom route, controller, even middleware, and manually assign the `UmbracoRouteValues` as an HTTP request feature, however you see fit. To create an `UmbracoRouteValues` object generally requires: `IUmbracoContextAccessor` (to access the `CleanedUmbracoUrl`), `IPublishedRouter` (to create the `IPublishedRequestBuilder`), `IPublishedRequestBuilder` (to set the published content and to build the `IPublishedRequest`), `IPublishedRequest` to assign to the `UmbracoRouteValues`. As you can see this is a lot of work, but luckily there's some much easier ways.
2. Route a custom controller that implements the `IVirtualPageController` interface, assigning the `UmbracoRouteValues` to the HTTP requests will then be taken care of for you.
3. Route a custom controller with conventional routing, using the typical call to `endpoints.MapControllerRoute`, and then call `.ForUmbracoPage()` with an action for finding content on what `MapControllerRoute` returns, now `UmbracoRouteValues` will automatically be applied to any request to that controller.

Don't fret if this all seems a bit overwhelming, we'll be going through an example of the last two options.

### Custom route with IVirtualPageController

As mentioned, with this approach we need to implement the `IVirtualPageController` interface, this interface only has one method `FindContent` which accepts an `ActionExecutingContext`:

```csharp
IPublishedContent FindContent(ActionExecutingContext actionExecutingContext);
```

It can also be helpful to inherit from the `UmbracoPageController` since this includes some useful helper methods such as `CurrentPage`, do however note that it is _not_ possible to inherit from `RenderController` when doing custom routes like this.

Let's create a shop controller, with an Index action showing all our products. We will also add a Product action showing custom data about the product that could exists outside Umbraco. A common approach in a scenario like this is to have a "real" Umbraco node as a starting point. In this example we will use an empty "Products" Document Type with a Collection, and "Product" Document Type containing a Stock-Keeping Unit (SKU). We also need some content based on those document types, a "Products" content node, which contains two product nodes, each with their own SKU.

After that bit of setup we can go ahead and create our shop controller which inherits from `UmbracoPageController` and implements `IVirtualPageController`, it'll look like this:

```csharp
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Web.Common.Controllers;

namespace RoutingDocs.Controllers;

public class ShopController : UmbracoPageController, IVirtualPageController
{
    public ShopController(
        ILogger<UmbracoPageController> logger,
        ICompositeViewEngine compositeViewEngine)
        : base(logger, compositeViewEngine)
    { }

    public IPublishedContent FindContent(ActionExecutingContext actionExecutingContext)
    { }
}
```

Now you'll see that `FindContent` is complaining because we're not returning anything yet, but let's start by creating our to action methods that `FindContent` will find content for.

First off we have the Index method:

```csharp
[HttpGet]
public IActionResult Index()
{
    // CurrentPage (IPublishedContent) will be the content returned
    // from the FindContent method.

    // return the view with the IPublishedContent
    return View(CurrentPage);
}
```

With this method we return the view with the content found by the `FindContent` method. This can then be used to list all the children in the view with `Model.Children()`.

Next we have our Product method:

```csharp
[HttpGet]
public IActionResult Product(string id)
{
    // CurrentPage (IPublishedContent) will be the content returned
    // from the FindContent method.

    // One example of using a custom route would be to include additional
    // model information based on external services. For example, if
    // we wanted to return the stores the product is available in from
    // a custom data store.
    var dbProduct = DbContext.Products.GetBySku(id);
    var shopModel = new Product(CurrentPage)
    {
        Sku = id,
        AvailableStores = dbProduct.AvailableStores
    };

    return View(shopModel);
}
```

Here, we get some extra data from a different source. In this case, a `DbContext`, but this can be anything you want, using the ID we get from the route values. We use this extra data to create a custom model, which includes the available stores, which we then render the view with.

It's important to note that this custom model must implement `IPublishedContent`, to do this we inherit from the `ContentModel` class, in this case our model looks like this:

```csharp
public class Product : ContentModel
{
    public Product(IPublishedContent content) : base(content)
    {
    }

    public string Sku { get; set; }
    public IEnumerable<string> AvailableStores { get; set; }
}
```

What's great about this is that we can use this model as a type argument when inheriting from `UmbracoViewPage` in our model like so:

```html
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<RoutingDocs.Models.Product>
```

Which makes the model typed, so we can access the available stores like so:

```html
<ul>
    @foreach (var store in Model.AvailableStores)
    {
        <li>@store</li>
    }
</ul>
```

But let's get back to our controller, the last thing we need now is to implement `FindContent` method so we can find content for our actions and serve it to them. First we need to be able to get our content, and properties, so we need to inject `IUmbracoContextAccessor` and `IPublishedValueFallback` and save them to some fields like so:

```csharp
private readonly IUmbracoContextAccessor _umbracoContextAccessor;
private readonly IPublishedValueFallback _publishedValueFallback;

public ShopController(
    ILogger<UmbracoPageController> logger,
    ICompositeViewEngine compositeViewEngine,
    IUmbracoContextAccessor umbracoContextAccessor,
    IPublishedValueFallback publishedValueFallback)
    : base(logger, compositeViewEngine)
{
    _umbracoContextAccessor = umbracoContextAccessor;
    _publishedValueFallback = publishedValueFallback;
}
```

Now that we have our dependencies, and our action methods, we're finally ready to implement the `FindContent` method:

```csharp
public IPublishedContent FindContent(ActionExecutingContext actionExecutingContext)
{
   if (_umbracoContextAccessor.TryGetUmbracoContext(out var umbracoContext))
   {
        var productRoot = umbracoContext.Content.GetById(2074);
        if (productRoot!=null)
        {

            if (actionExecutingContext.ActionDescriptor is ControllerActionDescriptor controllerActionDescriptor)
            {
                // Check which action is executing
                switch (controllerActionDescriptor.ActionName)
                {
                    case nameof(Index):
                        return productRoot;

                    case nameof(Product):
                        // Get the SKU/Id from the route values
                        if (actionExecutingContext.ActionArguments.TryGetValue("id", out var sku))
                        {
                            return productRoot
                                .Children()
                                .FirstOrDefault(c => c.Value<string>(_publishedValueFallback, "sku") == sku.ToString());
                        }
                        else
                        {
                            return productRoot;
                        }
                 }
            }

            return productRoot;
        }
    }

    return null;
}
```

Start by retrieving the product root using the `UmbracoContext` to obtain it based on its ID. Next, let's figure out what action is being requested. To do this, cast the `actionExecutingContext.ActionDescriptor` to a `ControllerActionDescriptor` and use its `ActionName` property. If the action name is index, it returns the product root. If it's a product, we get the SKU from the route value `id` and find the matching child node.

There's only one last thing to do. We need to register our shop controller. If you're creating a controller for your own site you can do it in the `Program.cs` like so:

```csharp
app.UseUmbraco()
    .WithMiddleware(u =>
    {
        u.UseBackOffice();
        u.UseWebsite();
    })
    .WithEndpoints(u =>
    {
        u.EndpointRouteBuilder.MapControllerRoute(
                "Shop Controller",
                "/shop/{action}/{id?}",
                new {Controller = "Shop", Action = "Index"});

        u.UseBackOfficeEndpoints();
        u.UseWebsiteEndpoints();
    });
```

As you can see there's nothing Umbraco specific about the controller routing, it's using the default `MapController` route of the `EndpointRouteBuilder`, we give our mapping a name, a pattern for the controller and some default values, so if no action is specified it will default to `Index`.

If you're creating a package you won't have access to the `Program.cs`, so instead you can use a composer with an `UmbracoPipelineFilter` like so:

```csharp
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Web.Common.ApplicationBuilder;

namespace RoutingDocs.Controllers;

public class ShopControllerComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.Configure<UmbracoPipelineOptions>(options =>
        {
            options.AddFilter(new UmbracoPipelineFilter(nameof(ShopController))
            {
                Endpoints = app => app.UseEndpoints(endpoints =>
                {
                    endpoints.MapControllerRoute(
                        "Shop Controller",
                        "/shop/{action}/{id?}",
                        new {Controller = "Shop", Action = "Index"});
                })
            });
        });
    }
}
```

With that we have our controller with a custom route within an Umbraco context.

#### Client-Side Requests

If the endpoint of your custom route is considered a client-side request e.g. **/sitemap.xml**, you will need to make a few changes to get this to work.

Define your route as before, specifying the correct client type route:

```csharp
.WithEndpoints(u =>
{
    u.EndpointRouteBuilder.MapControllerRoute("Sitemap Xml", "/sitemap.xml",
        new { Controller = "SitemapXml", Action = "Index" });
});
```

You will need to configure your route request options within your **Program.cs** class. For single routes:

```csharp
builder.Services.Configure<UmbracoRequestOptions>(options =>
{
    options.HandleAsServerSideRequest = httpRequest => httpRequest.Path.StartsWithSegments("/sitemap.xml");
});
```

Or it can handle multiple routes:

```csharp
builder.Services.Configure<UmbracoRequestOptions>(options =>
{
    string[] allowList = new[] {"/sitemap.xml", ...};
    options.HandleAsServerSideRequest = httpRequest =>
    {
        foreach (string route in allowList)
        {
            if (httpRequest.Path.StartsWithSegments(route))
            {
                return true;
            }
        }

        return false;
    };
});
```

In your **FindContent** method you should still be able to access and use **IUmbracoContextAccessor** through standard DI:

```
public IPublishedContent? FindContent(ActionExecutingContext actionExecutingContext)
{
    IUmbracoContext context = _umbracoContextAccessor.GetRequiredUmbracoContext();
    IPublishedContent? content = context.Content?.GetAtRoot().FirstOrDefault();

    return content;
}
```

{% hint style="info" %}
There is currently a bug in all versions below 9.5, where this fix won't work for mapping a client-side request to an Umbraco Controller. See [https://github.com/umbraco/Umbraco-CMS/issues/12083](https://github.com/umbraco/Umbraco-CMS/issues/12083) for more details. v9.5 fixes this issue and it's recommended to update to the latest version!
{% endhint %}

#### Attribute routing with IVirtualPageController

One of the benefits of the `IVirtualPageController` is that it allows you to use attribute routing. If you wish to use attribute routing you must use an `IVirtualPageController` and decorate your controller and/or actions with the `Route` attribute. If we want to convert our above example into using attribute routing we must first add the attributes to our actions:

```csharp
[Route("[controller]")]
[Route("[controller]/[action]")]
[HttpGet]
public IActionResult Index()
```

```csharp
[Route("[controller]/[action]/{id?}")]
[HttpGet]
public IActionResult Product(string id)
```

Now all we need to do is change our routing to use `EndpointRouteBuilder.MapControllers();` instead of adding a specific route.

```csharp
app.UseUmbraco()
    .WithMiddleware(u =>
    {
        u.UseBackOffice();
        u.UseWebsite();
    })
    .WithEndpoints(u =>
    {
        u.EndpointRouteBuilder.MapControllers();

        u.UseBackOfficeEndpoints();
        u.UseWebsiteEndpoints();
    });
```

This will give us routing that's similar to what we have in the other example. It's worth noting that there's no defaults when using attribute routing, so to allow our index action to be accessed through both `/shop` and `/shop/index`, we add two attributes, specifying both routes individually.

### Custom route with ForUmbracoPage

Making a custom route within the Umbraco context using `ForUmbracoPage` is similar to using `IVirtualPageController`. The main difference is that with `ForUmbracoPage` we no longer find the content from within the controller. Instead we assign the `FindContent` method when routing the controller. One important thing about `ForUmbracoPage` is that attribute routing is _not_ available. To make our example from above work with `ForUmbracoPage`, we want to remove any attribute routing, and no longer implement `IVirtualPageController`. We'll also remove the `FindContent` method, our controller will then end up looking like this:

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using RoutingDocs.Models;
using RoutingDocs.Persistence;
using Umbraco.Cms.Web.Common.Controllers;

namespace RoutingDocs.Controllers;

public class ShopController : UmbracoPageController
{
    public ShopController(
        ILogger<UmbracoPageController> logger,
        ICompositeViewEngine compositeViewEngine)
        : base(logger, compositeViewEngine)
    { }

    [HttpGet]
    public IActionResult Index()
    {
        // CurrentPage (IPublishedContent) will be the content returned
        // from the FindContent method.

        // return the view with the IPublishedContent
        return View(CurrentPage);
    }

    [HttpGet]
    public IActionResult Product(string id)
    {
        // CurrentPage (IPublishedContent) will be the content returned
        // from the FindContent method.

        // One example of using a custom route would be to include additional
        // model information based on external services. For example, if
        // we wanted to return the stores the product is available in from
        // a custom data store.
        var dbProduct = DbContext.Products.GetBySku(id);
        var shopModel = new Product(CurrentPage)
        {
            Sku = id,
            AvailableStores = dbProduct.AvailableStores
        };

        return View(shopModel);
    }
}
```

As you can see we still inherit from `UmbracoPageController` to get access to the helper method `CurrentPage`, but the rest is a normal controller.

The Umbraco magic will now instead happen where we route the controller, here we will pass a `Func<ActionExecutingContext, IPublishedContent>` delegate to the `ForUmbracoPage` method, this delegate is then responsible for finding the content, for instance using a composer with the same logic as in the `IVirtualPageController` it will look like this:

```csharp
public class ShopControllerComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.Configure<UmbracoPipelineOptions>(options =>
        {
            options.AddFilter(new UmbracoPipelineFilter(nameof(ShopController))
            {
                Endpoints = app => app.UseEndpoints(endpoints =>
                {
                    endpoints.MapControllerRoute(
                        "Shop Controller",
                        "/shop/{action}/{id?}",
                        new {Controller = "Shop", Action = "Index"})
                        .ForUmbracoPage(FindContent); // Here we register our FindContent method
                })
            });
        });
    }

    private IPublishedContent FindContent(ActionExecutingContext actionExecutingContext)
    {
        // Resolve services from the container
        var umbracoContextAccessor = actionExecutingContext.HttpContext.RequestServices
            .GetRequiredService<IUmbracoContextAccessor>();
        var publishedValueFallback = actionExecutingContext.HttpContext.RequestServices
            .GetRequiredService<IPublishedValueFallback>();

        var umbracoContext = umbracoContextAccessor.GetRequiredUmbracoContext();
        var productRoot = umbracoContext.Content.GetById(2074);

        if (actionExecutingContext.ActionDescriptor is ControllerActionDescriptor controllerActionDescriptor)
        {
            // Check which action is executing
            switch (controllerActionDescriptor.ActionName)
            {
                case nameof(ShopController.Index):
                    return productRoot;

                case nameof(ShopController.Product):
                    // Get the SKU/Id from the route values
                    if (actionExecutingContext.ActionArguments.TryGetValue("id", out var sku))
                    {
                        return productRoot
                            .Children()
                            .FirstOrDefault(c => c.Value<string>(publishedValueFallback, "sku") == sku.ToString());
                    }
                    else
                    {
                        return productRoot;
                    }
            }
        }
        return productRoot;
    }
}
```

The `Compose` method of our composer is much the same as any other normal routing. The one difference is that we call `ForUmbracoPage` on the `MapControllerRoute` where we pass in our `FindContent` method. The `FindContent` method is almost the same as it was in the controller in the `IVirtualPageController` example, with one important difference. Since we can no longer inject our required service into the constructor, we instead request them using `actionExecutingContext.HttpContext.RequestServices.GetRequiredService`. You should _not_ save the `HttpContext` or the `IServiceProvider` you get from the `actionExecutingContext` to a field or property on the class. The reason for this is that they will be specific to each request.

With this we have a custom routed controller within the Umbraco pipeline. If you navigate to `/shop` or `/shop/product/<SKU>` you will see the controllers actions being called with the content found in `FindContent`.

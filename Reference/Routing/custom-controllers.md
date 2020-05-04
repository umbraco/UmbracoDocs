---
versionFrom: 8.0.0
---

# Custom MVC controllers (Umbraco Route Hijacking)

_Use a custom MVC controller to handle and control incoming requests for content pages based on a specific Document Type_

## What is Umbraco Route Hijacking?

By default, all front end requests to an Umbraco site are auto-routed via the 'Index' action of a core MVC Controller: `Umbraco.Web.Mvc.RenderMvcController`. This core controller handles the incoming request, builds the associated PublishedContent view model, and passes this to the appropriate Umbraco Template/MVC View. 

It is however possible to implement a custom MVC Controller to replace this default implementation to give complete control over this execution.

For example, to enrich the view model used for the template with additional properties perhaps retrieved from other published content items or even outside of Umbraco, or to implement serverside paging, or any custom/granular security or business logic required to actioned before rendering the template/view on the front-end.

This replacement of the default controller can either be achieved 'globally' for all requests or by 'hijacking' requests for pages based on a specific Document Type following a simple controller naming convention [doctypealias]Controller. 

## Creating a custom controller

### Example: hijacking route requests to a 'product' page

If the Umbraco site has 'product' pages created from a Document Type called 'Product Page' with alias 'productPage'.

Then, creating a custom locally declared controller in the Umbraco MVC web application project (or App_Code folder for website projects) named 'ProductPageController'.

And, ensuring this controller inherits from the base `Umbraco.Web.Mvc.RenderMvcController`.

eg:
```csharp
public class ProductPageController : Umbraco.Web.Mvc.RenderMvcController
{
    public override ActionResult Index(ContentModel model)
    {
        // you are in control here!

        // return a 'model' to the selected template/view for this page.
        return CurrentTemplate(model);
    }
}
```
Will result in ALL requests to ANY 'product' pages being 'hijacked' and routed through your custom MVC controller!

The example above shows the default behaviour that Umbraco's core RenderMvcController provides - by default, the 'Index' action of the controller will be executed, and the CurrentTemplate helper sends the model containing the published content for the request to the relevant template/view. 

## Routing via template

A further convention is that if an action on the controller has a name that matches the template name, this action will be executed instead of the default 'Index' action.

### Example hijacking route requests to a 'product' for an alternative 'AMP' template

In this example, the Product Page Document Type has two templates 'ProductPage' and 'ProductAmpPage', we can hijack and handle the requests to the two templates differently.

Creating the Controller as before

```csharp
public class ProductPageController : Umbraco.Web.Mvc.RenderMvcController
{
    // Any request for the 'ProductAmpPage' template will be handled by this Action
    public ActionResult ProductAmpPage(ContentModel model)
    {
        // Create AMP specific content here...
        return CurrentTemplate(model);
    }
    // All other request, eg the ProductPage template will be handled by the default 'Index' action
    public override ActionResult Index(ContentModel model)
    {
        // you are in control here!

        // return a 'model' to the selected template/view for this page.
        return CurrentTemplate(model);
    }
}
```
#### How can a page be requested via two different templates?
The page in Umbraco will have a single 'template' selected as it's default template, but it's possible to call this same page on a different template by adding ?altTemplate=othertemplatename to the Url QueryString eg:

/products/superfancyproduct/?altTemplate=ProductAmpPage

would request the Super Fancy Product page but force it to be loaded with the ProductAmpPage template, this can be simplified further:

/products/superfancyproduct/ProductAmpPage/

where the final part of the url is assumed to be the altTemplate querystring value.

### Summary - How the route hijacking convention works

* Document Type name = controller name
* Template name = action name (if no action matches or is not specified - then the 'Index' action will be executed).
* Controller Inherits from `Umbraco.Web.Mvc.RenderMvcController`

## Returning a view with a custom model

The steps to achieve this will differ, depending if your template views are using IPublishedContent or Modelsbuilder generated Models.

### Changing the @inherits directive of your template

By default, your Umbraco Template will be based on the `ContentModel` that the default `RenderMvcController` passes through to it. (NB: ContentModel has one property called 'Content' of type IPublishedContent, and the @Model syntax in V8 is wired up to use this IPublishedContent item, to save having to type @Model.Content.etc as in V7)

The default inherits statement:
```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage
```
or if you are using modelsbuilder:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage<ProductPage>
```
(where <> contains a model generated for each document type to give strongly typed access to the document type properties in the template view)

To use a specific custom view model, the @inherits directive will need to be updated to reference your custom model using the `Umbraco.Web.Mvc.UmbracoViewPage<T>` format where 'T' is the type of your custom model.

So for example, if your custom model is of type 'MyProductModel' then your @inherits directive will look like:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage<MyProductModel>
```

:::note
Views in MVC will likely specify a master view to use as the common layout for the site html, when using a custom view model it's necessary to make sure this doesn't conflict with any implementation in the master layout view.
eg: if your master layout view is inheriting from a specific model `UmbracoViewPage<SpecificModel>` and using a property from SpecificModel that isn't available in your custom model an exception will be thrown!
To avoid this you could:
_ Keep your Master layout view 'generically typed', eg only have @inherits UmbracoViewPage, and use Model.Value syntax to access properties.
or
_ Break the dependency on `Umbraco.Web.Models.ContentModel` in your master layout by having it instead inherit from `Umbraco.Web.Mvc.UmbracoViewPage<ISomeInterface>` (where ISomeInterface is implemented by all your models and contains the properties that the master layout view uses).
or
_ Ensure your custom models inherit from whichever class is used to strongly type the master layout view.
:::

In most cases you will need your custom model to build upon the underlying existing PublishedContent model for the page, this can be achieved by making your custom model inherit from a special base class called PublishedContentWrapped:

```csharp
public class MyProductViewModel : PublishContentWrapped
{
    // The PublishContentWrapped accepts an IPublishedContent item as a constructor
    public MyProductViewModel(IPublishedContent content) : base(content) { }

    // Custom properties here...
    public int StockLevel { get; set; }
    public IEnumerable<Distributor> ProductDistributors { get; set; }
}
```

(`PublishedContentWrapped` will take care of populating all the usual underlying Umbraco properties and means the `@Model.` syntax will continue to work in the layouts used by your template).

using Modelsbuilder you will find that all the generated models have a constructor that takes an IPublishedContent item in a similar way:

```csharp
public class MyProductViewModel : ProductPage
{
    // The generated modelsbuilder model: ProductPage  accepts an IPublishedContent item as a constructor
    public MyProductViewModel(IPublishedContent content) : base(content) { }

    // Custom properties here...
    public int StockLevel { get; set; }
    public IEnumerable<Distributor> ProductDistributors { get; set; }
}
```
(NB: The models generated by modelsbuilder are created as partial classes so it's possible to extend them by adding your own partial classes with matching signature )

We can now populate our custom view model in our controller and use the values from the custom model in our template view:

```csharp
public class ProductPageController : Umbraco.Web.Mvc.RenderMvcController
{
    public override ActionResult Index(ContentModel model)
    {
        // you are in control here!
        // create our ViewModel based on the PublishedContent of the current request:
        var productViewModel = new MyProductViewModel(model.Content);
        // set our custom properties
        productViewModel.StockLevel = _madeUpExternalProductInfoService.GetStockLevel(productViewModel.Id)
        productViewModel.ProductDistributors = _madeUpExternalProductInfoService.GetDistributorsForProduct(productViewModel.Id)
        // return our custom ViewModel
        return CurrentTemplate(productViewModel);
    }
}
```
and in our template
```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage<MyProductModel>
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

    ?page=1&andanotherthing=umbraco

The values in the querystring will be bound to the matching parameters defined in the controller's action:

```csharp
public class ProductListingPageController : Umbraco.Web.Mvc.RenderMvcController
{
//notice how we are no longer overriding the Index action because the signature is now different to the base signature.
    public ActionResult Index(ContentModel model, int page, string andAnotherThing)
    {
       var products = _madeUpProductService.GetProductsByPage(page);
       var productListingViewModel = new ProductListingViewModel(model.Content);
       productListingViewModel.Products = products;
       productListViewModel.Thing = andAnotherThing;

       return CurrentTemplate(productListViewModel);
    }
}
```
## Controller Injection
Injecting services into your controller constructors is possible with Umbraco's underlying dependency injection implementation. see (Services and Helpers)[../../Implementation/Services/#custom-services-and-helpers-1].

For example:
```csharp
    public class ProductListingPageController : RenderMvcController
    {
    private readonly IMadeUpProductService _madeUpProductService;
    public MyController(IMadeUpProductService madeUpProductService)
    {
        _madeUpProductService = madeUpProductService;
    }

    public override ActionResult Index(
    ContentModel model)
    {
        var products = __madeUpProductService.GetProductsByPage(page);
    ...
    }
```

To wire up a concrete instance of IMadeUpProductService, use a composer:

```csharp
    using Umbraco.Core;
    using Umbraco.Core.Logging;
    using Umbraco.Core.Composing;
    namespace MyWebsite.Composers
    {
        public class RegisterSuperSiteServiceComposer : IUserComposer
        {
            public void Compose(Composition composition)
            {
            // Register your service with different Lifetime options: Singleton, Request, Transient, Scope
            composition.Register<IMadeUpProductService, MadeUpProductService>(Lifetime.Singleton);
            }
        }
    }
```
See (Composing)[../../Implementation/Composing/] for further information.

## Change the default RenderMVCController globally

In some cases you might want to have your own custom controller execute for ALL MVC requests when you haven't hijacked a specific route. This is possible by assigning your own default controller during initialization using a composer.

```csharp
public class SetDefaultRenderMvcControllerComposer : IUserComposer
{
    public void Compose(Composition composition)
    {
        composition.SetDefaultRenderMvcController(typeof(MyRenderMvcController));
    }
}

public class MyRenderMvcController : IRenderMvcController
{
    public void Execute(RequestContext requestContext)
    {
        throw new NotImplementedException();
    }

    public ActionResult Index(ContentModel model)
    {
        throw new NotImplementedException();
    }
}
```
or inherit from the default RenderMVCController as in the route hijacking examples.

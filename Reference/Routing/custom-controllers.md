---
versionFrom: 8.0.0
---

# Custom MVC controllers (Umbraco Route Hijacking)

_Use a custom MVC controller to handle and control incoming requests for content pages based on a specific Document Type_

## What is Umbraco Route Hijacking?

By default, all front end requests to an Umbraco site are auto-routed via the 'Index' action of a core MVC Controller: `Umbraco.Web.Mvc.RenderMvcController`. This core controller handles the incoming request, builds the associated PublishedContent model, and passes this to the appropriate Umbraco Template/MVC View. 

It is however possible to implement a custom MVC Controller to replace this default implementation to give complete control over this execution.

For example:
- to enrich the view model passed to the template with additional properties (from other published content items or outside Umbraco) 
- to implement serverside paging
- to implement any custom/granular security
- to return alternative templates depending on some custom business logic

This replacement of the default controller can either be made 'globally' for all requests (see last example) or by *'hijacking'* requests for types of pages based on their specific Document Type following a simple controller naming convention `[DocumentTypeAlias]Controller`. 

## Creating a custom controller

### Example: Hijacking route requests to a 'product' page

In the following example, imagine an Umbraco site with a set of 'product' pages created from a Document Type called 'Product Page' with an alias 'productPage'.

Create a custom locally declared controller in the Umbraco MVC web application project (or App_Code folder for website projects) named 'ProductPageController'.

Ensure that this controller inherits from the base controller `Umbraco.Web.Mvc.RenderMvcController`.

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
ALL requests to ANY 'product' pages in the site will be'hijacked' and routed through the custom ProductPageController.

This example shows the default behaviour that Umbraco's core RenderMvcController provides. The 'Index' action of the controller is executed, and the CurrentTemplate helper sends the model containing the details of the published content item related to the request to the relevant template/view. 

## Routing via template

A further convention is that if an action on the controller has a name that matches the template name, this action will be executed instead of the default 'Index' action.

### Example: Hijacking route requests to a 'product' for an alternative 'AMP' template

In this example, the Product Page Document Type has two templates 'ProductPage' and 'ProductAmpPage'. We can hijack and handle the requests to the two templates differently.

Create the Controller as before:

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
The page in Umbraco will have a single 'template' selected as it's default template, but it's possible to call this same page on a different template by adding `?altTemplate=othertemplatename` to the Url QueryString eg:

`/products/superfancyproduct/?altTemplate=ProductAmpPage`

This would request the 'Super Fancy Product' page but force it to be loaded with the 'ProductAmpPage template'. This can be simplified further:

`/products/superfancyproduct/ProductAmpPage/`

The final part of this url is assumed to be the 'altTemplate' querystring value.

### Summary - How the route hijacking convention works

* Document Type name = controller name
* Template name = action name (if no action matches or is not specified - then the 'Index' action will be executed).
* Controller Inherits from `Umbraco.Web.Mvc.RenderMvcController`

## Returning a view with a custom model

The steps to achieve this will differ, depending if your template views are using IPublishedContent or Modelsbuilder generated Models.

### Changing the @inherits directive of your template

By default, your Umbraco Template will be based on the `ContentModel` that the default `RenderMvcController` passes through to it. 

:::note 
`ContentModel` has one property called 'Content' of type `IPublishedContent`, and the @Model syntax in V8 is wired up to use this `IPublishedContent` item, to save having to type `@Model.Content.etc` as in V7.
:::

The default inherits statement:
```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage
```
or if you are using modelsbuilder:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage<ProductPage>
```
`<>` contains a model generated for each document type to give strongly typed access to the Document Type properties in the template view.

To use a specific custom view model, the `@inherits` directive will need to be updated to reference your custom model using the `Umbraco.Web.Mvc.UmbracoViewPage<T>` format where 'T' is the type of your custom model.

So for example, if your custom model is of type 'MyProductModel' then your `@inherits` directive will look like:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage<MyProductModel>
```

:::note
Views in MVC will likely specify a master view to use as the common layout for the site html. When using a custom view model it's necessary to make sure this doesn't conflict with any implementation in the master layout view.
Eg. if your master layout view is inheriting from a specific model `UmbracoViewPage<SpecificModel>` and using a property from SpecificModel that isn't available in your custom model an exception will be thrown.
To avoid this you could:
* Keep your Master layout view 'generically typed', eg. only have `@inherits UmbracoViewPage`, and use Model.Value syntax to access properties.
or
* Break the dependency on `Umbraco.Web.Models.ContentModel` in your master layout by having it instead inherit from `Umbraco.Web.Mvc.UmbracoViewPage<ISomeInterface>`. This would be where ISomeInterface is implemented by all your models and contains the properties that the master layout view uses.
or
* Ensure your custom models inherit from whichever class is used to strongly type the master layout view.
:::

In most cases you will need your custom model to build upon the underlying existing PublishedContent model for the page. This can be achieved by making your custom model inherit from a special base class called `PublishedContentWrapped`:

```csharp
public class MyProductViewModel : PublishedContentWrapped
{
    // The PublishedContentWrapped accepts an IPublishedContent item as a constructor
    public MyProductViewModel(IPublishedContent content) : base(content) { }

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
    // The generated modelsbuilder model: ProductPage  accepts an IPublishedContent item as a constructor
    public MyProductViewModel(IPublishedContent content) : base(content) { }

    // Custom properties here...
    public int StockLevel { get; set; }
    public IEnumerable<Distributor> ProductDistributors { get; set; }
}
```
:::note
The models generated by Modelsbuilder are created as partial classes so it's possible to extend them by adding your own partial classes with matching signature.
:::

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
Injecting services into your controller constructors is possible with Umbraco's underlying dependency injection implementation. See (Services and Helpers)[../../Implementation/Services/#custom-services-and-helpers-1] for more info on this.

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
See [Composing](../../Implementation/Composing/) for further information.

## Replace Umbraco's default `RenderMVCController`

You can replace Umbraco's default implementation of RenderMVCController with your own custom controller for all MVC requests. 
This is possible by assigning your own default controller during initialization using a composer and the `SetDefaultRenderMvcController(T)` method.

```csharp
public class SetDefaultRenderMvcControllerComposer : IUserComposer
{
    public void Compose(Composition composition)
    {
        composition.SetDefaultRenderMvcController(typeof(MyRenderMvcController));
    }
}
```
Your custom implementation of RenderMvcController should either inherit from the core `RenderMvcController` as in the examples above or implement the `IRenderMvcController` interface.

```csharp
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

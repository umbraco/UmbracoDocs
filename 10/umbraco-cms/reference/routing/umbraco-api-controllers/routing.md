---


meta.Title: "Umbraco WebApi Routing & Urls"
description: "How api controllers are routed and how to retrieve their URLs"
---

# Routing & Urls

_This section will describe how Umbraco Api controllers are routed and how to retrieve their URLs_

## Routing

Like Surface Controllers in Umbraco, when you inherit from the base class `Umbraco.Cms.Web.Common.Controllers.UmbracoApiController` we will auto-route this controller so you don't have to worry about routing at all.

All locally declared Umbraco api controllers will be routed under the url path of:

~/Umbraco/Api/[YourControllerName]

All plugin based Umbraco api controllers will be routed under the url path of:

~/Umbraco/[YourAreaName]/[YourControllerName]

* [More information on implementing these controllers](README.md).

## Urls

We've added some handy `UrlHelper` extension methods to help you retrieve the Url of your Umbraco Api controllers. The extension methods are found in the class: `Umbraco.Extensions.UrlHelperExtensions` so you'll need to ensure you have the namespace `Umbraco.Extensions` imported. You will also need to inject `UmbracoApiControllerTypeCollection`, if you want to use any of the overloads that require it.

The method overloads are:

```csharp
string GetUmbracoApiService<T>(UmbracoApiControllerTypeCollection umbracoApiControllerTypeCollection, string actionName)
string GetUmbracoApiService<T>(UmbracoApiControllerTypeCollection umbracoApiControllerTypeCollection, Expression<Func<T, object>> methodSelector)
string GetUmbracoApiService(UmbracoApiControllerTypeCollection umbracoApiControllerTypeCollection, string actionName, Type apiControllerType)
string GetUmbracoApiService(string actionName, string controllerName)
string GetUmbracoApiService(string actionName, string controllerName, string area)
```

The most consistent way to retrieve a Url is to use your controller's type, and an expression to select the action. Example of retrieving a URL in a view:

```csharp
@using RoutingDocs.ApiControllers
@inject Umbraco.Cms.Core.UmbracoApiControllerTypeCollection _controllers;

@(Url.GetUmbracoApiService<ProductsController>(_controllers, controller => controller.GetAllProducts()))
```

Generally a UrlHelper instance will be available on most base classes like Controllers and Views, and you shouldn't have to create it manually, but if you need to you can, by injecting `IUrlHelperFactory` and `IActionContextAccessor` and then use the factory like so:

```C#
var urlHelper = _urlFactory.GetUrlHelper(_actionContextAccessor.ActionContext);
var url = urlHelper.GetUmbracoApiService("GetAllProducts", "Products");
```

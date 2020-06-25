---
versionFrom: 8.0.0
meta.Title: "Umbraco WebApi Routing"
meta.Description: "A guide to implenting WebApi in Umbraco projects"
---

# Umbraco Api

_This section will describe how to work with Web Api in Umbraco to create REST services_

Related links:

* [Umbraco api routes and Urls](routing.md)
* [Umbraco api authorization](authorization.md)

## What is Web API?
The Microsoft Web API reference can be found on the [official ASP.NET Web API website](https://www.asp.net/web-api). *"ASP.NET Web API is a framework that allows developers to build HTTP services that reach a broad range of clients, including browsers and mobile devices. ASP.NET Web API is an ideal platform for building RESTful applications on the .NET Framework."*

Essentially it's a great platform for building REST services.

## Web Api in Umbraco

We've created a base Web Api controller for developers to inherit from which will expose all of the Umbraco related services and objects that you will require when working with Umbraco.

The class to inherit from is: `Umbraco.Web.WebApi.UmbracoApiController`

This will expose the following properties for you to use:

```csharp
ServiceContext Services {get;}
ISqlContext SqlContext {get;}
UmbracoHelper Umbraco {get;}
UmbracoContext UmbracoContext {get;}
IGlobalSettings GlobalSettings {get;}
IProfilingLogger Logger {get;}
MembershipHelper Members {get;}
```

## Creating a Web Api controller

There are 2 types of Umbraco Api controllers:

1. A locally declared controller - it is **not** routed via an Area
1. A plugin based controller - it is routed via an Area

When working on your own projects you will normally be creating a locally declared controller which requires no additional steps. However, if you are creating an Umbraco package to be distributed you will want to create a plugin based controller so that it gets routed via its own area. This ensures that the route will not overlap with someone's locally declared controller if they are both named the same thing.

### Naming conventions

It is very important that you name your controllers according to these guidelines or else they will not get routed:

All controller class names must be suffixed with "**Controller**" and inherit from **UmbracoApiController**. Some examples:

```csharp
public class ProductsController : UmbracoApiController
public class CustomersController : UmbracoApiController
public class ScoresController : UmbracoApiController
```

### Locally declared controller

This is the most common way to create an Umbraco Api controller, you inherit from the class `Umbraco.Web.WebApi.UmbracoApiController` and that is all. You will of course need to follow the guidelines specified by Microsoft for creating a Web Api controller, documentation can be found on the [official ASP.NET Web API website](https://www.asp.net/web-api).

Example:

```csharp
public class ProductsController : UmbracoApiController
{
    public IEnumerable<string> GetAllProducts()
    {
        return new[] { "Table", "Chair", "Desk", "Computer"};
    }
}
```

All locally declared Umbraco api controllers will be routed under the url path of:

*~/Umbraco/Api/[YourControllerName]*

E.g *~/Umbraco/Api/Products/GetAllProducts*

### Plugin based controller

If you are creating an Umbraco Api controller to be shipped in an Umbraco package you will need to add the `Umbraco.Web.Mvc.PluginController` attribute to your controller to ensure that it is routed via an area. The area name is up to you to specify in the attribute.

Example:

```csharp
[PluginController("AwesomeProducts")]
public class ProductsController : UmbracoApiController
{
    public IEnumerable<string> GetAllProducts()
    {
        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
    }
}
```

Now this controller will be routed via the area called "AwesomeProducts". All plugin based Umbraco api controllers will be routed under the url path of:

*~/Umbraco/[YourAreaName]/[YourControllerName]*

E.g *~/Umbraco/AwesomeProducts/Products/GetAllProducts*

For more information about areas, Urls and routing see the [routing section](routing.md)

## Backoffice controllers

If you are creating a controller to work within the Umbraco backoffice then you will need to ensure that it is secured  properly by inheriting from: `UmbracoAuthorizedApiController` or `UmbracoAuthorizedJsonController`. This controller type will auto-route your controller like the above examples except that it will add another Uri path: 'backoffice'.


*~/Umbraco/backoffice/Api/[YourControllerName]*

*~/Umbraco/backoffice/[YourAreaName]/[YourControllerName]*


E.g
*~/Umbraco/Api/Products/GetAllProducts* or

*~/Umbraco/backoffice/AwesomeProducts/Products/GetAllProducts* for PluginController

### More Information

* [Authenticating & Authorizing controllers](../Authorized/index.md)

## Using MVC Attribute Routing in Umbraco Web API Controllers

*Attribute routing* uses attributes to define routes. *Attribute routing* gives you more control over the URIs in your web application. 

To enable attribute routing in Umbraco Web API controllers you need to write a *Component* and register that using a *Composer*. The most important part in the Component is the `MapHttpAttributeRoutes` which enables attribute routing. This below example ensures your Web API controller can be accessed at `products/getallproducts`.

```csharp

public class AttributeRoutingComponent :IComponent
{
    public void Initialize()
    {
        GlobalConfiguration.Configuration.MapHttpAttributeRoutes();        
        
    }

    public void Terminate()
    {
        
    }
}

public class AttributeRoutingComposer : IUserComposer
{
    public void Compose(Composition composition)
    {
       composition.Components().Append<AttributeRoutingComponent>(); ;
    }
}

public class ProductsController : UmbracoApiController
{
    [Route("products/getallproducts")]
    public IEnumerable<string> GetAllProducts()
    {
        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
    }
}

```

You can also *Insert* the Component to avoid clashes with other packages if they use the configuration.

```csharp

[RuntimeLevel(MinLevel = RuntimeLevel.Run)]
public class AttributeRoutingComposer : IComposer
{
    public void Compose(Composition composition)
    {
       composition.Components().Insert<AttributeRoutingComponent>(); ;
    }
}

```

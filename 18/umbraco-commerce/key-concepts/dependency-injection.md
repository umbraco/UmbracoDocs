---
description: Minimizing dependencies via dependency injection with Umbraco Commerce.
---

# Dependency Injection

Dependency Injection (DI) can be an intimidating subject. DI reduces the number of hard-coded dependencies within a codebase by providing a means to define dependencies independently and have them "injected" dynamically. These dependencies are often exposed as interfaces, rather than concrete types. This enables them to be swapped out or replaced with minimal effort.

The ability to "swap out" dependencies is used in Umbraco Commerce in a number of places to allow developers to provide alternative implementations of specific features. This could be the ability to:

* Swap out the default Product Calculator to change how product prices are calculated.
* Swap out the default Order Number Generator should you wish to provide an alternative order numbering strategy.

Umbraco Commerce makes heavy use of the dependency injection mechanism in Umbraco to manage many of the features. It is important to understand how to work with the registration process.

What follows are examples of common tasks you'll need to be able to perform via the DI container in order to work effectively with Umbraco Commerce. For more detailed documentation, it is highly recommended that you read the [Umbraco CMS Dependency Injection and IoC documentation](https://docs.umbraco.com/umbraco-cms/reference/using-ioc).

## Registering Dependencies

Registering dependencies is an important ability to understand as this is used to register Umbraco Commerce event handlers and to extend system pipelines.

To register a dependency you need to do so via the `IUmbracoBuilder` interface. This is exposed within the main `Program.cs` file, between the `AddComposers()` method call and the `Build()` method call.

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    // Append your dependencies here...
    .Build();
```

You can also add your registration logic inside an `IUmbracoBuilder` extension method and then call that within the `Program.cs` file. This is the recommended approach.

```csharp
public static class UmbracoBuilderExtensions
{
    public static IUmbracoBuilder AddMyDependencies(this IUmbracoBuilder builder)
    {
        // Register my dependencies here via the builder parameter
        ...

        // Return the builder to continue the chain
        return builder;
    }
}
```

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddMyDependencies()
    .Build();
```

Registering a dependency is achieved by working with the `IUmbracoBuilder` API:

```csharp
public static class UmbracoBuilderExtensions
{
    public static IUmbracoBuilder AddMyDependencies(this IUmbracoBuilder builder)
    {
        // Register a singleton dependency
        builder.Services.AddSingleton<IMySingletonService, MySingletonService>();

        // Register a transient dependency
        builder.Services.AddTransient<IMyTransientService, MyTransientService>();

        // Return the builder to continue the chain
        return builder;
    }
}
```

## Replacing Dependencies

Like it is possible to add new dependencies it is also possible to replace existing dependencies. This could be dependencies such as the different Calculators available in Umbraco Commerce.

Where a feature is replaceable, replacing that dependency is also achieved via the `IUmbracoBuilder` API:

```csharp
public static class UmbracoBuilderExtensions
{
    public static IUmbracoBuilder AddMyDependencies(this IUmbracoBuilder builder)
    {
        // Replacing the product calculator implementation
        builder.Services.AddUnique<IProductCalculator, MyProductCalculator>();

        // Replacing the default product adapter
        builder.Services.AddUnique<ProductAdapterBase, MyProductAdapter>();

        // Return the builder to continue the chain
        return builder;
    }
}
```

## Injecting Dependencies

As well as registering dependencies, you will also need to know how to access Umbraco Commerce dependencies from within your Controllers. To do this, we add parameters to our Controllers constructor for the dependencies we require. Then, the IoC container will inject them automatically for us.

```csharp
using Umbraco.Commerce.Core.Api;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;

namespace MyProject.Web.Controllers
{
    public class HomeController : RenderController
    {
        private readonly IUmbracoCommerceApi _umbracoCommerceApi;

        public HomeController(IUmbracoCommerceApi umbracoCommerceApi, ILogger<HomeController> logger,
            ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor)
            : base(logger, compositeViewEngine, umbracoContextAccessor)
        {
            _umbracoCommerceApi = umbracoCommerceApi;
        }

        public  override IActionResult Index()
        {
            // Work with the _umbracoCommerceApi here

            return CurrentTemplate(CurrentPage);
        }
    }
}
```

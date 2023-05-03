---
title: Dependency Injection
description: Minimising dependencies via dependency injection with Vendr, the eCommerce solution for Umbraco
---

Dependency Injection (DI) can be quite an intimidating subject, however at it's heart, the main idea is to reduce the number of hard coded dependencies within a codebase by instead providing a means to define those dependencies independently (an IoC container) and have them be "injected" into your codebase dynamically. These dependencies are often exposed as interfaces, rather than concrete types, thus enabling them to be swapped out or replaced with minimal effort.

The ability to "swap out" dependencies is a very powerful concept and is used in Vendr in a number of places to allow developers to provide alternative implementations of specific features, such as the ability to swap out the default Product Calculator to change how product prices are calculated, or to swap out the default Order Number Generator should you wish to provide an alternative order numbering strategy.

Vendr makes heavy used of the dependency injection mechanism in Umbraco to manage many of it's features, so it is important to understand at the very least how to work with the registration process.

What follows are examples of common tasks you'll need to be able to perform via the DI container in order to work effectively with Vendr, however for more detailed documentation, it is highly recommended that you read the [official Umbraco documentation on IoC and Dependency Injection](https://our.umbraco.com/documentation/reference/using-ioc/) on the Umbraco developer portal.

## Registering Dependencies

Registering dependencies is an important ability to understand as we will need to be able to perform this task in order to register Vendr event handlers, or in order to extend system Pipelines.

To register a dependency you need to do so via the `IUmbracoBuilder` interface which is exposed within the main `Startup` class, inside the `ConfigureServices` method between the `AddComposers()` method call and the `Build()` method call.

````csharp
public class Startup
{
    ...
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddUmbraco(_env, _config)
            .AddBackOffice()
            .AddWebsite()
            .AddComposers()
            // Append your dependencies here...
            .Build();
    }
    ...
}
````

Whilst it's possible to register some dependencies directly within this chain, the better practice is to add your registration logic inside an `IUmbracoBuilder` extension method and then call that within the `ConfigureServices` method.

````csharp
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
````

````csharp
public class Startup
{
    ...
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddUmbraco(_env, _config)
            .AddBackOffice()
            .AddWebsite()
            .AddComposers()
            .AddMyDependencies()
            .Build();
    }
    ...
}
````

Registering a dependency is then achieved by working with the `IUmbracoBuilder` API

````csharp
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
````

## Replacing Dependencies

As well as the ability to register new dependencies, there are also times that we will want to be able to replace an existing dependency, such as the various Calculators available in Vendr.

Where a feature is replaceable, replacing that dependency is also achieved via the `IUmbracoBuilder` API

````csharp
public static class UmbracoBuilderExtensions
{
    public static IUmbracoBuilder AddMyDependencies(this IUmbracoBuilder builder)
    {
        // Replacing the product calculator implementation
        builder.Services.AddUnique<IProductCalculator, MyProductCalculator>();

        // Replacing the default product adapter
        builder.Services.AddUnique<IProductAdapter, MyProductAdapter>();

        // Return the builder to continue the chain
        return builder;
    }
}
````

## Injecting Dependencies

As well as registering dependencies, you will also need to know how to access Vendr dependencies from within your Controllers. To do this, we add parameters to our Controllers constructor for the dependencies we require and then the IoC container will inject them automatically for us.

````csharp
using Vendr.Core.Api;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;

namespace MyProject.Web.Controllers
{
    public class HomeController : RenderController
    {
        private readonly IVendrApi _vendrApi;

        public HomeController(IVendrApi vendrApi, ILogger<HomeController> logger, 
            ICompositeViewEngine compositeViewEngine, IUmbracoContextAccessor umbracoContextAccessor)
            : base(logger, compositeViewEngine, umbracoContextAccessor)
        {
            _vendrApi = vendrApi;
        }

        public  override IActionResult Index()
        {
            // Work with the _vendrApi here

            return CurrentTemplate(CurrentPage);
        }
    }
}
````

---
description: Inversion of Control/Dependency Injection in Umbraco
---

# Inversion of Control / Dependency injection

Umbraco supports dependency injection out of the box using the [ASP.NET Core built-in dependency injection](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0#service-lifetimes). This means that you do not have to install external packages to register and use your dependencies. Working with dependencies in Umbraco is similar to working them in ASP.NET Core.

`IUmbracoBuilder` is a Umbraco-specific abstraction on top of the `IServiceCollection`. Its purpose is to aid in adding and replacing Umbraco-specific services, such as notification handlers, filesystems, server role accessor, and so on. You can access the `IServiceCollection` directly to add your custom services through the `Services` property. See below for a concrete example:

```csharp
IUmbracoBuilder.Services
```

## Registering dependencies

There are different strategies for registering your own dependencies, and not one strategy that is better than the other.

Depending on what you want to achieve there are two general strategies available. These are the strategies that will be covered in this article.

* Registering dependencies for your site
* Registering dependencies in packages

### Registering dependencies for your site

When working with your Umbraco site dependencies can be registered within the `Program.cs` file.

In the example below, a custom notification handler is added to the `CreateUmbracoBuilder()` builder chain:

{% code title="Program.cs" overflow="wrap" %}

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    // When you need to add something Umbraco specific, do it in the "AddUmbraco" builder chain, using the IUmbracoBuilder extension methods.
    .AddNotificationHandler<ContentTypeSavedNotification, ContentTypeSavedHandler>()
    .Build();
```

{% endcode %}

### Registering dependencies in packages

When working with packages, you do not have access to the `Program.cs` file. Instead you can use a [composer](../implementation/composing.md) to register your dependencies.

Below is an example of a composer using the `Services` property of the `IUmbracoBuilder`:

{% code title="MyComposer.cs" overflow="wrap" %}

```csharp
using IOCDocs.NotificationHandlers;
using IOCDocs.Services;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Notifications;

namespace IOCDocs;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<ContentTypeSavedNotification, ContentTypeSavedHandler>();
        builder.Services.AddSingleton<IFooBar, Foobar>();
    }
}
```

{% endcode %}

{% hint style="info" %}
In order to gain access to the `IUmbracoBuilder` you need to add `Umbraco.Cms.Core.DependencyInjection` and `Microsoft.Extensions.DependencyInjection` as using-statements when registering your services. This in turn will also give you access to the `IUmbracoBuilder` extension methods as well as the Microsoft `IServiceProvider`.
{% endhint %}

### Builder extension methods

Depending on your scenario, you may have a lot of dependencies you need to register. In this case, your `Program.cs` or Composer can become cluttered and hard to manage.

You can manage multiple services in one place by creating your own custom extension methods for the `IUmbracoBuilder`. This way you can bundle similar dependencies in extension methods and register them all in a single call.

In the following example two dependencies, `RegisterCustomNotificationHandlers` and `RegisterCustomServices` are bundled together in a custom `AddCustomServices` extension method.

{% code title="MyCustomBuilderExtensions.cs" overflow="wrap" %}

```csharp
using IOCDocs.NotificationHandlers;
using IOCDocs.Services;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Notifications;

namespace IOCDocs;

public static class MyCustomBuilderExtensions
{
    // The first dependency is registered
    public static IUmbracoBuilder RegisterCustomNotificationHandlers(this IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<ContentTypeSavedNotification, ContentTypeSavedHandler>();
        {...}
        return builder;
    }

    // The second dependency is registered
    public static IUmbracoBuilder RegisterCustomServices(this IUmbracoBuilder builder)
    {
        builder.Services.AddSingleton<IFooBar, Foobar>();
        {...}
        return builder;
    }

    // The two dependencies are bundled together
    public static IUmbracoBuilder AddCustomServices(this IUmbracoBuilder builder)
    {
        builder.RegisterCustomNotificationHandlers();
        builder.RegisterCustomServices();
        return builder;
    }
}
```

{% endcode %}

{% hint style="info" %}
It is not required to have an interface registering your dependencies:

```csharp
services.AddSingleton<Foobar>();
```

{% endhint %}

With the dependencies bundled together, you can call the `AddCustomServices` method in either the `Program.cs` file, or your composer:

{% tabs %}
{% tab title="Program.cs" %}

{% code title="Program.cs" overflow="wrap" %}

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    // Register all custom dependencies in one go using the custom extension method
    .AddCustomServices()
    .Build();
```

{% endcode %}

{% endtab %}
{% tab title="Composer" %}

{% code title="MyComposer.cs" overflow="wrap" %}

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace IOCDocs;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Register all custom dependencies in one go using the custom extension method
        builder.AddCustomServices();
    }
}
```

{% endcode %}

{% endtab %}
{% endtabs %}

## Service lifetime

During registration of your dependencies you have to define the lifetime of your service:

```csharp
IServiceCollection.AddTransient<TService, TImplementing>();
IServiceCollection.AddScoped<TService, TImplementing>();
IServiceCollection.AddSingleton<TService, TImplementing>();
```

There are three possible lifetimes:

| Name | Lifetime | Description |
|---|---|---|
| **Transient** | Always creates a new instance | A new instance will be created each time it's injected. |
| **Scoped** | One unique instance per web request (connection) | Scoped services are disposed at the end of the request. Be careful not to resolve a scoped service from a singleton, since it may cause it to have an incorrect state in subsequent requests. |
| **Singleton** | One unique instance for the whole web application | The single instance will be shared across all web requests. |

For more information, have a look at the official [Microsoft documentation on dependency injections](https://docs.microsoft.com/en-us/dotnet/core/extensions/dependency-injection#service-lifetimes).

## Injecting dependencies

Once you have registered the dependencies you can inject them into your project where needed.

### Injecting dependencies into a class

If you need to inject your service into a controller, or another service, you will do so through the class

{% hint style="warning" %}
The example below uses UmbracoApiController which is obsolete in Umbraco 14 and will be removed in Umbraco 15.
{% endhint %}

{% code title="FooController.cs" overflow="wrap" %}

```csharp
using IOCDocs.Services;
using Umbraco.Cms.Web.Common.Controllers;

namespace IOCDocs.Controllers;

public class FooController : UmbracoApiController
{
    private readonly IFooBar _fooBar;

    public FooController(IFooBar fooBar)
    {
        _fooBar = fooBar;
    }

    public string Foo()
    {
        var bar = _fooBar.Foo();
        return bar;
    }
}
```

{% endcode %}

If you place a breakpoint on `var bar = _foobar.Foo()`, open `/Umbraco/Api/foo/foo` in your browser and inspect the variable, you'll see that the value is `bar`. This is what you would expect since all the `Foobar.Foo()` method does is to return `Bar` as a string:

{% code title="Foobar.cs" overflow="wrap" %}

```csharp
namespace IOCDocs.Services;

public class Foobar : IFooBar
{
    public string Foo() => "Bar";
}
```

{% endcode %}

### Injecting dependencies into a View or Template

I some cases you might need to use services within your templates or view files. Services can be injected directly into your views using the `@inject` keyword. This means that you can inject the `Foobar` from above into a view like shown below:

{% code title="Home.cshtml" overflow="wrap" %}

```html
@using Umbraco.Cms.Web.Common.PublishedModels;
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.Home>
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;

@* Add a using statement for the namespace of the service *@
@using IOCDocs.Services
@* Inject the service *@
@inject IFooBar _fooBar

@{
 Layout = null;
}

<h1>@_fooBar.Foo()</h1>
```

{% endcode %}

When loading a page using the template above, you will see the "Bar" heading which is retrieved from the service.

{% hint style="info" %}
In order to use the service a using statement for the namespace of the service needs to be added.
{% endhint %}

## Other things you can inject

In this section you can find examples of what you can inject when working with Umbraco.

### UmbracoHelper

[Read more about the UmbracoHelper](querying/umbracohelper.md)

The `UmbracoHelper` is a scoped service, which means you can only use it in services that are also scoped or transient. To get the UmbracoHelper you must inject `IUmbracoHelperAccessor` and use that to resolve it:

{% code title="MyCustomScopedService.cs" overflow="wrap" %}

```csharp
using System.Collections.Generic;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Web.Common;

namespace IOCDocs.Services;

// This service must be scoped
public class MyCustomScopedService
{
    private readonly IUmbracoHelperAccessor _umbracoHelperAccessor;

    public MyCustomScopedService(IUmbracoHelperAccessor umbracoHelperAccessor)
    {
        _umbracoHelperAccessor = umbracoHelperAccessor;
    }
    
    public IEnumerable<IPublishedContent> GetContentAtRoot()
    {
        // Try and get the Umbraco helper
        var success = _umbracoHelperAccessor.TryGetUmbracoHelper(out var umbracoHelper);
        if (success is false)
        {
            // Failed to get UmbracoHelper, probably because it was accessed outside of a scoped/transient service.
            return null;
        }

        public IEnumerable<IPublishedContent> GetContentAtRoot()
        {
            // Try and get the Umbraco helper
            var success = _umbracoHelperAccessor.TryGetUmbracoHelper(out var umbracoHelper);
            if (success is false)
            {
                // Failed to get UmbracoHelper, probably because it was accessed outside of a scoped/transient service.
                return null;
            }

            // We got Umbraco helper, now we can do something with it.
            return umbracoHelper.ContentAtRoot();
        }
    }
}
```

{% endcode %}

{% hint style="info" %}
The use of the UmbracoHelper is only possible when there is an instance of the UmbracoContext. [You can read more in the implementation article about services](../implementation/services/).
{% endhint %}

### ExamineManager

[Read more about the ExamineManager in the Searching articles](searching/examine/).

{% code title="SearchService.cs" overflow="wrap" %}

```csharp
using System;
using System.Collections.Generic;
using Examine;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Examine;
using Umbraco.Extensions;

namespace IOCDocs.Services;

// This service must be scoped.
public class SearchService : ISearchService
{
    private readonly IExamineManager _examineManager;
    private readonly IUmbracoContextAccessor _umbracoContextAccessor;

    public SearchService(IExamineManager examineManager, IUmbracoContextAccessor umbracoContextAccessor)
    {
        _examineManager = examineManager;
        _umbracoContextAccessor = umbracoContextAccessor;
    }

    public IEnumerable<PublishedSearchResult> Search(string searchTerm)
    {
        if (_examineManager.TryGetIndex(Constants.UmbracoIndexes.ExternalIndexName, out var index) is false)
        {
            throw new InvalidOperationException($"No index found by name {Constants.UmbracoIndexes.ExternalIndexName}");
        }

        if (!(index is IUmbracoIndex umbracoIndex))
        {
            if (_examineManager.TryGetIndex(Constants.UmbracoIndexes.ExternalIndexName, out var index) is false)
            {
                throw new InvalidOperationException($"No index found by name {Constants.UmbracoIndexes.ExternalIndexName}");
            }

            if (!(index is IUmbracoIndex umbracoIndex))
            {
                throw new InvalidOperationException("Could not cast");
            }

            // Do stuff with the index
            if (_umbracoContextAccessor.TryGetUmbracoContext(out var umbracoContext) is false)
            {
                throw new InvalidOperationException("Could not get Umbraco context");
            }

            return umbracoIndex.Searcher.Search(searchTerm).ToPublishedSearchResults(umbracoContext.PublishedSnapshot.Content);
        }
        
        // Do stuff with the index
        if (_umbracoContextAccessor.TryGetUmbracoContext(out var umbracoContext) is false)
        {
            throw new InvalidOperationException("Could not get Umbraco context");
        }

        return umbracoIndex.Searcher.Search(searchTerm).ToPublishedSearchResults(umbracoContext.PublishedSnapshot.Content);
    }
}
```

{% endcode %}

### ILogger

[Read more about logging in the debugging section](../fundamentals/code/debugging/logging.md)

{% code title="Foobar.cs" overflow="wrap" %}

```csharp
using System;
using Microsoft.Extensions.Logging;

namespace IOCDocs.Services;

public class Foobar : IFooBar
{
    private readonly ILogger<Foobar> _logger;

    public Foobar(ILogger<Foobar> logger)
    {
        _logger = logger;
    }

    public void Foo()
    {
        _logger.LogInformation("Method Foo called at {DateTime}", DateTime.UtcNow);
    }
}
```

{% endcode %}

## Using DI in Services and Helpers

In the [Services and Helpers documentation](../implementation/services/) you can find more examples of using dependency injection and gaining access to the different services and helpers.

You will also find information about how to create your own custom services and helpers to inject and use in your Umbraco project.

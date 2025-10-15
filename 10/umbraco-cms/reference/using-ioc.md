---
meta.Title: Umbraco Dependency Injection
description: Inversion of Control/Dependency Injection in Umbraco
---

# Inversion of Control / Dependency injection

Umbraco v9+ supports dependency injection out of the box. Umbraco uses the [ASP.NET Core built-in dependency injection](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/dependency-injection?view=aspnetcore-5.0#service-lifetimes). This means that you don't have to install external packages to register and use your dependencies. If you're familiar with ASP.NET Core, the experience will be similar.

`IUmbracoBuilder` is a Umbraco-specific abstraction on top of the `IServiceCollection`, its purpose is to aid in adding and replacing Umbraco-specific services, such as notification handlers, filesystems, server role accessor, and so on. You can access the `IServiceCollection` directly to add your custom services through the `Services` property, see below for a concrete example:

```c#
IUmbracoBuilder.Services
```

## Registering dependencies

There are two strategies for registering your own dependencies to the container, which one you should use depends on whether you're making a package, or making custom services for your own site.

### Registering dependencies for your site

When working with your site, and not a package, the recommended way to register dependencies is with the `ConfigureServices` method of the `Startup` class in `Startup.cs`:

```c#
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()
        // If you need to add something Umbraco specific, do it in the "AddUmbraco" builder chain, using the IUmbracoBuilder extension methods.
        .AddNotificationHandler<ContentTypeSavedNotification, ContentTypeSavedHandler>()
        .Build();

    // Regular services can be added outside the "AddUmbraco" builder chain, using the default IServiceCollection.
    services.AddSingleton<IFooBar, Foobar>();
}
```

### Registering dependencies in packages

When working with packages, you won't have access to the `Startup.cs` file, so instead you must use a [composer](../implementation/composing.md) to register your own dependencies in the container, using the `Services` property, or appropriate extension method, of the `IUmbracoBuilder`:

```csharp
using IOCDocs.NotificationHandlers;
using IOCDocs.Services;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Notifications;

namespace IOCDocs
{
    public class MyComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.AddNotificationHandler<ContentTypeSavedNotification, ContentTypeSavedHandler>();
            builder.Services.AddSingleton<IFooBar, Foobar>();
        }
    }
}
```

{% hint style="info" %}
Remember to add `Umbraco.Cms.Core.DependencyInjection` and `Microsoft.Extensions.DependencyInjection` as 'using' statements where you register your services, to gain access to the `IUmbracoBuilder`, its extension methods, and the Microsoft \`IServiceProvider.
{% endhint %}

### Builder extension methods

Depending on your scenario, you may have a lot of dependencies you need to register, in this case, your `Startup.cs` or Composer might become cluttered and hard to manage. A great way to manage multiple services is by creating your own custom extension methods for the `IUmbracoBuilder`, this way you can group similar dependencies in extension methods and register them all in as little as a single call:

```c#
using IOCDocs.NotificationHandlers;
using IOCDocs.Services;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Notifications;

namespace IOCDocs
{
    public static class MyCustomBuilderExtensions
    {
        public static IUmbracoBuilder RegisterCustomNotificationHandlers(this IUmbracoBuilder builder)
        {
            builder.AddNotificationHandler<ContentTypeSavedNotification, ContentTypeSavedHandler>();
            {...}
            return builder;
        }

        public static IUmbracoBuilder RegisterCustomServices(this IUmbracoBuilder builder)
        {
            builder.Services.AddSingleton<IFooBar, Foobar>();
            {...}
            return builder;
        }

        public static IUmbracoBuilder AddCustomServices(this IUmbracoBuilder builder)
        {
            builder.RegisterCustomNotificationHandlers();
            builder.RegisterCustomServices();
            return builder;
        }
    }
}
```

{% hint style="info" %}
It is not required to have an interface for your dependency:

```csharp
services.AddSingleton<Foobar>();
```
{% endhint %}

Now you can call your `AddCustomServices` in either the `Startup.cs` file, or your composer like so:

```c#
public void ConfigureServices(IServiceCollection services)
{
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()
        // Register all our custom services in one go.
        .AddCustomServices()
        .Build();
}
```

```c#
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace IOCDocs
{
    public class MyComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            // Register all our custom services in one go.
            builder.AddCustomServices();
        }
    }
}
```

### Service lifetime

During registration you have to define the lifetime of your service:

```csharp
IServiceCollection.AddTransient<TService, TImplementing>();
IServiceCollection.AddScoped<TService, TImplementing>();
IServiceCollection.AddSingleton<TService, TImplementing>();
```

There is three possible lifetimes:

* Transient - always creates a new instance
  * A new instance will be created each time it's injected.
* Scoped - one unique instance per web request (connection)
  * Scoped services are disposed at the end of the request
  * Be very careful not to resolve a scoped service from a singleton, since it may cause it to have an incorrect state in subsequent requests.
* Singleton - one unique instance for the whole web application
  * The single instance will be shared across all web requests.

For more information, have a look at the official [Microsoft documentation](https://docs.microsoft.com/en-us/dotnet/core/extensions/dependency-injection#service-lifetimes).

## Injecting dependencies

Once you have registered your services, factories, helpers or whatever you need for you application, you can go ahead and inject them where needed.

### Injecting dependencies into a class

If you need to inject your service into a controller, or another service, you'll do so through the class

```csharp
using IOCDocs.Services;
using Umbraco.Cms.Web.Common.Controllers;

namespace IOCDocs.Controllers
{
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
}
```

If you place a breakpoint on `var bar = _foobar.Foo()`, open `/Umbraco/Api/foo/foo` in your browser and inspect the variable, you'll see that the value is `bar`, which is what you'd expect since all the `Foobar.Foo()` method does it to return `Bar` as a string:

```csharp
namespace IOCDocs.Services
{
    public class Foobar : IFooBar
    {
        public string Foo() => "Bar";
    }
}
```

### Injecting dependencies into a View or Template

You might need to use services within your templates or views, fortunately, you can inject services directly into your views using the `@inject` keyword. You can for example inject the `Foobar` from above into a view like so:

```html
@using Umbraco.Cms.Web.Common.PublishedModels;
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.Home>
@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;

@* Add a using for the namespace of the service *@
@using IOCDocs.Services
@* Now you can inject it *@
@inject IFooBar _fooBar

@{
	Layout = null;
}

<h1>@_fooBar.Foo()</h1>
```

If you then load the page which uses this template you'll see a heading with "Bar", which we got from our service.

Note that in order to use our service we also have to add a using statement for the namespace of the service.

## Other things you can inject

Most of (if not all) the Umbraco goodies you work with every day can be injected. Here are some examples.

### UmbracoHelper

[Read more about the UmbracoHelper](querying/umbracohelper.md)

`UmbracoHelper` is a scoped service, therefore you can only use it in services that are also scoped, or transient. To get UmbracoHelper you must inject `IUmbracoHelperAccessor` and use that to resolve it:

```csharp
using System.Collections.Generic;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Web.Common;

namespace IOCDocs.Services
{
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
            
            // We got Umbraco helper, now we can do something with it.
            return umbracoHelper.ContentAtRoot();
        }
    }
}
```

{% hint style="info" %}
The use of the UmbracoHelper is only possible when there's an instance of the UmbracoContext. [You can read more here](../implementation/services/).
{% endhint %}

### ExamineManager

[Read more about examine](searching/examine/).

```csharp
using System;
using System.Collections.Generic;
using Examine;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Infrastructure.Examine;
using Umbraco.Extensions;

namespace IOCDocs.Services
{
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
                throw new InvalidOperationException("Could not cast");
            }
            
            // Do stuff with the index
            if (_umbracoContextAccessor.TryGetUmbracoContext(out var umbracoContext) is false)
            {
                throw new InvalidOperationException("Could not get Umbraco context");
            }

            return umbracoIndex.Searcher.Search(searchTerm).ToPublishedSearchResults(umbracoContext.PublishedSnapshot.Content);
        }
    }
}
```

### ILogger

[Read more about logging](../fundamentals/code/debugging/logging.md)

```csharp
using System;
using Microsoft.Extensions.Logging;

namespace IOCDocs.Services
{
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
}
```

## Using DI in Services and Helpers

[Services and Helpers](../implementation/services/) - For more examples of using DI and gaining access to Services and Helpers, and creating your own custom Services and Helpers to inject.

---
description: Use Umbraco's service APIs to create, update, and delete core entities stored in the database from your custom code.
---

# Accessing the Umbraco services

Services are defined using interfaces within the `Umbraco.Cms.Core.Services` namespace. To use the service APIs, you must first access them. Via the built-in dependency injection (DI) in ASP.NET Core, configured services are made available throughout Umbraco's codebase. This is achieved via injecting the specific service interface you require in the constructor of your class.

## Access via a Controller

If you are accessing Umbraco services inside your own controller class, you can add the Umbraco services that you need as constructor parameters. An instance of every service will be provided at runtime from the service container. By saving each one to a local field, you can make use of them within the scope of your class:

{% code title="CustomController.cs" %}
```csharp
public class CustomController
{
    private readonly IContentService _contentService;


    public ContentController(IContentService contentService)
    {
        _contentService = contentService;
    }


    public ActionResult PerformAction()
    {
        var someContent = _contentService.GetById(1234);
    }
}
```
{% endcode %}

## Access via a Razor View Template

Inside a Razor View template, you can make use of a service injection into a view using the `@inject` directive. It works similarly to adding a property to the view, and populating the property using DI:

{% code title="MyView.cshtml" %}
```csharp
@using Umbraco.Cms.Core.Services
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@inject IPublicAccessService PublicAccessService
@{
    Layout = "master.cshtml";
    bool isPageProtected = PublicAccessService.IsProtected(Model.Path);
}
@if (isPageProtected)
{
    <h1>Secret Page - shhshshsh!</h1>
}
```
{% endcode %}

## Access in a Custom Class via dependency injection

If you want to subscribe to notifications on one of the services, create a Composer C# class and add a custom `NotificationHandler`. In the `NotificationHandler`, inject the service you need into the public constructor. The underlying dependency injection framework will do the rest.

In this example, you will wire up to the ContentService 'Saved' event. You will create a new folder in the Media section whenever a new LandingPage is created in the content section to store associated media. Therefore, you will need the MediaService available to create the new folder.

{% code title="CustomComposer.cs" %}
```csharp
public class CustomComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<ContentSavedNotification, CustomNotificationHandler>();
    }
}
```
{% endcode %}

{% code title="CustomNotificationHandler.cs" %}
```csharp
using System.Linq;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;

namespace Umbraco.Cms.Core.Events;

public class CustomNotificationHandler : INotificationHandler<ContentSavedNotification>
{
    // access to the MediaService by injection
    private readonly IMediaService _mediaService;
    private readonly IRuntimeState _runtimeState;

    public CustomNotificationHandler(IMediaService mediaService, IRuntimeState runtimeState)
    {
        _mediaService = mediaService;
        _runtimeState = runtimeState;
    }

    public void Handle(ContentSavedNotification notification)
    {
        if (_runtimeState.Level != RuntimeLevel.Run)
        {
            return;
        }

        foreach (var contentItem in notification.SavedEntities)
        {
            // if this is a new landing page create a folder for associated media in the media section
            if (contentItem.ContentType.Alias == "landingPage")
            {
                // the mediaService is injected in the constructor for the component see above.
                bool hasExistingFolder = _mediaService.GetByLevel(1).Any(f => f.Name == contentItem.Name);
                if (!hasExistingFolder)
                {
                    // let's create one (-1 indicates the root of the media section)
                    IMedia newFolder = _mediaService.CreateMedia(contentItem.Name, -1, "Folder");
                    _mediaService.Save(newFolder);
                }
            }
        }
    }
}
```
{% endcode %}

### Custom Class example

When you're creating your own class, in order to make use of the dependency injection framework, you need register the `ICustomNewsArticleService` service with the type `CustomNewsArticleService`. The `AddScoped()` method registers the service with the lifetime of a single request.

There are different ways that you can achieve the same outcome:

Register directly into **Program.cs**.

{% code title="Program.cs" %}
```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .Build();

builder.Services.AddScoped<ICustomNewsArticleService, CustomNewsArticleService>();
```
{% endcode %}

Another approach is to create an extension method on `IUmbracoBuilder` and call it from `Program.cs`.

{% code title="UmbracoBuilderServiceExtensions.cs" %}
```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;

namespace DefaultNamespace;

public static class UmbracoBuilderServiceExtensions
{
    public static IUmbracoBuilder AddCustomServices(this IUmbracoBuilder builder)
    {
        builder.Services.AddScoped<ICustomNewsArticleService, CustomNewsArticleService>();

        return builder;
    }
}
```
{% endcode %}

{% code title="Program.cs" %}
```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddCustomServices()
    .Build();
```
{% endcode %}

When creating Umbraco packages you don't have access to `Program.cs`, therefore it's recommended to use a `IComposer` instead. A Composer gives you access to the `IUmbracoBuilder`.

{% code title="CustomComposer.cs" %}
```csharp
public class CustomComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddScoped<ICustomNewsArticleService, CustomNewsArticleService>();
    }
}
```
{% endcode %}

Then your custom class, `CustomNewsArticleService`, can take advantage of the same injection to access services:

{% code title="CustomNewsArticleService.cs" %}
```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.PublishedCache;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Services.Navigation;
using Umbraco.Cms.Core.Web;
using Umbraco.Extensions;

namespace Umbraco.Cms.Infrastructure.Services.Implement;

public class CustomNewsArticleService: ICustomNewsArticleService
{
    private readonly IMediaService _mediaService;
    private readonly ILogger<CustomNewsArticleService> _logger;
    private readonly IUmbracoContextFactory _contextFactory;
    private readonly IDocumentNavigationQueryService _documentNavigationQueryService;

    public CustomNewsArticleService(
        ILogger<CustomNewsArticleService> logger,
        IUmbracoContextFactory contextFactory,
        IMediaService mediaService,
        IDocumentNavigationQueryService documentNavigationQueryService)
    {
        _logger = logger;
        _contextFactory = contextFactory;
        _mediaService = mediaService;
        _documentNavigationQueryService = documentNavigationQueryService;
    }

    public void DoSomethingWithNewsArticles()
    {
        using (var contextReference = _contextFactory.EnsureUmbracoContext())
        {
            IPublishedContentCache? contentCache = contextReference.UmbracoContext.Content;

            if (_documentNavigationQueryService.TryGetRootKeys(out IEnumerable<Guid> rootKeys) is false)
            {
                _logger.LogDebug("News Section Not Found");
                return;
            }

            IPublishedContent? root = rootKeys.Select(key => contentCache.GetById(key)).WhereNotNull().FirstOrDefault();
            IPublishedContent? newsSection = root?.Children().FirstOrDefault(f => f.ContentType.Alias == "newsSection");

            if (newsSection == null)
            {
                _logger.LogDebug("News Section Not Found");
            }
        }
        // etc
    }
}
```
{% endcode %}

## More information

* [Services in Umbraco](../../../extend-your-project/server-side-extensions/management/)
* [Umbraco Notifications reference](../../../extend-your-project/server-side-extensions/notifications/)
* [Routes and controllers](routing/)

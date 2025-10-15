# Service APIs

_Whenever you need to modify an entity that Umbraco stores in the database, there are a number of service APIs available to help you. This means that you can create, update and delete any of the core Umbraco entities directly from your custom code._

## Accessing the Umbraco services

Services are typically defined using interfaces. Umbraco has them in the `Umbraco.Cms.Core.Services` namespace, while the specific implementations can be found under the `Umbraco.Cms.Core.Services.Implement` namespace. To use the service APIs you must first access them. Owing to the built-in dependency injection (DI) in ASP.NET Core, configured services are made available throughout Umbraco's codebase. This can be achieved via injecting the specific service you require - the service type or an interface.

### Access via a Controller

If you are accessing Umbraco services inside your own controller class, you can add the Umbraco services that you need as constructor parameters. An instance of every service will be provided at runtime from the service container and by saving each one to a local field, you can make use of them within the scope of your class:

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

### Access via a Razor View Template

Inside a Razor View template, you can make use of a service injection into a view using the `@inject` directive. It works similarly to adding a property to the view, and populating the property using DI:

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

### Access in a Custom Class via dependency injection

If for instance we wish to subscribe to notifications on one of the services, we'd do so in a Composer C# class, where you will add a custom `NotificationHandler`. In this custom `NotificationHandler` we would inject the service we need into the public constructor of the class and Umbraco's underlying dependency injection framework will do the rest.

In this example we will wire up to the ContentService 'Saved' event, and create a new folder in the Media section whenever a new LandingPage is created in the content section to store associated media. Therefore we will need the MediaService available to create the new folder.

```csharp
public class CustomComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddNotificationHandler<ContentSavedNotification, CustomNotificationHandler>();
    }
}
```

```csharp
using System.Linq;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Cms.Core.Services;

namespace Umbraco.Cms.Core.Events
{
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
                    // we have injected in the mediaService in the constructor for the component see above.
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
}
```

#### Custom Class example

When you are creating your own custom class, in order to make use of the dependency injection framework, you need to register the `ICustomNewsArticleService` service with the concrete type `CustomNewsArticleService`. The `AddScoped()` method registers the service with the lifetime of a single request.

There are several different ways that you can achieve the same outcome:

Register directly into the **Startup.cs** class.

```csharp
using Microsoft.Extensions.DependencyInjection;

namespace DefaultNamespace
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {   
            services.AddScoped<ICustomNewsArticleService, CustomNewsArticleService>();
        }
    }
}
```

Another approach is to create an extension method to `IUmbracoBuilder` and add it to the startup pipeline.

```csharp
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;

namespace DefaultNamespace
{
    public static class UmbracoBuilderServiceExtensions
    {
        public static IUmbracoBuilder AddCustomServices(this IUmbracoBuilder builder)
        {
            builder.Services.AddScoped<ICustomNewsArticleService, CustomNewsArticleService>();
            
            return builder;
        }
    }
}
```

```csharp
using System;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace DefaultNamespace
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddUmbraco(_env, _config)
                .AddBackOffice()             
                .AddWebsite()
                .AddComposers()
                .AddCustomServices()
                .Build();
        }
    }
}
```

Especially recommended when creating Umbraco packages as you won't have access to the Startup class, instead you can achieve the same as above by using a custom Composer which gives you access to the `IUmbracoBuilder`.

```csharp
public class CustomComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddScoped<ICustomNewsArticleService, CustomNewsArticleService>();
    }
}
```

Then your custom class eg. `CustomNewsArticleService` can take advantage of the same injection to access services eg:

```csharp
using System.Linq;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.PublishedCache;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;

namespace Umbraco.Cms.Infrastructure.Services.Implement
{
    public class CustomNewsArticleService: ICustomNewsArticleService
    {
        private readonly IMediaService _mediaService;
        private readonly ILogger<CustomNewsArticleService> _logger;
        private readonly IUmbracoContextFactory _contextFactory;

        public CustomNewsArticleService(ILogger<CustomNewsArticleService> logger, IUmbracoContextFactory contextFactory, IMediaService mediaService)
        {
            _logger = logger;
            _contextFactory = contextFactory;
            _mediaService = mediaService;
        }

        public void DoSomethingWithNewsArticles()
        {
            using (var contextReference = _contextFactory.EnsureUmbracoContext())
            {
                IPublishedContentCache contentCache = contextReference.UmbracoContext.Content;
                IPublishedContent newsSection = contentCache.GetAtRoot().FirstOrDefault().Children.FirstOrDefault(f => f.ContentType.Alias == "newsSection");
                if (newsSection == null)
                {
                    _logger.LogDebug("News Section Not Found");
                }
            }
            // etc
        }
    }
}
```

## Services available

There is full API coverage of all Umbraco core entities:

* [AuditService](../../reference/management/services/auditservice.md)
* [ConsentService](../../reference/management/services/consentservice.md)
* [ContentService](../../reference/management/services/contentservice/)
* [ContentTypeService](../../reference/management/services/contenttypeservice/)
* [DataTypeService](../../reference/management/services/datatypeservice.md)
* [EntityService](../../reference/management/services/entityservice.md)
* [FileService](../../reference/management/services/fileservice.md)
* [LocalizationService](../../reference/management/services/localizationservice/)
* [MacroService](../../reference/management/services/macroservice.md)
* [MediaService](../../reference/management/services/mediaservice.md)
* [MemberService](../../reference/management/services/memberservice.md)
* [MemberTypeService](../../reference/management/services/membertypeservice.md)
* [MemberGroupService](../../reference/management/services/membergroupservice.md)

### More information

* [Umbraco Services API reference](../../reference/management/services/)
* [Umbraco Notifications reference](../../reference/notifications/)
* [Routes and controllers](../../reference/routing/)

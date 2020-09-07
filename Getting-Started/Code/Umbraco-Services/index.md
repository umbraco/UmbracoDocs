---
meta.title: "Using Umbraco's service APIs"
meta.description: "Using the Umbraco service APIs you can create, update and delete any of the core Umbraco entities directly from your custom code"
versionFrom: 8.0.0
---

# Using Umbraco's service APIs

_Whenever you need to modify an entity that Umbraco stores in the database, there is a service API available to help you. This means that you can create, update and delete any of the core Umbraco entities directly from your custom code._


## Accessing the Umbraco services
The services live in the `Umbraco.Core.Services` namespace. To use the service APIs you must first access them. This can be achieved via what is known as the `ServiceContext` or by injecting the specific service you require using Umbraco's underlying dependency injection framework.


### Access via a Controller
If you are accessing Umbraco services inside your own controller class and your controller inherits from one of the base Umbraco controller classes (eg RenderMvcController, SurfaceController etc) then you can access the `ServiceContext` and all services. This is done through a special `Services` property that is exposed on these base Umbraco controller classes:

```csharp
public class EventController : Umbraco.Web.Mvc.SurfaceController
{
    public Action PerformAction()
    {
        IContentService contentService = Services.ContentService;
        var someContent = contentService.GetById(1234);
    }
}
```

### Access via a Razor View Template
Inside a Razor View template, that inherits UmbracoViewPage (or similar eg PartialViewMacroPage), you can access the `ServiceContext` and therefore all services, through a special `Services` property that is exposed in the Umbraco base View models:

```csharp
@using Umbraco.Core.Services;
@inherits Umbraco.Web.Mvc.UmbracoViewPage
@{
    Layout = "master.cshtml";
    IPublicAccessService publicAccessService = Services.PublicAccessService;
    bool isPageProtected = publicAccessService.IsProtected(Model.Path);
}
@if (isPageProtected)
{
    <h1>Secret Page - shhshshsh!</h1>
}
```

### Access in a Custom Class via dependency injection

If for instance we wish to subscribe to an event on one of the services, we'd do so in a Component C# class, where there is no `ServiceContext` available. Instead we would inject the service we need into the public constructor of the Component and Umbraco's underlying dependency injection framework will do the rest.

In this example we will wire up to the ContentService 'Saved' event, and create a new folder in the Media section whenever a new LandingPage is created in the content section to store associated media. Therefore we will need the MediaService available to create the new folder.

```csharp
using System;
using System.Linq;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Implement;

namespace Umbraco8.Components
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class SubscribeToContentSavedEventComposer : ComponentComposer<SubscribeToContentSavedEventComponent>
    {
    }

    public class SubscribeToContentSavedEventComponent : IComponent
    {
        // access to the MediaService by injection
        private readonly IMediaService _mediaService;
        public SubscribeToContentSavedEventComponent(IMediaService mediaService)
        {
            _mediaService = mediaService;
        }

        public void Initialize()
        {
            ContentService.Saved += ContentService_Saved;
        }

        private void ContentService_Saved(Umbraco.Core.Services.IContentService sender, Umbraco.Core.Events.ContentSavedEventArgs e)
        {
            foreach (var contentItem in e.SavedEntities)
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

        public void Terminate()
        {
            //unsubscribe during shutdown
            ContentService.Saved -= ContentService_Saved;
        }
    }
}
```
#### Custom Class example
It is the same approach if you are creating your own custom class, as long as your class is registered with the dependency injection framework (via a composer).

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco8.Controllers;
using Umbraco8.Services;

namespace Umbraco8.Composers
{
    public class RegisterCustomNewsArticleServiceComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {

            composition.Register<ICustomNewsArticleService, CustomNewsArticleService>(Lifetime.Request);
        }
    }
}
```

Then your custom class eg. `CustomNewsArticleService` can take advantage of the same injection to access services eg:

```csharp
using Umbraco.Core.Logging;
using Umbraco.Core.Services;
using Umbraco.Web;

namespace Umbraco8.Services
{
    public class CustomNewsArticleService : ICustomNewsArticleService
    {
        private readonly IMediaService _mediaService;
        private readonly ILogger _logger;
        private readonly IUmbracoContextFactory _contextFactory;

        public CustomNewsArticleService(ILogger logger, IUmbracoContextFactory contextFactory,IMediaService mediaService)
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
                if (newsSection== null)
                {
                    _logger.Debug<CustomNewsArticleService>("News Section Not Found");
                }
            }
            // etc
        }
    }
}
```

## Services available
There is full API coverage of all Umbraco core entities:

- [ConsentService](../../../Reference/Management/Services/ConsentService/index.md)
- [ContentService](../../../Reference/Management/Services/ContentService/index.md)
- [ApplicationTreeService](../../../Reference/Management/Services/TreeService/index.md)
- [DataTypeService](../../../Reference/Management/Services/DataTypeService/index.md)
- EntityService
- [FileService](../../../Reference/Management/Services/FileService/index.md)
- [LocalizationService](../../../Reference/Management/Services/LocalizationService/index.md)
- MacroService
- [MediaService](../../../Reference/Management/Services/MediaService/index.md)
- [MemberService](../../../Reference/Management/Services/MemberService/index.md)
- [MemberTypeService](../../../Reference/Management/Services/MemberTypeService/index.md)
- [MemberGroupService](../../../Reference/Management/Services/MemberGroupService/index.md)
- [ContentTypeService](../../../Reference/Management/Services/ContentTypeService/index.md)


### More information
- [Umbraco Services API reference](../../../Reference/Management/Services/)
- [Umbraco Events reference](../../../Reference/Events/)
- [Routes and controllers](../../../Reference/Routing/)

### Umbraco TV
- [Chapter: Content API](https://umbraco.tv/videos/umbraco-v7/developer/fundamentals/content-api/)
- [Chapter: Media API](https://umbraco.tv/videos/umbraco-v7/developer/fundamentals/media-api/)
- [Chapter: Member API](https://umbraco.tv/videos/umbraco-v7/developer/fundamentals/member-api/)

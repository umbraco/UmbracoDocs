---
keywords: implementing services injecting di custom services service pattern UmbracoHelper reusing dry
versionFrom: 8.0.0
---

# Services

Umbraco has a whole set of 'core' Services and Helpers that can be called from Controllers, Views, Components etc when implementing an Umbraco site. ([There is an introduction to Umbraco Services in the 'getting started' section.](../../../Getting-Started/Code/Umbraco-Services/))

This [Service Pattern](https://en.wikipedia.org/wiki/Service_layer_pattern) approach provides a common gateway to accessing core Umbraco functionality, retrieving published content, logging in members etc. The services and helpers that you might want to use are all registered with Umbraco's underling Dependency Injection framework, so pretty much can be injected anywhere you might need to use them** - which is neat - You can follow this same service pattern approach when writing your own custom code in an Umbraco implementation to avoid repetition of common code in Views and Controllers.

## Accessing Core Services and Helpers in a Template/View

Inside a view or partial view that inherits from UmbracoViewPage, you have access to Umbraco's core services via the Services context and UmbracoHelper is a gateway to a ton of functionality.

```csharp
@inherits UmbracoViewPage<Blogpost>

@using ContentModels = Umbraco.Web.PublishedModels;
@{
    Layout = "master.cshtml";
    var contentService = Services.ContentService;
    var publishedContentItem = Umbraco.Content(123);    
}
```
## Accessing Core Services and Helpers in a Controller

Inside a controller you can inject any core services or helpers you need via the controller's constructor:

```csharp
using System.Collections.Generic;
using System.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco8.Services;
using Umbraco.Core.Logging;
using Umbraco.Core.Services;

namespace Umbraco8.Controllers
{
    public class BlogPostController : Umbraco.Web.Mvc.RenderMvcController
    {        // GET: BlogPost   
        private readonly ILogger _logger;
        private readonly UmbracoHelper _umbracoHelper;
        private readonly ContentService _contentService;

        public BlogPostController(ILogger logger, UmbracoHelper umbracoHelper, ContentService contentService)
        {
            _umbracoHelper = umbracoHelper;
            _logger = logger;
            _contentService = contentService;
        }
        public override ActionResult Index(ContentModel model)
        {
            _logger.Info<BlogPostController>("Using core logger implementation");
            var publishedContentItem = _umbracoHelper.Content(123);
            _contentService.GetById(123);
        }
```
## Accessing Core Services and Helpers when there is no UmbracoContext eg in a Component or C# Class

Controllers and Views have an UmbracoContext, however this is not always the case everywhere in Umbraco, eg inside a Component or ContentFinder or Custom C# Class etc the UmbracoContext is not guaranteed to exist, therefore you cannot inject any helpers or services that rely on the UmbracoContext existing, eg UmbracoHelper, IPublishedContentQuery into the constructors of these classes...  Umbraco will report a 'boot' error on startup if you do.

### Injecting Services into a Component

You can inject Services that do not rely on UmbracoContext into the constructor of a component. In this example we inject the MediaService in a Component to create a corresponding Media Folder for every 'landing page' that is saved in the Content Section, by subscribing to the Content Saved event. 

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
                //if this is a new landing page create a folder for associated media in the media section
                if (contentItem.ContentType.Alias == "landingPage")
                {
                    // we have injected in the mediaService in the contstructor for the component see above.
                   bool hasExistingFolder = _mediaService.GetByLevel(1).Any(f => f.Name == contentItem.Name);
                   if (!hasExistingFolder)
                    {
                        //let's create one (-1 indicates the root of the media section)
                       IMedia newFolder = _mediaService.CreateMedia(contentItem.Name, -1, "Folder");
                        _mediaService.Save(newFolder);
                    }
                }
            }
        }       

        public void Terminate()
        {
            throw new NotImplementedException();
        }
    }
}
```

Services that are not transient, eg ContentService, MediaService can be injected anywhere.

### Accessing Umbraco Published Cache from a Component or C# Class

You can't inject UmbracoHelper or IPublishedContentQuery into classes that aren't guaranteed to have an UmbracoContext, however there is a technique that allows you to query the Umbraco Cache, using the UmbracoContextFactory and calling EnsureUmbracoContext().

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core.Composing;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Implement;
using Umbraco.Web;

namespace Umbraco8.Components
{
    public class PublishEventsComposer : ComponentComposer<PublishEventsComponent>
    {

    }
    public class PublishEventsComponent : IComponent
    {

        private readonly IUmbracoContextFactory _umbracoContextFactory;
        public PublishEventsComponent(IUserService userService, IUmbracoContextFactory umbracoContextFactory)
        {
            _umbracoContextFactory = umbracoContextFactory;
        }

        public void Initialize()
        {
            ContentService.Published += ContentService_Published;
        }

        private void ContentService_Published(IContentService sender, Umbraco.Core.Events.ContentPublishedEventArgs e)
        {
            using (var umbracoContextReference = _umbracoContextFactory.EnsureUmbracoContext())
            {
                var contentCache = umbracoContextReference.UmbracoContext.ContentCache;
                //get IPublishedContent
                IEnumerable<IPublishedContent> rootNodes = contentCache.GetAtRoot();
                IPublishedContent particularItem = contentCache.GetById(1234);
            }
        }

        public void Terminate()
        {
            throw new NotImplementedException();
        }
    }
}
```

#### Accesing ContentCache from a Content Finder / UrlProvider

Inside a ContentFinder you have access to the content cache via the PublishedRequest
```csharp
  public bool TryFindContent(PublishedRequest frequest)
        {
            var someContent = frequest.UmbracoContext.ContentCache.GetById(123);
```

and insde a UrlProvider you are provided the UmbracoContext
```csharp
   public override UrlInfo GetUrl(UmbracoContext umbracoContext, IPublishedContent content, UrlProviderMode mode, string culture, Uri current)
        {
        var someContent = umbracoContext.ContentCache.GetById(123);
```

## Custom Services

If you have common code that you might need to call in multiple places on your site implementation, eg in multiple controllers or views, then one good option is to move this functionality out into your own service class, you can still use Umbraco's core services within your custom service, by injecting them into your services constructor, then if you register your custom service with Umbraco's underlying DI container you can inject it into your application in the same way as the core service - (same rules about transient services apply!).

Let's create a custom service, that's responsible for finding key pages within a site, eg the News Section or the Contact Us page - these methods will commonly be called in different places throughout the site, and it's great to encapsulate the logic to retrieve them in one place - in the past we might have created extension methods on UmbracoHelper or IPublishedContent, but for this example to demonstrate custom services - we'll create a SiteService

Create an interface to define the service:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core.Models.PublishedContent;

namespace Umbraco8.Services
{
        public interface ISiteService
    {
        IPublishedContent GetNewsSection();
        IPublishedContent GetContactUsPage(int siteId);
    }
}

Create the service that implements the interface:

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core.Models.PublishedContent;

namespace Umbraco8.Services
{
    public class SiteService : ISiteService
    {
        public IPublishedContent GetNewsSection()
        {
            throw new NotImplementedException();
        }
        public IPublishedContent GetContactUsPage()
        {
            throw new NotImplementedException();
        }
    }
}
```

Register the service with an IUserComposer

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco8.Services;

namespace Umbraco8.Composers
{
    public class RegisterSiteServiceComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {         
            composition.Register<ISiteService, SiteService>(Lifetime.Request);          
        }
    }
}
```

Implementing the service, we can inject Umbraco's IPublishedContentQuery to find the pages we're after

```csharp
using System.Linq;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;

namespace Umbraco8.Services
{
    public class SiteService : ISiteService
    {
        private readonly IPublishedContentQuery _contentQuery;
        public SiteService(IPublishedContentQuery contentQuery)
        {
            _contentQuery = contentQuery;
        }
        public IPublishedContent GetNewsSection()
        {
            var siteRoot = _contentQuery.ContentAtRoot().FirstOrDefault();
            var newsSection = siteRoot.Children(f => f.ContentType.Alias == "newsSection").FirstOrDefault();
            return newsSection;
        }
        public IPublishedContent GetContactUsPage()
        {
            var siteRoot = _contentQuery.ContentAtRoot().FirstOrDefault();
            var contactUs = siteRoot.Children(f => f.ContentType.Alias == "contactUs").FirstOrDefault();
            return contactUs;
        }
    }
}
```

(if we planned to use our SiteService outside of a request where UmbracoContext is not available we'd use the UmbracoContextFactory + EnsureUmbracoContext() methods described above to access the content cache)

#### Using the SiteService inside a Controller

```csharp
using System.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco8.Services;
using Umbraco.Core.Logging;


namespace Umbraco8.Controllers
{
    public class BlogPostController : Umbraco.Web.Mvc.RenderMvcController
    {         
        private readonly ISiteService _siteService;
        private readonly ILogger _logger;

        public BlogPostController(ILogger logger, ISuperTestService superTestService,ISiteService siteService, IExamineManager examineManager)
        {
            _logger = logger;
            _siteService = siteService; 
        }

        public override ActionResult Index(ContentModel model)
        {
            var newsSection = _siteService.GetNewsSection();
            var blogPostViewModel = new BlogPostViewModel(model);
            blogPostViewModel.NewsSection = newsSection;
            //etc          
            // Do some stuff here, then return the base method
            return CurrentTemplate(blogPostViewModel);

        }
    }
}
```

#### Using the SiteService inside a View

Sometimes you'll want to encapsulate some kind of View Logic into a service, or perhaps you prefer not to RouteHijack every request to build a custom ViewModel for a page.
In these circumstances you 'could' instanstiate your service inside your view:

```csharp
@using Umbraco8.Services
@inherits UmbracoViewPage
@{

    Layout = "master.cshtml";
    ISiteService siteService = new SiteService(Umbraco.ContentQuery);
    IPublishedContent newsSection = siteService.GetNewsSection();
}
<section class="section">
    <div class="container">
        <article>
```

but this isn't making use of the DI container to control which concrete service implements ISiteService
so you could get the instance from the Umbraco.Web.Composing.Current DI container:

```csharp
@using Umbraco8.Services
@using Current = Umbraco.Web.Composing.Current;
@inherits UmbracoViewPage
@{

    Layout = "master.cshtml";
    ISiteService siteService = Current.Factory.GetInstance<ISiteService>();
    IPublishedContent newsSection = siteService.GetNewsSection();
}
<section class="section">
    <div class="container">
        <article>
```
or another strategy is to create your own 'CustomViewPage' to use as the basis for your views and to wire up any of your custom services

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core;
using Umbraco.Core.Cache;
using Umbraco.Core.Composing;
using Umbraco.Core.Services;
using Umbraco.Web.Mvc;
using Umbraco8.Services;
using Current = Umbraco.Web.Composing.Current;

namespace Umbraco8.ViewPages
{
    public abstract class CustomViewPage<T> : UmbracoViewPage<T>
    {
        public readonly ISiteService SiteService;
        public CustomViewPage() : this(
            Current.Factory.GetInstance<ISiteService>(), 
            Current.Factory.GetInstance<ServiceContext>(),
            Current.Factory.GetInstance<AppCaches>()
            )
        {
        }
        public CustomViewPage(ISiteService siteService, ServiceContext services, AppCaches appCaches)
        {
            SiteService = siteService;
            Services = services;
            AppCaches = appCaches;
        }

        protected override void InitializePage()
        {
            base.InitializePage();
        }
    }
    public abstract class CustomViewPage : UmbracoViewPage
    {
        public readonly ISiteService _siteService;
        public CustomViewPage() : this(
            Current.Factory.GetInstance<ISiteService>(),
            Current.Factory.GetInstance<ServiceContext>(),
            Current.Factory.GetInstance<AppCaches>()
            )
        { }
        
            public CustomViewPage(ISiteService siteService, ServiceContext services, AppCaches appCaches)
        {
            _siteService = siteService;
            Services = services;
            AppCaches = appCaches;
        }

        protected override void InitializePage()
        {
            base.InitializePage();
        }
    }
}
```

with this in place your view would look like this:
```csharp
@using Umbraco8.ViewPages
@inherits CustomViewPage
@{

    Layout = "master.cshtml";
    IPublishedContent newsSection = SiteService.GetNewsSection();
}
<section class="section">
    <div class="container">
        <article>
```





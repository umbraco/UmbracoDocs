---
keywords: implementing services injecting di custom services service pattern UmbracoHelper reusing dry
versionFrom: 8.0.0
---

# Services and Helpers

Umbraco has a range of 'Core' Services and Helpers that act as a 'gateway' to Umbraco data and functionality to use when extending or implementing an Umbraco site.

The general rule of thumb is that Management Services provide access to allow the modification of Umbraco data, (and therefore aren't optimised for displaying data), whereas Helpers provide access to readonly data with performance of displaying data taken into consideration.

:::warning
Although there is a Management Service compelling called the `ContentService` - only use this to modify content - do not use the `ContentService` in a View/Template to pull back data to display, this will make database requests and be slow - here instead use the generically named `UmbracoHelper` to access the `PublishedContentQuery` methods that operate against a cache of published content items, and are significantly quicker.
:::

The Management Services and Helpers are all registered with Umbraco's underlying DI framework - this article aims to show examples of gaining access to utilise these resources in multiple different scenarios (there are subtle differences to be aware of depending on what part of Umbraco is being extended) - and also suggest how to follow a similar pattern to encapsulate custom 'site specific' implementation logic, in similar services and helpers, registered with the underlying DI contain, to avoid repetition and promote consistency and readability within an Umbraco site solution.

## Accessing Management Services and Helpers in a Template/View

Inside a view/template or partial view that inherits from UmbracoViewPage, access is provided to Umbraco's services via the `Services` [service context](../../Reference/Management/Services/) and the `Umbraco` - [UmbracoHelper](../..//Reference/Querying/UmbracoHelper) - is a gateway to an array of useful functionlity.

```csharp
@inherits UmbracoViewPage<Blogpost>
@using ContentModels = Umbraco.Web.PublishedModels;
@{
    Layout = "master.cshtml";

    // retrieve an item from Umbraco's published cache with id 123
    IPublishedContent publishedContentItem = Umbraco.Content(123);

    // it is 'unlikely' to need to use a Management Service in a view:
    var relationService = Services.RelationService;
}
```
## Accessing Management Services and Helpers in a Controller

Inside a [custom controller](../../Reference/Routing/custom-controllers) you can inject any of the core Management Services or Helpers required to assist in controlling the custom flow of the particular request via the Controller's constructor:

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
        private readonly RelationService _relationService;

        public BlogPostController(ILogger logger, UmbracoHelper umbracoHelper, RelationService relationService)
        {
            _umbracoHelper = umbracoHelper;
            _logger = logger;
            _relationService = relationService;
        }
        public override ActionResult Index(ContentModel model)
        {
            // write helpful messages to the Umbraco Trace logs to aid with debugging
            _logger.Info<BlogPostController>("Using core logger implementation");
            // retrieve an item from Umbraco's published cache with id 123
            IPublishedContent publishedContentItem = _umbracoHelper.Content(123);
            // it is unlikely to use a Management service when rendering content from a custom controller
            //(when using relationService like this you would want to provide a layer of caching)
            var allRelatedUmbracoItems = _relationService.GetByParentId(model.Id);_
        }
```

:::Note
You still have access to Umbraco. and Services. as as away to access UmbracoHelper and any Management Services.
So the above could be Umbraco.Content(123) and Services.RelationService.GetByParentId(model.Id)
:::

## Accessing Core Services and Helpers when there is no UmbracoContext eg in a Component or C# Class

Controllers and Views have an UmbracoContext, however this is not always the case 'everywhere in Umbraco', for example common extension points: Components,ContentFinders or Custom C# Classes.

:::Warning
If the UmbracoContext is not guaranteed to exist you cannot inject any helpers or services that rely on the UmbracoContext, eg UmbracoHelper, PublishedContentQuery and if you try to inject these helpers into the constructors of these context less classes...  Umbraco will report a 'boot' error on startup.
:::

### Injecting Services into a Component

It's possible to inject Management Services that do not rely on the `UmbracoContext` into the constructor of a component. This example shows injecting the MediaService in a Component to create a corresponding Media Folder for every 'landing page' that is saved in the Content Section, by subscribing to the 'Content Saved' event. 

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
           
        }
    }
}
```

Management Services that are not transient (eg do not rely on UmbracoContext), eg `ContentService`, `MediaService` can be injected anywhere.

### Accessing Published Content Cache from a Component or C# Class

Injecting `UmbracoHelper` or `IPublishedContentQuery` into classes that aren't guaranteed to have an UmbracoContext will trigger a boot error, however there is a technique that allows the querying of the Umbraco Published Content Cache, using the `UmbracoContextFactory` and calling `EnsureUmbracoContext()`.

```csharp
using System.Collections.Generic;
using Umbraco.Core.Composing;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Implement;
using Umbraco.Web;

namespace Umbraco8.Components
{
    //adds the component to Umbraco composition's list of components
    public class PublishEventsComposer : ComponentComposer<PublishEventsComponent>
    {

    }
    //the component safely accessing the published content cache
    public class PublishEventsComponent : IComponent
    {
        private readonly IUmbracoContextFactory _umbracoContextFactory;

        public PublishEventsComponent(IUmbracoContextFactory umbracoContextFactory)
        {
            _umbracoContextFactory = umbracoContextFactory;
        }

        public void Initialize()
        {
            ContentService.Published += ContentService_Published;
        }

        private void ContentService_Published(IContentService sender, Umbraco.Core.Events.ContentPublishedEventArgs e)
        {
            //first call EnsureUmbracoContext
            using (var umbracoContextReference = _umbracoContextFactory.EnsureUmbracoContext())
            {
                //the UmbracoContextReference provides access to the ContentCache
                var contentCache = umbracoContextReference.UmbracoContext.ContentCache;
                //query the published content cache
                IEnumerable<IPublishedContent> rootNodes = contentCache.GetAtRoot();
                //retrieve a particular item with id 1234 from the published content cache
                IPublishedContent particularItem = contentCache.GetById(1234);
            }
        }

        public void Terminate()
        {
         
        }
    }
}
```

#### Accesing Published Content Cache from a Content Finder / UrlProvider

Inside a ContentFinder access to the content cache is provided via the PublishedRequest object:
```csharp
  public bool TryFindContent(PublishedRequest frequest)
        {
            var someContent = frequest.UmbracoContext.ContentCache.GetById(1234);
```

and insde a UrlProvider the GetUrl method has the current UmbracoContext injected:
```csharp
   public override UrlInfo GetUrl(UmbracoContext umbracoContext, IPublishedContent content, UrlProviderMode mode, string culture, Uri current)
        {
        var someContent = umbracoContext.ContentCache.GetById(1234);
```

## Custom Services and Helpers

When implementing an Umbraco site, it is likely to have to execute similar code that accesses or operates on Umbraco data, in multiple places, perhaps using the Core Management Services or Umbraco Helpers.
For example; Getting a list of the latest News Articles, or building a link to the site's News Section or Contact Us page. It's easy to repeat this kind of logic in multiple places, Views, Partial Views / Controllers etc, which is fine, but it's generally considered good practice to consolodate this logic into a single place.

### Extension methods

One option is to add 'Extension Methods' to the `UmbracoHelper` class.
```csharp
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;

namespace Umbraco8.Extensions
{
    public static class UmbracoHelperExtensions
    {
            //NewsCategories //NewsSection
            public static IPublishedContent GetNewsSection(this UmbracoHelper umbracoHelper)
            {
            return umbracoHelper.ContentSingleAtXPath("root/homePage/newsSection");
            }
     }
}
```

anywhere there is reference to the UmbracoHelper, and a reference is added to the namespace the extension belongs to, it is possible to call the method by writing `Umbraco.GetNewsSection()`

### Custom Services and Helpers

Another option, is to make use of the underlying DI framework, and create custom Services and Helpers, that in turn can have the 'core' Management Services and Umbraco Helpers injected into them - (the same rules about transient services apply!). This approach enables the grouping together of similar methods within a suitably named service, and promotes the possibility of testing this custom logic outside of controllers and views.

In this example, we create a custom helper service, that's responsible for finding key pages within a site, eg the News Section or the Contact Us page - these methods will commonly be called in different places throughout the site, and it's great to encapsulate the logic to retrieve them in a single place - we'll call this helper service: SiteHelperService

Create an interface to define the service:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core.Models.PublishedContent;

namespace Umbraco8.Services
{
        public interface ISiteHelperService
    {
        IPublishedContent GetNewsSection();
        IPublishedContent GetContactUsPage();
    }
}
```
Create the concrete service class that implements the interface:
```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core.Models.PublishedContent;

namespace Umbraco8.Services
{
    public class SiteHelperService : ISiteHelperService
    {
        public IPublishedContent GetNewsSection()
        {
            //ToDo: implement this!
            throw new NotImplementedException();
        }
        public IPublishedContent GetContactUsPage()
        {
            //ToDo: implement this!
            throw new NotImplementedException();
        }
    }
}
```

Register the custom service with Umbraco's underlying DI container using an IUserComposer:

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco8.Services;

namespace Umbraco8.Composers
{
    public class RegisterSiteHelperServiceComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {         
            composition.Register<ISiteHelperService, SiteHelperService>(Lifetime.Request);          
        }
    }
}
```

Note we register the service in 'Lifetime.Request' scope - as we'll be making use of the transient UmbracoContext

Now, implementing the service, we can inject Umbraco's core helper IPublishedContentQuery (the same as you would use when writing Umbraco.Content(1234)) into our custom service, to use in order to locate the special site pages we are after:

```csharp
using System.Linq;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;

namespace Umbraco8.Services
{
    public class SiteHelperService : ISiteHelperService
    {
        private readonly IPublishedContentQuery _contentQuery;
        public SiteHelperService(IPublishedContentQuery contentQuery)
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

:::Note
If we planned to use our SiteHelperService outside of a request where UmbracoContext is not available we'd use the UmbracoContextFactory + EnsureUmbracoContext() methods described above to access the content cache.
:::

:::Note
Check if _contentQuery.SingleAtXPath("root/homePage/contactUs") is faster... (it would be in V7)
:::

#### Using the custom SiteHelperService inside a Controller

Because we've registered the SiteHelperService with Umbraco's underlying DI framework we can inject the service into our controller's constructor, in the same way as 'core' Services and Helpers:

```csharp
using System.Web.Mvc;
using Umbraco.Web.Models;
using Umbraco8.Services;
using Umbraco.Core.Logging;


namespace Umbraco8.Controllers
{
    public class BlogPostController : Umbraco.Web.Mvc.RenderMvcController
    {         
        private readonly ISiteHelperService _siteHelperService;
        private readonly ILogger _logger;

        public BlogPostController(ILogger logger, ISiteHelperService siteHelperService)
        {
            _logger = logger;
            _siteHelperService = siteHelperService; 
        }

        public override ActionResult Index(ContentModel model)
        {
            var newsSection = _siteHelperService.GetNewsSection();
            var blogPostViewModel = new BlogPostViewModel(model);
            blogPostViewModel.NewsSection = newsSection;
            //etc          
            // Do other stuff here!, then return the custom viewmodel to the template view.
            return CurrentTemplate(blogPostViewModel);

        }
    }
}
```

#### Using the SiteHelperService inside a View

If strictly following the paragdigm of MVC, calling custom Services from Views might feel like an anti-pattern. However there isn't necessarily one single 'best practice' approach to working with Umbraco. A lot depends on circumstance, expertise and pragmatism. Allowing Umbraco to handle the flow of incoming requests to a particular page + template, and writing implementation logic in Views/Templates, is still a very common approach. There are circumstances too, where the custom implementation logic shared is very 'View' specific - custom logic for constructing 'Alternative Text' for images or different crop urls for img srcsets can be neatly handled in a custom Helper/Service without having to create a hijacked MVC route for the request and build a complex ViewModel. Custom Services called from Views, can help separate the concerns, even if the 'plumbing' isn't pure MVC.

You 'could' create an instance of your custom service inside the view

```csharp
@using Umbraco8.Services
@inherits UmbracoViewPage
@{

    Layout = "master.cshtml";
    ISiteHelperService siteHelperService = new SiteHelperService(Umbraco.ContentQuery);
    IPublishedContent newsSection = siteHelperService.GetNewsSection();
}
<section class="section">
    <div class="container">
        <article>
```

but this isn't making use of the DI container to control which concrete service implements ISiteHelperService
to 'get around this' you could get the current concrete instance from the Umbraco.Web.Composing.Current DI container:

```csharp
@using Umbraco8.Services
@using Current = Umbraco.Web.Composing.Current;
@inherits UmbracoViewPage
@{

    Layout = "master.cshtml";
    ISiteHelperService siteHelperService = Current.Factory.GetInstance<ISiteHelperService>();
    IPublishedContent newsSection = siteHelperService.GetNewsSection();
}
<section class="section">
    <div class="container">
        <article>
```

or to take this idea a step further create a custom implementation of UmbracoViewPage, called 'CustomViewPage' and create strongly typed gateways to access the shared custom Services:

```csharp
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
        public readonly ISiteHelperService SiteHelperService;
        public CustomViewPage() : this(
            Current.Factory.GetInstance<ISiteHelperService>(), 
            Current.Factory.GetInstance<ServiceContext>(),
            Current.Factory.GetInstance<AppCaches>()
            )
        {
        }
        public CustomViewPage(ISiteHelperService siteHelperService, ServiceContext services, AppCaches appCaches)
        {
            SiteHelperService = siteHelperService;
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
        public readonly ISiteHelperService SiteHelperService;
        public CustomViewPage() : this(
            Current.Factory.GetInstance<ISiteHelperService>(),
            Current.Factory.GetInstance<ServiceContext>(),
            Current.Factory.GetInstance<AppCaches>()
            )
        { }
        
            public CustomViewPage(ISiteHelperService siteHelperService, ServiceContext services, AppCaches appCaches)
        {
            SiteHelperService = siteHelperService;
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

with this in place all views inheriting from CustomViewPage or CustomViewPage<T> would have access to the SiteHelperService:
```csharp
@using Umbraco8.ViewPages
@inherits CustomViewPage<BlogPost>
@{

    Layout = "master.cshtml";
    IPublishedContent newsSection = SiteHelperService.GetNewsSection();
}
<section class="section">
    <div class="container">
        <article>
```





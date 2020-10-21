---
keywords: implementing services injecting di custom services service pattern UmbracoHelper reusing dry
versionFrom: 8.0.0
meta.Title: "Umbraco Services and Helpers"
meta.Description: "Umbraco has a range of 'Core' Services and Helpers that act as a 'gateway' to Umbraco data and functionality to use when extending or implementing an Umbraco site"
---

# Services and Helpers

Umbraco has a range of 'Core' Services and Helpers that act as a 'gateway' to Umbraco data and functionality to use when extending or implementing an Umbraco site.

The general rule of thumb is that management Services provide access to allow the modification of Umbraco data (and therefore aren't optimised for displaying data). Helpers on the other hand provide access to readonly data with performance of displaying data taken into consideration.

:::warning
Although there is a management Service named the `ContentService` - only use this to modify content - do not use the `ContentService` in a View/Template to pull back data to display, this will make requests to the database and be slow - here instead use the generically named `UmbracoHelper` to access the `PublishedContentQuery` methods that operate against a cache of published content items, and are significantly quicker.
:::

The management Services and Helpers are all registered with Umbraco's underlying DI framework. This article aims to show examples of gaining access to utilise these resources in multiple different scenarios. There are subtle differences to be aware of depending on what part of Umbraco is being extended.

This article will also suggest how to follow a similar pattern to encapsulate custom 'site specific' implementation logic, in similar services and helpers, registered with the underlying DI contain. This would be to avoid repetition and promote consistency and readability within an Umbraco site solution.

## Accessing Management Services and Helpers in a Template/View

Inside a view/template or partial view that inherits from UmbracoViewPage, access is provided to Umbraco's Services via the `Services` property ([ServiceContext](../../Reference/Management/Services/)) and the `Umbraco` property ([UmbracoHelper](../../Reference/Querying/UmbracoHelper)). The `UmbracoHelper` object is a gateway to an array of useful functionality.

```csharp
@inherits UmbracoViewPage<Blogpost>
@using ContentModels = Umbraco.Web.PublishedModels;
@{
    Layout = "master.cshtml";

    // retrieve an item from Umbraco's published cache with id 123
    IPublishedContent publishedContentItem = Umbraco.Content(123);

    // it is really 'unlikely' to need to use a management Service in a view:
    // var relationService = Services.RelationService;
}
```

## Accessing Core Services and Helpers in a Controller

Inside a [custom Controller](../../Reference/Routing/custom-controllers.md) access is provided to Services via the `Services` property ([ServiceContext](../../Reference/Management/Services/)) and the `UmbracoHelper` via the `Umbraco` property ([UmbracoHelper](../../Reference/Querying/UmbracoHelper)).

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
    {
        public BlogPostController()
        {
        }
        public override ActionResult Index(ContentModel model)
        {
            // write helpful messages to the Umbraco Trace logs to aid with debugging
            Logger.Info<BlogPostController>("Using core logger implementation");
            // retrieve an item from Umbraco's published cache with id 123
            IPublishedContent publishedContentItem = Umbraco.Content(123);
            // it is unlikely to use a management service when rendering content from a custom controller
            //(when using relationService like this you would want to provide a layer of caching)
            //var allRelatedUmbracoItems = Services.RelationService.GetByParentId(model.Id);_
        }
```

## Accessing core Services and Helpers when there is no 'UmbracoContext' eg in a Component or C# Class

Controllers and Views have an UmbracoContext, however this is not always the case 'everywhere in Umbraco', for example common extension points: Components,ContentFinders or Custom C# Classes.

:::Warning
UmbracoContext, UmbracoHelper, PublishedContentQuery - are all based on an HttpRequest - their lifetime is controlled by an HttpRequest. So if you are not operating within an actual request, you cannot inject these parameters and if you try to ...  Umbraco will report a 'boot' error on startup.
:::

### Injecting Services into a Component

It's possible to inject management Services that do not rely on the `UmbracoContext` into the constructor of a component. This example shows injecting the MediaService in a Component to create a corresponding Media Folder for every 'landing page' that is saved in the Content Section, by subscribing to the 'Content Saved' event.

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
            // called when the Umbraco application shuts down.
            ContentService.Saved -= ContentService_Saved;
        }
    }
}
```

See documentation on [Composing](../Composing/) for further examples and information on Components and Composition.

### Accessing Published Content outside of a Http Request

Trying to inject types that are based on an Http Request such as `UmbracoHelper` or `IPublishedContentQuery` into classes that are not based on an Http Request will trigger a boot error. However, there is a technique that allows the querying of the Umbraco Published Content, using the `UmbracoContextFactory` and calling `EnsureUmbracoContext()`.

In this example, when a page is unpublished, instead of a 404 occurring for the content when the url is requested in the future, we might want to serve a 410 'page gone' status code instead. We handle the Unpublishing Event of the ContentService, access the Published Content Cache, determine it's 'published url' and then store for later use in any 'serving the 410' mechanism.

An [IContentFinder](../../Reference/Routing/Request-Pipeline/IContentFinder.md) could be placed in the ContentFinder ordered collection, right before a 404 is served. This could be done to lookup the incoming request against the stored location of 410 urls, and serve the 410 status request code if a match is found for the previously published item.

```csharp
using Umbraco.Core.Composing;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Implement;
using Umbraco.Web;
using Umbraco.Web.PublishedCache;

namespace Umbraco8.Components
{
    // adds the component to Umbraco composition's list of components
    public class HandleUnPublishingEventComposer : ComponentComposer<HandleUnPublishingEventComponent>
    {

    }

    public class HandleUnPublishingEventComponent : Umbraco.Core.Composing.IComponent
    {
        private readonly IUmbracoContextFactory _umbracoContextFactory;
        private readonly ICustomFourTenService _customFourTenService;

        public HandleUnPublishingEventComponent(IUmbracoContextFactory umbracoContextFactory, ICustomFourTenService customFourTenService)
        {
            _umbracoContextFactory = umbracoContextFactory;
            _customFourTenService = customFourTenService;
        }

        public void Initialize()
        {
            ContentService.Unpublishing += ContentService_Unpublishing;
        }

        private void ContentService_Unpublishing(Umbraco.Core.Services.IContentService sender, Umbraco.Core.Events.PublishEventArgs<Umbraco.Core.Models.IContent> e)
        {
            foreach (var item in e.PublishedEntities)
            {
                if (item.ContentType.Alias == "blogpost")
                {
                    // for each unpublished item, we want to find the url that it was previously 'published under' and store in a database table or similar
                    using (UmbracoContextReference umbracoContextReference = _umbracoContextFactory.EnsureUmbracoContext())
                    {
                        // the UmbracoContextReference provides access to the ContentCache
                        IPublishedContentCache contentCache = umbracoContextReference.UmbracoContext.Content;
                        // item being unpublished will still be in the cache, as unpublishing event fires before the cache is updated.
                        IPublishedContent soonToBeUnPublishedItem = contentCache.GetById(item.Id);
                        if (soonToBeUnPublishedItem != null)
                        {
                            string previouslyPublishedUrl = soonToBeUnPublishedItem.Url;
                            if (!String.IsNullOrEmpty(previouslyPublishedUrl) && previouslyPublishedUrl != "#")
                            {
                                _customFourTenService.InsertFourTenUrl(previouslyPublishedUrl, DateTime.UtcNow);
                            }
                        }
                    }
                }
            }
        }
        public void Terminate()
        {
            // called when the Umbraco application shuts down.
            ContentService.Unpublishing -= ContentService_Unpublishing;
        }
    }
}
```

#### Accessing the Published Content Cache from a Content Finder / UrlProvider

Inside a ContentFinder access to the content cache is already provided via the PublishedRequest object:

```csharp
public bool TryFindContent(PublishedRequest frequest)
{
    var someContent = frequest.UmbracoContext.Content.GetById(1234);

    // ...
}
```

And inside a UrlProvider the GetUrl method has the current UmbracoContext injected:

```csharp
public override UrlInfo GetUrl(UmbracoContext umbracoContext, IPublishedContent content, UrlMode mode, string culture, Uri current)
{
    var someContent = umbracoContext.Content.GetById(1234);

    // ...
}
```

:::Note
It is still possible to inject services into IContentFinder's. IContentFinders are singletons, but the example is showing you do not 'need to' in order to access the Published Content Cache!
Also note that UrlMode was renamed from UrlProviderMode in Umbraco v8.1.
:::

## Customizing Services and Helpers

When implementing an Umbraco site, it is likely to have to execute similar code that accesses or operates on Umbraco data, in multiple places, perhaps using the core management Services or Umbraco Helpers.

For example; Getting a list of the latest News Articles, or building a link to the site's News Section or Contact Us page. Repeating this kind of logic in multiple places, Views, Partial Views / Controllers etc, is fine. It's generally considered good practice to consolidate this logic into a single place.

### Extension methods

One option is to add 'Extension Methods' to the `UmbracoHelper` class.

```csharp
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;

namespace Umbraco8.Extensions
{
    public static class UmbracoHelperExtensions
    {
        public static IPublishedContent GetNewsSection(this UmbracoHelper umbracoHelper)
            {
                // assuming a single site with a single News Section at the top level
                IPublishedContent siteRoot = umbracoHelper.ContentAtRoot().FirstOrDefault();
                // make sure siteRoot isn't null, then locate first child content item with alias 'newsSection'
                return siteRoot?.FirstChild(f => f.ContentType.Alias == "newsSection") ?? null;
}
    }
}
```

Anywhere there is reference to the UmbracoHelper, and a reference is added to the namespace the extension belongs to, it is possible to call the method by writing `Umbraco.GetNewsSection()`.

### Custom Services and Helpers

Another option, is to make use of the underlying DI framework, and create custom Services and Helpers, that in turn can have the 'core' management Services and Umbraco Helpers injected into them.

This approach enables the grouping together of similar methods within a suitably named service, and promotes the possibility of testing this custom logic outside of Controllers and Views.

:::warning
Depending on where the custom service will be utilised, we will dictate the best practice approach to accessing the 'Published Content Cache'. If it is 100% guaranteed that the service will only be called from a place with an UmbracoContext, eg a controller or view, then it is safe to inject `IPublishedContentQuery` etc for simplicity. However if the custom service is called in a location without UmbracoContext (eg an event handler) it will fail. Therefore the approach of accessing the Published Content Cache via injecting IUmbracoContextFactory and calling `EnsureUmbracoContext()` will provide consistency across any custom services no matter where they are utilised.
:::

In this example, we create a custom service, that's responsible for finding key pages within a site, eg the News Section or the Contact Us page. These methods will commonly be called in different places throughout the site, and it's great to encapsulate the logic to retrieve them in a single place - we'll call this service `SiteService`.

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
    public class SiteService : ISiteService
    {
        public IPublishedContent GetNewsSection()
        {
            // TODO: implement this!
            throw new NotImplementedException();
        }

        public IPublishedContent GetContactUsPage()
        {
            // TODO: implement this!
            throw new NotImplementedException();
        }
    }
}
```

Register the custom service with Umbraco's underlying DI container using an `IUserComposer`:

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
            // if your service makes use of the current UmbracoContext, eg AssignedContentItem - register the service in Request scope
            // composition.Register<ISiteService, SiteService>(Lifetime.Request);
            // if not then it is better to register in 'Singleton' Scope
            composition.Register<ISiteService, SiteService>(Lifetime.Singleton);
        }
    }
}
```

#### Lifespans

**"Transient"** services can be injected into "Transient" and below ⤵. (i.e. "Transient" services can be injected anywhere)

- "Transient" means that anytime this type is needed a brand new instance of this type will be created.

**"Singleton"** services can be injected into "Singletons" and below ⤵.

- "Singleton" means that only a single instance of this type will ever be created for the lifetime of the application.

**"Request"** services can be injected into "Request" based lifespans only

- "Request" based lifetime means anytime this type is needed one new instance of this type will be created for the duration of the current HttpRequest. The object will be disposed of at the end of the current HttpRequest.

#### Implementing the service

##### 1 - The service will ONLY be used during a request like in a Controller or View

Although you already have access to the UmbracoHelper IPublishedTypedQuery via the Umbraco property in these locations, you can avoid repeating common implementation logic in multiple controllers and views. This is done by consolidating these implementations into a custom service. If you are very familiar with IPublishedContentQuery injecting this into the custom service is straight forward, but the caveat is you can only use this service in a controller/view.

For example, locating the 'special' pages in the site using the familiar syntax of the `IPublishedContentQuery`:

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
            var newsSection = siteRoot?.FirstChild(f => f.ContentType.Alias == "newsSection") ?? null;
            return newsSection;
        }
        public IPublishedContent GetContactUsPage()
        {
            var siteRoot = _contentQuery.ContentAtRoot().FirstOrDefault();
            var contactUs = siteRoot?.FirstChild(f => f.ContentType.Alias == "contactUs") ?? null;
            return contactUs;
        }
    }
}
```

##### 2 - The service can be used within or outside of a web request

```csharp
using System.Linq;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;
using Umbraco.Web.PublishedCache;

namespace Umbraco8.Services
{
    public class SiteService : ISiteService
    {
        private readonly IUmbracoContextFactory _umbracoContextFactory;
        public SiteService(IUmbracoContextFactory umbracoContextFactory)
        {
            _umbracoContextFactory = umbracoContextFactory;
        }

        public IPublishedContent GetNewsSection()
        {
            IPublishedContent newsSection = null;

            using (UmbracoContextReference umbracoContextReference = _umbracoContextFactory.EnsureUmbracoContext())
            {
                IPublishedContentCache contentCache = umbracoContextReference.UmbracoContext.Content;
                IPublishedContent siteRoot = contentCache.GetAtRoot().FirstOrDefault();
                newsSection = siteRoot?.FirstChild(f => f.ContentType.Alias == "newsSection") ?? null;
            }
            return newsSection;
        }

        public IPublishedContent GetContactUsPage()
        {
            IPublishedContent contactUsPage = null;
            using (UmbracoContextReference umbracoContextReference = _umbracoContextFactory.EnsureUmbracoContext())
            {
                IPublishedContentCache contentCache = umbracoContextReference.UmbracoContext.Content;
                IPublishedContent siteRoot = contentCache.GetAtRoot().FirstOrDefault();
                contactUsPage = siteRoot?.FirstChild(f => f.ContentType.Alias == "contactUs") ?? null;
            }
            return contactUsPage;
        }
    }
}
```

The second approach can seem 'different' or more complex at first glance, but it is the syntax and method names that are slightly different... it enables the registering of the service in Singleton Scope, and its use outside of controllers and views.

:::tip
Occasionally, you may face a situation where Umbraco fails to boot, due to a circular dependency on `IUmbracoContextFactory`.  This can happen if your service interacts with   third party code that also depends on an `IUmbracoContextFactory` instance (e.g. an Umbraco package).

See the [Circular Dependencies](Circular-Depndencies) article for an example on how to get around this.
:::

###### Aside: What is the IUmbracoContextAccessor then?

The `IUmbracoContextFactory` will obtain an `UmbracoContext` by first checking to see if one exists on the current thread using the `IUmbracoContextAccessor`. This is a singleton that can be injected anywhere and whose function is to provide access to the current UmbracoContext. On a 'non request' thread the IUmbracoContextAccessor's UmbracoContext property will be null and the IUmbracoContextFactory will create a new instance of the UmbracoContext.

If you need to know whether the UmbracoContext has been obtained from an existing thread, or whether it has been freshly created, you can 'inject' `IUmbracoContextAccessor` yourself. This will check if the UmbracoContext is null, indicating whether you are in a 'non request' thread or not. You will still need to inject and use an IUmbracoContextFactory if you subsequently want to obtain an UmbracoContext in a non-request thread.

```csharp
using System.Linq;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;
using Umbraco.Web.PublishedCache;

namespace Umbraco8.Services
{
    public class SiteService : ISiteService
    {
        private readonly IUmbracoContextAccessor _umbracoContextAccessor;
        private readonly IUmbracoContextFactory _umbracoContextFactory;

        public SiteHelperService(IUmbracoContextAccessor umbracoContextAccessor, IUmbracoContextFactory umbracoContextFactory)
        {
            _umbracoContextAccessor = umbracoContextAccessor;
            _umbracoContextFactory = umbracoContextFactory;
            bool hasUmbracoContext = _umbracoContextAccessor.UmbracoContext != null;
        }
```

NB: With the `IUmbracoContextAccessor` and `IUmbracoContextFactory` you should NEVER have to inject the UmbracoContext itself directly into any of your constructors.

#### Using the custom SiteService inside a Controller

Because we've registered the SiteService with Umbraco's underlying DI framework we can inject the service into our controller's constructor, in the same way as 'core' Services and Helpers.

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

        public BlogPostController(ISiteService siteService)
        {
            _siteService = siteService ?? throw new ArgumentNullException(nameof(siteService));
        }

        public override ActionResult Index(ContentModel model)
        {
            var newsSection = _siteService.GetNewsSection();
            var blogPostViewModel = new BlogPostViewModel(model);
            blogPostViewModel.HasNewsSection = false;
            if (newsSection != null)
            {
                blogPostViewModel.HasNewsSection = true;
                blogPostViewModel.NewsSection = newsSection;
            }

            // etc
            // Do other stuff here!, then return the custom viewmodel to the template view.
            return CurrentTemplate(blogPostViewModel);
        }
    }
}
```

:::warning
This isn't truly 'best practice' when using DI. This 'only works' in Umbraco because when a dependency for the base RenderMvcController isn't supplied via a constructor, Umbraco 'falls back' and uses the Service Locator pattern to inject the missing elements. This enables developers to choose to ignore DI, but if trying to following DI best practice, and to make the controller 'unit testable' - use the following example instead which supplies all constructor parameters for the base class.
:::

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

        public BlogPostController(IGlobalSettings globalSettings, IUmbracoContextAccessor umbracoContextAccessor, ServiceContext services, AppCaches appCaches, IProfilingLogger profilingLogger, UmbracoHelper umbracoHelper, ISiteService siteService)
            : base(globalSettings, umbracoContextAccessor, services, appCaches, profilingLogger, umbracoHelper)
        {
            _siteService = siteService ?? throw new ArgumentNullException(nameof(siteService));
        }

        public override ActionResult Index(ContentModel model)
        {
            var newsSection = _siteService.GetNewsSection();
            var blogPostViewModel = new BlogPostViewModel(model);
            blogPostViewModel.HasNewsSection = false;
            if (newsSection != null)
            {
                blogPostViewModel.HasNewsSection = true;
                blogPostViewModel.NewsSection = newsSection;
            }

            // etc
            // Do other stuff here!, then return the custom viewmodel to the template view.
            return CurrentTemplate(blogPostViewModel);
        }
    }
}
```

:::tip
You can generate this ctor in Visual Studio by using either ctrl + . or alt + enter when your cursor is on the base class:

![Generate DI constructor parameters in Visual Studio](images/vs-di-constructor-generation-tip.gif)
:::

#### Using the SiteService inside a View

If strictly following the paradigm of MVC, calling custom Services from Views might feel like an anti-pattern. However there isn't necessarily one single 'best practice' approach to working with Umbraco. A lot depends on circumstance, expertise and pragmatism. Allowing Umbraco to handle the flow of incoming requests to a particular page + template, and writing implementation logic in Views/Templates, is still a very common approach. There are circumstances, where the custom implementation logic shared is very 'View' specific. Custom logic for constructing 'Alternative Text' for images or different crop urls for img srcsets can be neatly handled in a custom Helper/Service without having to create a hijacked MVC route for the request and build a complex ViewModel. Custom Services called from Views, can help separate the concerns, even if the 'plumbing' isn't pure MVC.

To access the service directly from the view you would need to use the Service Locator pattern and the `Current.Factory.GetInstance()` method to get a reference to the concrete implementation of the service registered with DI:

```csharp
@using Umbraco8.Services
@using Current = Umbraco.Web.Composing.Current;
@inherits UmbracoViewPage
@{

    Layout = "master.cshtml";
    ISiteService SiteService = Current.Factory.GetInstance<ISiteService>();
    IPublishedContent newsSection = SiteService.GetNewsSection();
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
        public readonly ISiteService SiteService;
        public CustomViewPage() : this(
            Current.Factory.GetInstance<ISiteService>(),
            Current.Factory.GetInstance<ServiceContext>(),
            Current.Factory.GetInstance<AppCaches>()
            )
        { }

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
}
```

with this in place all views inheriting from CustomViewPage or CustomViewPage&lt;T&gt; would have access to the SiteService:

```csharp
@using Umbraco8.ViewPages
@inherits CustomViewPage<BlogPost>
@{

    Layout = "master.cshtml";
    IPublishedContent newsSection = SiteService.GetNewsSection();
}
<section class="section">
    <div class="container">
        <article>
```

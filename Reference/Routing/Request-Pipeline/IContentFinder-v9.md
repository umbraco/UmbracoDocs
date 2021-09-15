---
versionFrom: 9.0.0
meta.Title: "Creating content finders"
meta.Description: "Information about creating your own content finders"
state: complete
verified-against: beta-4
update-links: false
---

# IContentFinder

To create a custom content finder, with custom logic to find an Umbraco document based on a request, implement the IContentFinder interface:

```csharp
public interface IContentFinder
{
  bool TryFindContent(IPublishedRequestBuilder contentRequest);
}
```
and use either an Umbraco builder extension, or a composer to add it to it to the `ContentFindersCollection`.

Umbraco runs all content finders in the collection 'in order', until one of the IContentFinders returns true, the request is then handled by that finder, and no further IContentFinders are executed. Therefore the order in which ContentFinders are added to the ContentFinderCollection is important.

The ContentFinder can set the PublishedContent item for the request, or template or even execute a redirect.

### Example

This IContentFinders will find a document with id 1234, when the Url begins with /woot.

```csharp
public class MyContentFinder : IContentFinder
{
    private readonly IUmbracoContextAccessor 
    ;

    public MyContentFinder(IUmbracoContextAccessor umbracoContextAccessor)
    {
        _umbracoContextAccessor = umbracoContextAccessor;
    }

    public bool TryFindContent(IPublishedRequestBuilder contentRequest)
    {
        // Handle all requests beginning with /woot
        var path = contentRequest.Uri.GetAbsolutePathDecoded();
        if (path.StartsWith("/woot") is false)
        {
            return false; // Not found
        }
        
        if(!_umbracoContextAccessor.TryGetUmbracoContext(out var umbracoContext))
        {
            return false;
        }
        // Have we got a node with ID 1234
        var content = umbracoContext.Content.GetById(1234);
        if (content is null)
        {
            // If not found, let another IContentFinder in the collection try.
            return false;
        }
        
        // If content is found, then render that node
        contentRequest.SetPublishedContent(content);
        return true;
    }
}
```

### Adding and removing IContentFinders

You either use an extension on the Umbraco builder or, a composer to access the `ContentFinderCollection` to add and remove specific `ContentFinders`

#### Umbraco builder extension

First create the extension method:

```c#
using RoutingDocs.ContentFinders;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Routing;

namespace RoutingDocs.Extensions
{
    public static class UmbracoBuilderExtensions
    {
        public static IUmbracoBuilder AddCustomContentFinders(this IUmbracoBuilder builder)
        {
            // Add our custom content finder just before the core ContentFinderByUrl
            builder.ContentFinders().InsertBefore<ContentFinderByUrl, MyContentFinder>();
            // You can also remove content finders, this is not required here though, since our finder runs before the url one
            builder.ContentFinders().Remove<ContentFinderByUrl>();
            // You use Append to add to the end of the collection
            builder.ContentFinders().Append<AnotherContentFinderExample>();
            // or Insert for a specific position in the collection
            builder.ContentFinders().Insert<AndAnotherContentFinder>(3);
            return builder;
        }
    }
}
```

Then invoke it in `ConfigureServices` in the `Startup.cs` file:

```c#
public void ConfigureServices(IServiceCollection services)
{
#pragma warning disable IDE0022 // Use expression body for methods
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()
        .AddCustomContentFinders()
        .Build();
#pragma warning restore IDE0022 // Use expression body for methods
}
```


#### Composer

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Routing;

namespace RoutingDocs.ContentFinders
{
    public class UpdateContentFindersComposer : IUserComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            // Add our custom content finder just before the core ContentFinderByUrl
            builder.ContentFinders().InsertBefore<ContentFinderByUrl, MyContentFinder>();
            // You can also remove content finders, this is not required here though, since our finder runs before the url one
            builder.ContentFinders().Remove<ContentFinderByUrl>();
            // You use Append to add to the end of the collection
            builder.ContentFinders().Append<AnotherContentFinderExample>();
            // or Insert for a specific position in the collection
            builder.ContentFinders().Insert<AndAnotherContentFinder>(3);
        }
    }
}

```
:::note
In Umbraco 7 there existed an IContentFinder that would find content and display it with an 'alternative template' via a convention. This could be to avoid the ugly `?alttemplate=blogfullstory` appearing on the querystring of the url when using the alternative template mechanism. Instead the Url could follow the convention of `/urltocontent/altemplatealias`. 

Eg: `/blog/my-blog-post/blogfullstory` would 'find' the `/blog/my-blog-post` page and display using the `blogfullstory` template. 

In Umbraco 9 this convention has been removed from the default configuration of Umbraco. You can reintroduce this behaviour by adding the `ContentFinderByUrlAndTemplate` ContentFinder back into the ContentFinderCollection, using an `IUserComposer`, or Umbraco builder extension (see above example).
:::

# NotFoundHandlers

To set your own 404 finder create an IContentLastChanceFinder and set it as the ContentLastChanceFinder. (perhaps you have a multilingual site and need to find the appropriate 404 page in the correct language)

A ContentLastChanceFinder will always return a 404 status code. This example creates a new implementation of the IContentLastChanceFinder and checks whether the requested content could not be found by using the default `Is404` property presented in the `PublishedRequest` class.

```csharp
using System.Linq;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;

namespace RoutingDocs.ContentFinders
{
    public class My404ContentFinder : IContentLastChanceFinder
    {
        private readonly IDomainService _domainService;
        private readonly IUmbracoContextAccessor _umbracoContextAccessor;

        public My404ContentFinder(IDomainService domainService, IUmbracoContextAccessor umbracoContextAccessor)
        {
            _domainService = domainService;
            _umbracoContextAccessor = umbracoContextAccessor;
        }
        
        public bool TryFindContent(IPublishedRequestBuilder contentRequest)
        {
            // Find the root node with a matching domain to the incoming request
            var allDomains = _domainService.GetAll(true).ToList();
            var domain = allDomains?
                .Where(f => f.DomainName == contentRequest.Uri.Authority || f.DomainName == $"https://{contentRequest.Uri.Authority}")
                .FirstOrDefault();
            var siteId = domain != null ? domain.RootContentId : allDomains.Any() ? allDomains.FirstOrDefault()?.RootContentId : null;
            if(!_umbracoContextAccessor.TryGetUmbracoContext(out var umbracoContext))
            {
                return false;
            }
            var siteRoot = umbracoContext.Content.GetById(false, siteId ?? -1);

            if (siteRoot is null)
            {
                return false;
            }

            // Assuming the 404 page is in the root of the language site with alias fourOhFourPageAlias
            IPublishedContent notFoundNode = siteRoot.Children.FirstOrDefault(f => f.ContentType.Alias == "fourOhFourPageAlias");

            if (notFoundNode is not null)
            {
                contentRequest.SetPublishedContent(notFoundNode);
            }

            // Return true or false depending on whether our custom 404 page was found
            return contentRequest.PublishedContent is not null;
        }
    }
}
```

Example on how to register your own implementation:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace RoutingDocs.ContentFinders
{
    public class UpdateContentFindersComposer : IUserComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.SetContentLastChanceFinder<My404ContentFinder>();
        }
    }
}
```

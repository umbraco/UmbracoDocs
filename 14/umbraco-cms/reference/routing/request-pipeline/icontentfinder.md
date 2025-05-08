---
description: Information about creating your own content finders
---

# IContentFinder

To create a custom content finder, with custom logic to find an Umbraco document based on a request, implement the IContentFinder interface:

```csharp
public interface IContentFinder
{
  Task<bool> TryFindContent(IPublishedRequestBuilder contentRequest);
}
```

and use either an Umbraco builder extension, or a composer to add it to it to the `ContentFindersCollection`.

Umbraco runs all content finders in the collection 'in order', until one of the IContentFinders returns true. Once this occurs, the request is then handled by that finder, and no further IContentFinders are executed. Therefore the order in which ContentFinders are added to the ContentFinderCollection is important.

The ContentFinder can set the PublishedContent item for the request, or template or even execute a redirect.

## Example

This IContentFinders will find a document with id 1234, when the Url begins with /woot.

```csharp
public class MyContentFinder : IContentFinder
{
    private readonly IUmbracoContextAccessor _umbracoContextAccessor;

    public MyContentFinder(IUmbracoContextAccessor umbracoContextAccessor)
    {
        _umbracoContextAccessor = umbracoContextAccessor;
    }

    public Task<bool> TryFindContent(IPublishedRequestBuilder contentRequest)
    {
        var path = contentRequest.Uri.GetAbsolutePathDecoded();
        if (path.StartsWith("/woot") is false)
        {
            return Task.FromResult(false); // Not found
        }

        if (!_umbracoContextAccessor.TryGetUmbracoContext(out var umbracoContext))
        {
            return Task.FromResult(false);
        }

        // Have we got a node with ID 1234
        var content = umbracoContext.Content.GetById(1234);
        if (content is null)
        {
            // If not found, let another IContentFinder in the collection try.
            return Task.FromResult(false);
        }

        // If content is found, then render that node
        contentRequest.SetPublishedContent(content);
        return Task.FromResult(true);
    }
}
```

### Adding and removing IContentFinders

You can use either an extension on the Umbraco builder or a composer to access the `ContentFinderCollection` and add or remove specific `ContentFinders`.

{% hint style="info" %}
Learn more about registering dependencies and when to use which method in the [Dependency Injection](../../using-ioc.md) article.
{% endhint %}

#### Umbraco builder extension

First create the extension method:

```csharp
using RoutingDocs.ContentFinders;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Routing;

namespace RoutingDocs.Extensions;

public static class UmbracoBuilderExtensions
{
    public static IUmbracoBuilder AddMyCustomContentFinders(this IUmbracoBuilder builder)
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
```

Then invoke in the `Program.cs` file:

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddMyCustomContentFinders()
    .Build();
```

#### Composer

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Routing;

namespace RoutingDocs.ContentFinders;

public class UpdateContentFindersComposer : IComposer
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
```

## NotFoundHandlers

To set your own 404 finder create an IContentLastChanceFinder and set it as the ContentLastChanceFinder. (perhaps you have a multilingual site and need to find the appropriate 404 page in the correct language).

A `IContentLastChanceFinder` will always return a 404 status code. This example creates a new implementation of the `IContentLastChanceFinder` and gets the 404 page for the current language of the request.

```csharp
using System.Linq;
using System.Threading.Tasks;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Routing;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Web;

namespace RoutingDocs.ContentFinders;

public class My404ContentFinder : IContentLastChanceFinder
{
    private readonly IDomainService _domainService;
    private readonly IUmbracoContextAccessor _umbracoContextAccessor;

    public My404ContentFinder(IDomainService domainService, IUmbracoContextAccessor umbracoContextAccessor)
    {
        _domainService = domainService;
        _umbracoContextAccessor = umbracoContextAccessor;
    }
    
    public Task<bool> TryFindContent(IPublishedRequestBuilder contentRequest)
    {
        // Find the root node with a matching domain to the incoming request
        var allDomains = _domainService.GetAll(true).ToList();
        var domain = allDomains?
            .FirstOrDefault(f => f.DomainName == contentRequest.Uri.Authority
                                    || f.DomainName == $"https://{contentRequest.Uri.Authority}"
                                    || f.DomainName == $"http://{contentRequest.Uri.Authority}");

        var siteId = domain != null ? domain.RootContentId : allDomains.Any() ? allDomains.FirstOrDefault()?.RootContentId : null;

        if (!_umbracoContextAccessor.TryGetUmbracoContext(out var umbracoContext))
        {
            return Task.FromResult(false);
        }

        if (umbracoContext.Content == null)
            return new Task<bool>(() => contentRequest.PublishedContent is not null);

        var siteRoot = umbracoContext.Content.GetById(false, siteId ?? -1);

        if (siteRoot is null)
        {
            return Task.FromResult(false);
        }

        // Assuming the 404 page is in the root of the language site with alias fourOhFourPageAlias
        var notFoundNode = siteRoot.Children?.FirstOrDefault(f => f.ContentType.Alias == "fourOhFourPageAlias");

        if (notFoundNode is not null)
        {
            contentRequest.SetPublishedContent(notFoundNode);
        }

        // Return true or false depending on whether our custom 404 page was found
        return Task.FromResult(contentRequest.PublishedContent is not null);
    }
}
```

You can configure Umbraco to use your own implementation in the `Program.cs` file:

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
     // If you need to add something Umbraco specific, do it in the "AddUmbraco" builder chain, using the IUmbracoBuilder extension methods.
    .SetContentLastChanceFinder<RoutingDocs.ContentFinders.My404ContentFinder>()
    .Build();
```

{% hint style="warning" %}
When adding a custom `IContentLastChanceFinder` to the pipeline any `Error404Collection`-settings in `appSettings.json` will be ignored.
{% endhint %}

---
versionFrom: 8.0.0
---

# IContentFinder

To create a custom content finder, with custom logic to find an Umbraco document based on a request, implement the IContentFinder interface:

```csharp
public interface IContentFinder
{
  bool TryFindContent(PublishedRequest contentRequest);
}
```
and use a composer to add to it to the ContentFindersCollection.

Umbraco runs all content finders in the collection 'in order', until one of the IContentFinders returns true, and then the request is handled by that finder, and no further IContentFinders are executed. Therefore the order in which ContentFinders are added to the ContentFinderCollection is important.

The ContentFinder can set the PublishedContent item for the request, or template or even execute a redirect…

### Example

This IContentFinders will find a document with id 1234, when the Url begins with /woot

```csharp
public class MyContentFinder : IContentFinder
{
  public bool TryFindContent(PublishedRequest contentRequest)
  {
  // handle all requests beginning /woot...
    var path = contentRequest.Uri.GetAbsolutePathDecoded();
    if (!path.StartsWith("/woot"))
    return false; // not found

    // have we got a node with ID 1234?
    var content = contentRequest.UmbracoContext.Content.GetById(1234);
    if (content == null) return false; // not found let another IContentFinder in the collection try to find a document

    // render that node
    contentRequest.PublishedContent = content;
    return true;
  }
}
```
### Adding and removing IContentFinders

Use a composer to access the ContentFinderCollection to add and remove specific ContentFinders...

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Web;
using Umbraco.Web.Routing;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class UpdateContentFindersComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            //add our custom MyContentFinder just before the core ContentFinderByUrl...
            composition.ContentFinders().InsertBefore<ContentFinderByUrl, MyContentFinder>();
            //remove the core ContentFinderByUrl finder:
            composition.ContentFinders().Remove<ContentFinderByUrl>();
            //you can use Append to add to the end of the collection
            composition.ContentFinders().Append<AnotherContentFinderExample>();
            //or Insert for a specific position in the collection
            composition.ContentFinders().Insert<AndAnotherContentFinder>(3);
        }
    }
}

```
:::note
In Umbraco7 there existed an IContentFinder that would find content and display it with an 'alternative template' via a convention. This could be to avoid the ugly `?alttemplate=blogfullstory` appearing on the querystring of the url when using the alternative template mechanism. Instead the Url could follow the convention of `/urltocontent/altemplatealias`. 

Eg: `/blog/my-blog-post/blogfullstory` would 'find' the `/blog/my-blog-post` page and display using the `blogfullstory` template. 

In Umbraco 8 this convention has been removed from the default configuration of Umbraco. You can reintroduce this behaviour by adding the `ContentFinderByUrlAndTemplate` ContentFinder back into the ContentFinderCollection, using an `IUserComposer` (see above example).
:::

# NotFoundHandlers

To set your own 404 finder create an IContentLastChanceFinder and set it as the ContentLastChanceFinder. (perhaps you have a multilingual site and need to find the appropriate 404 page in the correct language)

A ContentLastChanceFinder will always return a 404 status code. This example creates a new implementation of the IContentLastChanceFinder and checks whether the requested content could not be found by using the default `Is404` property presented in the `PublishedRequest` class.

```csharp
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Core.Services;
using Umbraco.Web;
using Umbraco.Web.Routing;

namespace My.Website.ContentFinders
{
    public class My404ContentFinder : IContentLastChanceFinder
    {
        private readonly IDomainService _domainService;
        public My404ContentFinder(IDomainService domainService)
        {
            _domainService = domainService;
        }
        public bool TryFindContent(PublishedRequest contentRequest)
        {
            //find the root node with a matching domain to the incoming request
            var url = contentRequest.Uri.ToString();
            var allDomains = _domainService.GetAll(true);
            var domain = allDomains?.Where(f => f.DomainName == contentRequest.Uri.Authority || f.DomainName == "https://" + contentRequest.Uri.Authority).FirstOrDefault();
            var siteId = domain != null ? domain.RootContentId : (allDomains.Any() ? allDomains.FirstOrDefault().RootContentId : null);
            var siteRoot = contentRequest.UmbracoContext.Content.GetById(false, siteId ?? -1);
            if (siteRoot == null) { siteRoot = contentRequest.UmbracoContext.Content.GetAtRoot().FirstOrDefault(); }
            if (siteRoot == null)
            {
                return false;
            }
            //assuming the 404 page is in the root of the language site with alias fourOhFourPageAlias
            IPublishedContent notFoundNode = siteRoot.Children.FirstOrDefault(f => f.ContentType.Alias == "fourOhFourPageAlias");

            if (notFoundNode != null)
            {
                contentRequest.PublishedContent = notFoundNode;
            }
            // return true or false depending on whether our custom 404 page was found
            return contentRequest.PublishedContent != null;
        }
    }
}
```

Example on how to register your own implementation:

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Web;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class SetLastChanceContentFindersComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            //set the last chance content finder
            composition.SetContentLastChanceFinder<My404ContentFinder>();
        }
    }
}

```

:::note
To make sure your custom 404 page is served set the `error404` in `umbracoSettings.config` to 0.  
:::

---
versionFrom: 8.0.0
---

# Outbound request pipeline
The **outbound pipeline** consists out of the following steps:

1. [Create segments](#segments)
2. [Create paths](#paths)
3. [Create urls](#urls)

To explain things we will use the following content tree:
![simple content tree](images/simple-content-tree-v8.png)

## 1. <a name="segments"></a> Create segments
When the URL is constructed, Umbraco will convert every node in the tree into a segment.  Each published [Content](../../../Reference/Management/Models/Content) item has a corresponding url segment. 

In our example "Our Products" will become "our-products" and "Swibble" will become "swibble".

The segments are created by the "Url Segment provider"

### Url Segment provider
The 'Current Composition' of an Umbraco implementation contains a collection of `UrlSegmentProviders` this collection is populated during Umbraco boot up. Umbraco ships with a 'DefaultUrlSegmentProvider' - but you can add your own implementations to the collection.

When the GetUrlSegment extension method is called for a content item + culture combination, each registered IUrlSegmentProvider in the collection is executed in 'collection order' until a particular UrlSegmentProvider returns a segment value for the content. (and no further UrlSegementProviders in the collection will be executed.)

To create a new Url segment provider, implement the following interface:

```csharp
public interface IUrlSegmentProvider
{
  string GetUrlSegment(IContentBase content, string culture = null);
}
```
Note each 'culture' variation can have a different Url Segment!

The returned string will be your Url Segment for this node.  You are free to return whatever string you like, but it cannot contain url segment separators `/` characters as this would create additional "segments". So something like `5678/swibble` is not allowed.

#### Example

For the segment of a 'product page' add its unique SKU / product ref to the existing url segment...
```csharp
using Umbraco.Core.Models;
using Umbraco.Core.Strings;

namespace Umbraco8.Routing
{
    public class ProductPageUrlSegmentProvider : IUrlSegmentProvider
    {
 
            readonly IUrlSegmentProvider _provider = new DefaultUrlSegmentProvider();

            public string GetUrlSegment(IContentBase content, string culture = null)
            {
                //only apply this rule for product pages
                if (content.ContentType.Alias != "productPage") return null;
                var segment = _provider.GetUrlSegment(content);
                // get unique product sku/id  to add to url segment
                var productSku = content.GetValue("productSku");
                return string.Format("{0}-{1}", segment, productSku);
            }
    }
}
```

The returned string becomes the native Url segment.  You don't need any Url rewriting, ...

For our "swibble" product in our example content tree the  `ProductPageUrlSegmentProvider`, would return a segment "swibble-123xyz" (where 123xyz is the unique product sku for ordering "swibbles". 

Register the custom UrlSegmentProvider with Umbraco:

using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco8.Routing;

namespace Umbraco8.Composers
{
    public class RegisterCustomSegmentProviderComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.UrlSegmentProviders().Insert<ProductPageUrlSegmentProvider>();
        }
    }
}

### The Default Url Segment Provider

The Default Url Segment provider builds its segments like this:
 
First it looks (in this order) for: 

- a property with alias *umbracoUrlName* on the node. (this is a convention led way of giving editors control of the segment name - with variants - this can vary by culture).
- the 'name' of the content item eg content.Name

The Umbraco string extension `ToUrlSegment()` is used to produce a clean 'Url safe' segment.  

```csharp
 public string GetUrlSegment(IContentBase content, string culture = null)
        {
            return GetUrlSegmentSource(content, culture).ToUrlSegment(culture);
        }

        private static string GetUrlSegmentSource(IContentBase content, string culture)
        {
            string source = null;
            if (content.HasProperty(Constants.Conventions.Content.UrlName))
                source = (content.GetValue<string>(Constants.Conventions.Content.UrlName, culture) ?? string.Empty).Trim();
            if (string.IsNullOrWhiteSpace(source))
                source = content.GetCultureName(culture);
            return source;
        }
```

## 2. <a name="paths"></a>Create paths

To create a path, the pipeline will use the segments of each node to produce a path.

If we look at our example, the "swibble" node will receive the path: "/our-products/swibble".  If we take the `ProductPageUrlSegmentProvider` from above, the path would become: "/our-products/swibble-123xyz".  

### Multiple sites in a single Umbraco implementation

But, what if you have multiple websites in a single Umbraco Implementation? if you have multi-site setup then an (internal) path to a node such as "/our-products/swibble-123xyz" could belong to any of the sites, or match multiple nodes in multiple sites. In this scenario additional sites will have their internal path prefixed by the node id of their root node.
Any content node with a hostname defines a “new root” for paths.  

![path example](images/path-example-v8.png)

<table>
<tr><th>Node</th><th>Segment</th><th>Internal Path</th>
</tr>
<tr>
<td>Our Values</td><td>our-values</td><td>/our-values</td>
</tr>
<tr>
<td>Our Products</td><td>our-products</td><td>/our-products</td>
</tr>
<tr>
<td>Swibble</td><td>swibble-123xyz</td><td>/our-products/swibble-123xyz</td>
</tr>
<tr>
<td>Dibble</td><td>dibble-456abc</td><td>/our-products/dibble-456abc</td>
</tr>
<tr>
<td>Another Site</td><td>another-site</td><td><b>9676</b>/</td>
</tr>
<tr>
<td>Their Values</td><td>their-values</td><td><b>9676</b>/their-values</td>
</tr>
</table>

Paths can be cached, what comes next cannot (http vs https, current request…).

#### Some further considerations if you **work with hostnames**:

-  **Domain without path** e.g. "www.site.com"
will become "1234/path/to/page"
- **Domain with path** e.g. "www.site.com/dk"
will produce "1234/dk/path/to/page" as path
- **No domain specified**: "/path/to/page"
- **Unless HideTopLevelNodeFromPath config is true**, then the path becomes "/to/page"

## 3. <a name="urls"></a> Creating Urls
The Url of a node consists of a complete [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier): the Schema, Domain name, (port) and the path.  

In our example the "swibble" node could have the following URL: "http://example.com/our-products/swibble.aspx"

Generating this url is handled by the Url Provider.  The Url Provider is called whenever you write .Url (e.g.):

```csharp
@Model.Url
@Umbraco.Url(1234)
@UmbracoContext.UrlProvider.GetUrl(1234);
```

The 'Current Composition' of an Umbraco implementation contains a collection of `UrlProviders` this collection is populated during Umbraco boot up. Umbraco ships with a 'DefaultUrlProvider' - but you can add your own implementations to the collection.
When .Url is called each UrlProvider registered in the collection is executed in 'collection order' until a particular UrlProvider returns a value. (and no further UrlProviders in the collection will be executed.)
### DefaultUrlProvider
Umbraco ships with a DefaultUrlProvider, which provides the implementation for the out of the box mapping of the structure of the content tree to the url.

```csharp
// That one is initialized by default
public class DefaultUrlProvider : IUrlProvider
{
      public virtual UrlInfo GetUrl(UmbracoContext umbracoContext, IPublishedContent content, UrlProviderMode mode, string culture, Uri current)
      {…}

      public virtual IEnumerable<UrlInfo> GetOtherUrls(UmbracoContext umbracoContext, int id, Uri current)
      {…}
}
```
### How the Default Url provider works

- If the current domain matches a root domain of the target content
  - Return a relative Url
  - Else must return an absolute Url
- If the target content has only one root domain
  - Use that domain to build the absolute Url
- If the target content has more that one root domain
  - Figure out which one to use
  - To build the absolute Url
- Complete the absolute Url with scheme (http vs https)
  - If the domain contains a scheme use it
  - Else use the current request’s scheme

If "useDirectoryUrls" is false, then add .aspx in the Url.
If "addTrailingSlash" is true, then add a slash.
Then add the virtual directory.

If the URL provider encounters collisions when generating content URLs, it will always select the first available node and assign the URL to this one.
The remaining nodes will be marked as colliding and will not have a URL generated. If you do try to fetch the URL of a node with a collision URL you will get an error string including the node ID (#err-1094) since this node does not currently have an active URL.
This can happen if you use the umbracoUrlName property to override the generated URL of a node, or in some cases when having multiple root nodes without hostnames assigned.

:::warning
Keep in mind that this means publishing a unpublished node with a conflicting URL, might change the active node being rendered on that specific URL in cases where the published node should now take priority according to sort order in the tree!
:::

### Custom Url Provider

You can create your own Url Provider by the implementing `IUrlProvider` interface

```csharp
public interface IUrlProvider
{
      UrlInfo GetUrl(UmbracoContext umbracoContext, IPublishedContent content, UrlProviderMode mode, string culture, Uri current);

      IEnumerable<UrlInfo> GetOtherUrls(UmbracoContext umbracoContext, int id, Uri current);
}
```
The returned 'UrlInfo' by GetUrl can return whatever pleases you.

If implementing a custom Url Provider, consider following things:

- cache things,
- be sure to know how to handle schema's (http vs https) and hostnames 
- inbound might require rewriting

If you only have a small change to make to the default set of rules, then a smart way to create a custom Url Provider is to inherit from the DefaultUrlProvider and override the GetUrl() virtual method.
#### Example
 add /fish on the end of every url...

```csharp
using Umbraco.Core.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Umbraco.Core.Configuration;
using Umbraco.Core.Configuration.UmbracoSettings;
using Umbraco.Core.Models.PublishedContent;
using Umbraco.Web;
using Umbraco.Web.Routing;

namespace UmbracoV8.Routing.UrlProviders
{
    
    public class ProductPageUrlProvider : DefaultUrlProvider
    {
        private readonly ISiteDomainHelper _siteDomainHelper;
        public ProductPageUrlProvider(IRequestHandlerSection requestSettings, ILogger logger, IGlobalSettings globalSettings, ISiteDomainHelper siteDomainHelper) : base(requestSettings,logger,globalSettings,siteDomainHelper)
        {
            _siteDomainHelper = siteDomainHelper;
        }
        public override IEnumerable<UrlInfo> GetOtherUrls(UmbracoContext umbracoContext, int id, Uri current)
        {
            //add custom logic to return 'additional urls' - in the umbraco backoffice you might have seen multiple urls listed for a content item, this method populates that list.
            return base.GetOtherUrls(umbracoContext, id, current);
        }

        public override UrlInfo GetUrl(UmbracoContext umbracoContext, IPublishedContent content, UrlProviderMode mode, string culture, Uri current)
        {
           //only apply this to product pages
          if (content != null && content.ContentType.Alias == "productPage)
            {
              // get the original base url that the DefaultUrlProvider would have returned, it's important to call this via the base, rather than .Url, or UrlProvider.GetUrl to avoid cyclically calling this same provider in an infinite loop!!)
                UrlInfo defaultUrlInfo = base.GetUrl(umbracoContext, content, mode, culture,current);
               if (!defaultUrlInfo.IsUrl)
                {
                    //this is a message (eg published but not visible because the parent is unpublished or similar)
                    return defaultUrlInfo;
                }
               else
                {
                    //manipulate the url somehow in your custom way or something:
                    var orginalUrl = defaultUrlInfo.Text;
                    var customUrl = originalUrl + "fish/";
                    return new UrlInfo(customUrl, true,defaultUrlInfo.Culture);
                  
                }
            }
          //otherise return the base GetUrl result:
                return base.GetUrl(umbracoContext, content, mode, culture, current);
        }
    }
}
```

Register the custom UrlProvider with Umbraco:

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco8.Routing;

namespace Umbraco8.Composers
{
    public class RegisterCustomUrlProviderComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.UrlProviders().Insert<ProductPageUrlProvider>();
        }
    }
}
```
### GetOtherUrls

The GetOtherUrls method is only actioned in the Umbraco Backoffice to provide a list to editors of other Urls which also map to the node.
For example, the convention led umbracoUrlAlias property that enables editors to specify a comma delimited list of alternative urls for the node has a corresponding AliasUrlProvider reggistered in the UrlProviderCollecton to display this list to the Editor in the backoffice Info Content app for a node.

### Url Provider Mode
Specifies the type of urls that the url provider should produce, eg. absolute vs. relative Urls. Auto is the default

These are the different modes:

```csharp
public enum UrlProviderMode
{
  // Produce relative Urls exclusively 
  Relative,
  // Produce absolute Urls exclusively
  Absolute,
  // Produce relative Urls when possible, else absolute when required
  Auto
}
```
Auto is the default. You can change this setting in /config/umbracoSettings.config web.routing section:

```
  <web.routing
     urlProviderMode="Relative">
  </web.routing>
```


### Site Domain Helper
The `ISiteDomainHelper` implementation is used in the IUrlProvider and filters a list of <c>DomainAndUri</c> to pick one that best matches the current request.

You can create your own SiteDomainHelper by implementing ISiteDomainHelper

```csharp
public interface ISiteDomainHelper
{
   DomainAndUri MapDomain(IReadOnlyCollection<DomainAndUri> domainAndUris, Uri current, string culture, string defaultCulture);
IEnumerable<DomainAndUri> MapDomains(IReadOnlyCollection<DomainAndUri> domainAndUris, Uri current, bool excludeDefault, string culture, string defaultCulture);
}
```

Only a single SiteDomainHelper can be registered with Umbraco.

You would set your custom SiteDomainHelper using the SetSiteDomainHelper extension method

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco8.Routing;

namespace Umbraco8.Composers
{
    public class RegisterCustomUrlProviderComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.SetSiteDomainHelper<CustomSiteDomainHelper>();
        }
    }
}
```

The SiteDomainHelper's role is to get the current Uri and all eligible domains, and only return one domain which is then  used by the UrlProvider to create the Url.

You can use the default SiteDomainHelper to add extra domains:

```csharp

using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Web.Routing;

namespace Umbraco8.Composers
{
    public class AddExtraDomainsComposer : IUserComposer
    {      
        public void Compose(Composition composition)
        {
            SiteDomainHelper.AddSite("www", "www.alpha.com", "www.bravo.com");
            SiteDomainHelper.AddSite("staging", "staging.alpha.com", "staging.bravo.com");
        }
    }
}
```

Then it knows it should pick e.g. “www.bravo.com” when current is “www.alpha.com”.

A more complicated example with the SiteDomainHelper:

```csharp
        public void Compose(Composition composition)
        {  
            SiteDomainHelper.AddSite("www", "www.alpha.com", "www.bravo.com");
            SiteDomainHelper.AddSite("mobile", "mobile.alpha.com", "mobile.bravo.com");
            SiteDomainHelper.AddSite("staging", "staging.alpha.com", "staging.bravo.com");
            SiteDomainHelper.BindSites("www", "mobile");
        }
```

Backoffice on www.alpha.com/umbraco
then link is "www.bravo.com/bravo-2" ; alternate link is "mobile.bravo.com/bravo-2".  



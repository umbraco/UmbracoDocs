#Outbound request pipeline
The **outbound pipeline** consists out of the following steps:

1. [Create segments](#segments)
2. [Create paths](#paths)
3. [Create urls](#urls)

To explain things we will use the following content tree:
![simple content tree](images/simple-content-tree.png)

## 1. <a name="segments"></a> Create segments
When the URL is build up, Umbraco will convert every node into a segment.  Each published [Content](../..//Reference/Management-v6/Models/Content.md) has a url segment. 

In our example "Our Products" will become "our-products" and "Swibble" will become "swibble".

The segments are created by the "Url Segment provider"

### Url Segment provider
On Umbraco startup the `UrlSegmentProviderResolver` will search for the first `IUrlSegmentProvider` and that does not return `null`.

If no UrlSegment provider is found, he will fall back to the *default Url segment provider*.

To create a new Url segment provider, implement the following interface:

    public interface IUrlSegmentProvider
    {
      string GetUrlSegment(IContentBase content);
    }

The returned string will be your URL segment for this node.  You are free to return whatever string you like.

#### Example

    public class MyProvider : IUrlSegmentProvider
    {
      readonly IUrlSegmentProvider _provider = new DefaultUrlSegmentProvider();

      public string GetUrlSegment(IContentBase content)
      {
        if (content.ContentTypeId != 1234) return null;
        var segment = _provider.GetUrlSegment(content);
        return string.Format("{0}-{1}", content.Id, segment);
      }
    }

The returned string becomes the native Url segment.  You don't need any Url rewriting, ...

If we would use `MyProvider`, the "swibble" node from our example content tree would have "5678-swibble" as segment. 

### The Default Url Segment Provider

Default Url builds its segments like this. 
First it looks (in this order) for: 

- the *umbracoUrlName* property. on the node  `content.GetPropertyValue<string>("umbracoUrlName")`
- content.Name

Then uses Umbraco string extension `ToUrlSegment()` to produce a clean segment.  Read more about the [IShortStringHelper](IShortStringHelper.md)

    // That one is initialized by default
    public class DefaultUrlSegmentProvider : IUrlSegmentProvider
    { … }

    // Initialized by
    public class UrlSegmentProviderResolver
    { … }

## 2. <a name="paths"></a>Create paths
To create a path, the pipeline will use the segments to produce the path.

If we look at our example, the "swibble" node will receive the path: "/our-products/swibble".  If we take the `MyProvider` from above, the path would become: "/our-products/5678-swibble".  

But, if you would add another site, the (internal) paths for the nodes of second site will be is prefixed by the NODE ID of the site.
Any content node with a hostname defines a “new root” for paths.  

![path example](images/path-example.png)

Paths can be cached, what comes next cannot (http vs https, current request…).

There are a few more notes to make if you **work with hostnames**:

-  **Domain without path** e.g. "www.site.com"
will become "1234/path/to/page"
- **Domain with path** e.g. "www.site.com/dk"
will produce "1234/dk/path/to/page" as path
- **No domain specified**: "/path/to/page"
- **Unless HideTopLevelNodeFromPath config is true**, then the path becomes "/to/page"

## 3. <a name="urls"></a> Create Urls
The Url of a node consists out of a complete [URI](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier): the schema, domainname, (port) and the path.  

In our example the "swibble" node could have the following URL: "http://example.com/our-products/swibble.aspx"

This is handled by the Url Provider.  The Url provider is every time whenever you write (e.g.):

	@Content.Model.url
	@Umbraco.Url(1234)
	@UmbracoContext.Current.UrlProvider.Geturl(1234)

The `UrlProviderResolver` searches for all Url providers and will take the first one that does not return null.  If falls back to the default Urls provider if no Url provider has been found.

    // That one is initialized by default
    public class DefaultUrlProvider : IUrlProvider
    { … }
    // But feel free to use your owns
    public class UrlProviderResolver
    { … }

To create your own Url provider, implement the `IUrlProvider` interface

    public interface IUrlProvider
    {
        string GetUrl(UmbracoContext umbracoContext,
            int id,
            Uri current,
            UrlProviderMode mode);
    }

The returned string by GetUrl can return whatever pleases you.

It's tricky to implement your own provider, it is advised use override the default provider.  If implementing a custom Url Provider, consider following things:

- cache things,
- be sure to know how to handle schema's (http vs https) and hostnames 
- inbound might require rewriting

**TODO: "Per-context UrlProvider".
Stéphane mentions a "per context Url provider" on page 35 of his document.  We need to find out what this is!**

### How the Url provider works

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

### A few more things
**TODO: CHECK WITH IF THIS IS INTERPRETED CORRECTLY.  Copied from page 42 of Stéphane's document.**
 
- The IUrlProvider also has a GetOtherUrls method (For the back-end)
- Another implementation if the IUrlProvider is the `AliasUrlProvider`: this will show the umbracoUrlAlias url in the back-end

###Url Provider Mode
Provider "mode" determines absolute vs. relative Urls.
You can change the mode of the current provider

These are the different modes:

    public enum UrlProviderMode
    {
      // Produce relative Urls exclusively 
      Relative,
      // Produce absolute Urls exclusively
      Absolute,
      // Produce relative Urls when possible, else absolute when required
      Auto,
      // Produce relative Urls when possible, else absolute when required
      // If useDomainPrefixes is true, then produce absolute Urls exclusively
      AutoLegacy // this is the default mode in v6
    }

`Auto` is equivalent to `AutoLegacy` with useDomainPrefixes set to false

*Note*: `UseDomainPrefixes` is ignored in every mode except AutoLegacy

Default mode can be configured in `/umbraco/web.routing/urlProviderMode`

### Site Domain Helper
The Url provider needs a `ISiteDomainHelper` object, this object is provided by the `SiteDomainHelperResolver`.

This object gets the current Uri and all eligible domains, and return only one domain which is used by the UrlProvider to create the Url.

    // That one is initialized by default
    public class SiteDomainHelper : ISiteDomainHelper
    { … }
    // But feel free to use your own
    public class SiteDomainHelperResolver
    { … }

To create your own Site Domain helper, implement the ISiteDomainHelper and add it to the resolver.

    public interface ISiteDomainHelper
    {
      DomainAndUri MapDomain(Uri current, DomainAndUri[] domainAndUris);
    }

You can use the default SiteDomainhelper to add extra domains:

    public class MyApplication : ApplicationEventHandler
    {
      protected override void ApplicationStarting(…)
      {
        SiteDomainHelper.AddSite("www", "www.alpha.com", "www.bravo.com");
        SiteDomainHelper.AddSite("staging", "staging.alpha.com", "staging.bravo.com");
      }
    } 

Then it knows it should pick e.g. “www.bravo.com” when current is “www.alpha.com”.

A more complicated example with the SiteDomainHelper:

    public class MyApplication : ApplicationEventHandler
    {
      protected override void ApplicationStarting(…)
      {
        SiteDomainHelper.AddSite("www", "www.alpha.com", "www.bravo.com");
        SiteDomainHelper.AddSite("mobile", "mobile.alpha.com", " mobile.bravo.com");
        SiteDomainHelper.AddSite("staging", "staging.alpha.com", "staging.bravo.com");
        SiteDomainHelper.BindSites("www", "mobile");
      }
    }

Back-end on www.alpha.com/umbraco
then link is "www.bravo.com/bravo-2" ; alternate link is "mobile.bravo.com/bravo-2".  

If you have good ideas on creating better implementations, please share them on the [umbraco dev group](https://groups.google.com/forum/#!forum/umbraco-dev).


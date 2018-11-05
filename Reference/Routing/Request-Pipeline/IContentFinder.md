# IContentFinder

If you want to create your own content finder implement the IContentFinder interface:

	public interface IContentFinder
	{
	  bool TryFindContent(PublishedContentRequest contentRequest);
	}
	
    // Some are registered by default
	// But feel free to use your owns
	public class ContentFinderResolver
	{ … }

Umbraco runs all content finders, stops at the first one that returns true.
Finder can set content, template, redirect…

### Example 

    public class MyContentFinder : IContentFinder
    {
      public bool TryFindContent(PublishedContentRequest contentRequest)
      {
        var path = contentRequest.Uri.GetAbsolutePathDecoded();
        if (!path.StartsWith("/woot"))
        return false; // not found

        // have we got a node with ID 1234?
        var contentCache = contentRequest.RoutingContext.UmbracoContext.ContentCache;
        var content = contentCache.GetById(1234);
        if (content == null) return false; // not found

        // render that node
        contentRequest.PublishedContent = content;
        return true;
      }
    }

### Example Default content finder

    public class ContentFinderByNiceUrl : IContentFinder
    {
      public virtual bool TryFindContent(PublishedContentRequest contentRequest)
      {
        string path = contentRequest.HasDomain
          // eg. 5678/path/to/node
          ? contentRequest.Domain.RootNodeId.ToString() + …
          // eg. /path/to/node
          : contentRequest.Uri.GetAbsolutePathDecoded();
      
        var node = FindContent(contentRequest, path);
        return node != null;
      }
    }

Default finder will look for content under the domain root.
This is an un-breaking change.

### Example wire up

this example shows how to add custom content finder to (and how to remove ContentFinderByNiceUrl from) the ContentFinderResolver.

    public class MyApplication : ApplicationEventHandler
    {
      protected override void ApplicationStarting(…) 
      {
        // Insert my finder before ContentFinderByNiceUrl
        ContentFinderResolver.Current
          .InsertTypeBefore<ContentFinderByNiceUrl, MyContentFinder>();

        // Remove ContentFinderByNiceUrl
        ContentFinderResolver.Current.RemoveType<ContentFinderByNiceUrl>();
      }
    }

# NotFoundHandlers

To set your own 404 finder create an IContentFinder and set it as the ContentLastChanceFinder.
A ContentLastChanceFinder will always return a 404 status code. This example creates a new implementation of the IContentFinder and checks whether the requested content could not be found by using the default `Is404` property presented in the `PublishedContentRequest` class.

    public class My404ContentFinder : IContentFinder {
    	public bool TryFindContent(PublishedContentRequest contentRequest) {
            // logic to find your 404 page and set it to contentRequest.PublishedContent
	     CultureInfo culture = null;
            if (contentRequest.HasDomain) {
                culture = CultureInfo.GetCultureInfo(contentRequest.UmbracoDomain.LanguageIsoCode);
            }

            // replace 'home_doctype_alias' with the alias of your homepage
            IPublishedContent rootNode = contentRequest.RoutingContext.UmbracoContext.ContentCache.GetByXPath("root/home_doctype_alias").FirstOrDefault(n => n.GetCulture().ThreeLetterWindowsLanguageName == culture.ThreeLetterWindowsLanguageName);
            // replace '404_doctype_alias' with the alias of your 404 page
            IPublishedContent notFoundNode = contentRequest.RoutingContext.UmbracoContext.ContentCache.GetByXPath(String.Format("root/homeDocType[id={0}]/404_doctype_alias", rootNode.Id)).FirstOrDefault(n => n.GetCulture().ThreeLetterWindowsLanguageName == culture.ThreeLetterWindowsLanguageName);

            if (notFoundNode != null) {
                contentRequest.PublishedContent = notFoundNode;
            } else if (rootNode != null) {
                contentRequest.PublishedContent = rootNode;
            } else {
                contentRequest.PublishedContent = contentRequest.RoutingContext.UmbracoContext.ContentCache.GetAtRoot().FirstOrDefault(n => n.GetTemplateAlias() != "");
            }

            return contentRequest.PublishedContent != null;
	    }
    }
    
Example on how to register your own implementation:

    ContentLastChanceFinderResolver.Current.SetFinder(new My404ContentFinder());

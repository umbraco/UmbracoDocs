# Tutorial - Creating a Search Engine XML Site Map

## Overview

Adding an XML sitemap to your site makes it easier for search engine's such as Google to find and index your site pages. Your friendly SEO consultancy will recommend you have a google site map for 'better SEO'.

There isn't an 'out of the box' XML sitemap generator with Umbraco, this tutorial will show you how to create one - but if you are in a hurry, there are some Umbraco Packages that will quickly do the job for you:

- [Cultiv Search Engine Sitemap](https://our.umbraco.com/packages/website-utilities/cultiv-search-engine-sitemap/)
- [Marcel Digital Umbraco XML Sitemap](https://github.com/marceldigital/Umbraco-XML-Sitemap)

### What does an XML SiteMap look like?

Essentially this is just a list of urls for the content on your site.

See [Sitemaps XML format](https://www.sitemaps.org/protocol.html) for the XML schema the sitemap needs to conform to:

    <?xml version="1.0" encoding="UTF-8"?>
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
       <url>
          <loc>https://www.example.com/</loc>
          <lastmod>2005-01-01</lastmod>
          <changefreq>monthly</changefreq>
          <priority>0.8</priority>
       </url>
    </urlset> 

Each page on your site needs to have it's own <url entry in the list.

### Approach

There are many ways of approaching this task, the best approach will be determined by the size of your site, and your preference for implementing functionality in Umbraco, for simplicity sake we're going to write this code directly in a template, but you may want to use route hijacking to write the code in an MVC controller or XSLT is still a really good fit for this kind of task.

We'll create a new Document Type called 'XmlSiteMap' with corresponding 'XmlSiteMap' template, visiting this page will trigger the rendering of the sitemap.
Create a 'SiteMap' composition, containing a consistent set of 'site map' related properties, and add this to all the document types of the site, that can appear on the sitemap.

The 'sitemap' composition will contain a 'hide from Xml Site Map' checkbox, to give editors the ability to hide a page from the sitemap on a page by page basis, if it doesn't make sense for a particular document type to appear in the sitemap, then instead of requiring editors to have to tick this box on every page of that type, we'll also create on the 'xmlsitemap' document type, a 'blacklisted document types' property, where editors can list document types by alias which should never appear on the sitemap, (or you could probably take a 'whitelist' property in case it is easier to say which types should be included rather than the ones that will be excluded.)

The implementation will start at the homepage of the site and loop through all the children, iterating in turn through the children of the children, etc, checking at each level whether to continue further based on the properties of the page.

## Create the Document Type

XmlSiteMap - Map Icon
MaxSiteMapLevel
DocumentTypeBlackList

with template XmlSiteMap

Allow to be created at the root of the site.

## Create Xml Site Map Composition

A site map entry will allow you to state the relative priority of any particular page in terms of it's importance within your site, where a value of 1.0 is super very important, and 0.1 close to insignificant, you can also state 'how often' the content will change on a particular page, eg weekly, monthly etc, and this will help the search engine know when to return to reindex the updated content.

XmlSiteMapComposition
Search Engine Relative Priority - dropdown - 0.1 through to 1.0
(Relative priority of this page between 0 and 1, where 1 is the most important page on the site and 0 isn't)

Search Engine Change Frequency - dropdown - always, hourly, daily, weekly, monthly, yearly, never
(How often the content of this page changes, for google site map, if left blank will inherit the setting for the section
)
Hide From Xml Sitemap (hideFromXmlSitemap) - checkbox.

Add this composition to all of the document types on your site!

Now editors have the ability to set these values for each page of the site, but again, rather than expect them to set them on every single page, when we check the values of these properties, if they are blank, we'll use the values from the parent or parent's parent nodes, using 'recursion' up the Umbraco Content Tree, enabling the values to be set in one place, on a News Section, to apply to all News Articles.

### Building the template

We'll start by writing out in the template the xml schema for the sitemap and because we don't want our template to inherit any 'master' html layout we'll set the 'layout' to be null.

    @inherits Umbraco.Web.Mvc.UmbracoTemplatePage
    @{Layout = null; Response.ContentType = "text/xml"; }<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">[INSERT SITE MAP CONTENT HERE]</urlset>

Notice how we're not adding any spaces or carriage returns before the <urlset opening declaration, even though it would be easier to read if we did, we want to avoid making the xml invalid.

### Getting a reference to the sitemap starting point

We're going to start at the site homepage, and since our XmlSiteMap page is created underneath this page, we can use the 'Site()' helper to find the starting point for the sitemap as IPublishedContent.

IPublishedContent siteHomePage = Model.Content.Site();

### Rendering a site map entry

We will retrieve each page in the site as ***IPublishedContent***, we're not really concerned with any of the different types of properties a page may have, for the site map, we're only interested in the Url, when it was last modified etc, whether it was hidden, but you could write this with Modelsbuilder too (should this example use modelsbuilder? hmmm) - as we'll be writing out this url markup for an IPublishedContent item in different places as we loop to build the sitemap, let's create a Razor Helper that we can pass the IPublishedContent object to, to be responsible for rendering the markup.

    @helper RenderSiteMapUrlEntry(IPublishedContent node)
        {
            //we're passing 'true' as an additional parameter to GetPropertyValue to read the value from the parent nodes, so this setting could be set 'per section
            var changeFreq = node.GetPropertyValue<string>("searchEngineChangeFrequency", true);
            if (String.IsNullOrEmpty(changeFreq))
            {
                changeFreq = "monthly";
            }
            //with the relative priority, this is a per page setting, so we're not passing true
            var priority = node.GetPropertyValue<string>("searchEngineRelativePriority");
            if (String.IsNullOrEmpty(priority))
            {
                priority = "0.5";
            }
            <url>
                <loc>@EnsureUrlStartsWithDomain(node.UrlWithDomain)</loc>
                <lastmod>@(string.Format("{0:s}+00:00", node.UpdateDate))</lastmod>
                <changefreq>@changeFreq</changefreq>
                <priority>@priority</priority>
            </url>

    }

#### EnsureUrlStartsWithDomain - Razor Function

We'll create a Razor Function to handle ensuring the urls on our sitemap have the correct domain (you aren't meant to have relative urls on a sitemap - citation needed), 

Razor functions exist inside a single @functions block inside your template

    @functions {
        private static string EnsureUrlStartsWithDomain(string url)
        {
            if (url.StartsWith("http")){
                return url;
            }
        else {
            //whatever makes sense for your site here...
            var domainPrefix = string.Format("https://{0}/", HttpContext.Current.Request.ServerVariables["HTTP_HOST"]);
            return domainPrefix + url;
        }}

    }

#### Xml Sitemap for the homepage

So for the homepage we'll now have:

     @inherits Umbraco.Web.Mvc.UmbracoTemplatePage
        @{Layout = null; Response.ContentType = "text/xml";IPublishedContent siteHomePage = Model.Content.Site(); }<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">@RenderSiteMapUrlEntry(siteHomePage)</urlset>

and this will render a sitemap entry for the homepage, which isn't very comprehensive!

[screenshot here]

#### Looping through the rest of the site

So now we need to find the pages created beneath the homepage, and see if they should be added to the sitemap, and then in turn look at the pages beneath those etc, until the entire content tree is traversed.

We can use IPublishedContent's .Children method to return all the pages direct underneath a particular page eg:

    IEnumerable<IPublishedContent> sitePages = siteHomePage.Children();

So it would just be a case of looping through these children, and writing out their sitemap markup, and then in turn looking at their children 'The grandchildren' etc and so on...

    foreach (var page in sitePages){
        @RenderSiteMapUrlEntry(page)
        if (page.Children.Any()){
            var subPages = page.Children();
            foreach (var subPage in subPages){
                @RenderSiteMapUrlEntry(subPage)
                if (subPage.Children.Any()){
                    var subSubPages = subPages.Children();
                    foreach (var subSubPage in subSubPages){
                        //... on forever how do we stop?
                    }
                }
            }
        }
    }

So hopefully you can see the problem here, how deep do we go? how do we handle the repetition forever...

... well we can use recursion - we can create a further razor helper that 'calls itself' [insert inception reference here]...

#### Recursive Helper

If we create a helper called perhaps 'RenderSiteMapUrlEntriesForChildren' that then accepts a 'Parent Page' parameter as the starting point, then we can find the children of this Parent Page, write out their Site Map Entry, and then... call this same method again... from itself - recursion!

    @helper RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage)
    {          
            foreach (var page in parentPage.Children)
            {
                @RenderSiteMapUrlEntry(page)
                if (page.Children.Any()){
                @RenderSiteMapUrlEntriesForChildren(page)
                }               
            }
    }

Now updating our template to call this helper:

    @inherits Umbraco.Web.Mvc.UmbracoTemplatePage
            @{Layout = null; Response.ContentType = "text/xml";IPublishedContent siteHomePage = Model.Content.Site(); }<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">@RenderSiteMapUrlEntry(siteHomePage)@RenderSiteMapUrlEntriesForChildren(siteHomePage)</urlset>

we have a full sitemap rendered for the site!

[Screenshot]

#### Checking if a page should be on the sitemap

This is all very well, but what if some super secret pages shouldn't be on the sitemap, what about the document type blacklist we mentioned earlier, what if we only want to go 3 levels deep?

##### HideFromSiteMap

We added a hideFromXmlSitemap checkbox to hopefully all of our document types, let's update the helper to only return children that haven't got the checkbox set, excluding these pages (and any beneath them) from the sitemap.

    @helper RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage)
    {          
            foreach (var page in parentPage.Children.Where(f=>!f.GetPropertyValue<bool>("hideFromXmlSiteMap"))
            {
                @RenderSiteMapUrlEntry(page)
                if (page.Children.Any(f=>!f.GetPropertyValue<bool>("hideFromXmlSiteMap")){
                @RenderSiteMapUrlEntriesForChildren(page)
                }               
            }
    }

##### Depth

What if we only want the sitemap to go three levels deep?

We added a property on the XmlSiteMap document type called depth... we can read that in our template and pass it to our helper


    int maxSiteMapDepth = Model.Content.HasValue("maxSiteMapDepth") ? Model.Content.GetPropertyValue<int>("maxSiteMapDepth") :  int.MaxValue;

    @helper RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage, int maxSiteMapDepth)
        {          
                foreach (var page in parentPage.Children.Where(f=>!f.GetPropertyValue<bool>("hideFromXmlSiteMap"))
                {
                    @RenderSiteMapUrlEntry(page)
                    if (page.Level < maxSiteMapDepth && page.Children.Any(f=>!f.GetPropertyValue<bool>("hideFromXmlSiteMap")){
                    @RenderSiteMapUrlEntriesForChildren(page, maxSiteMapDepth)
                    }               
                }
        }

##### DocumentType Blacklist

Automatically exclude certain document types regardless of their 'hide from sitemap' setting.

    string blacklistedDocumentTypeList = Model.Content.GetPropertyValue<string>("documentTypeBlackList");
    string[] blackListedDocumentTypes = (!String.IsNullOrEmpty(blacklistedDocumentTypeList)) ? blacklistedDocumentTypeList.split(new char[]{','}, StringSplitOptions.RemoveEmptyEntries) : new string[];

and pass this into our helper

       @helper RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage, int maxSiteMapDepth, string[] documentTypeBlacklist)
            {          
                    foreach (var page in parentPage.Children.Where(f=>!documentTypeBlackList.Contains(f.DocumentTypeAlias) && !f.GetPropertyValue<bool>("hideFromXmlSiteMap"))
                    {
                        @RenderSiteMapUrlEntry(page)
                        if (page.Level < maxSiteMapDepth && page.Children.Any(f=>!f.GetPropertyValue<bool>("hideFromXmlSiteMap")){
                        @RenderSiteMapUrlEntriesForChildren(page, maxSiteMapDepth, documentTypeBlacklist)
                        }               
                    }
            }


### The finished sitemap template

      @inherits Umbraco.Web.Mvc.UmbracoTemplatePage
                @{Layout = null; Response.ContentType = "text/xml";IPublishedContent siteHomePage = Model.Content.Site();int maxSiteMapDepth = Model.Content.HasValue("maxSiteMapDepth") ? Model.Content.GetPropertyValue<int>("maxSiteMapDepth") :  int.MaxValue;string blacklistedDocumentTypeList = Model.Content.GetPropertyValue<string>("documentTypeBlackList"); string[] blackListedDocumentTypes = (!String.IsNullOrEmpty(blacklistedDocumentTypeList)) ? blacklistedDocumentTypeList.split(new char[]{','}, StringSplitOptions.RemoveEmptyEntries) : new string[];}<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">@RenderSiteMapUrlEntry(siteHomePage)@RenderSiteMapUrlEntriesForChildren(siteHomePage,maxSiteMapDepth,blackListedDocumentTypes)</urlset>

     @helper RenderSiteMapUrlEntry(IPublishedContent node)
            {
                //we're passing 'true' as an additional parameter to GetPropertyValue to read the value from the parent nodes, so this setting could be set 'per section
                var changeFreq = node.GetPropertyValue<string>("searchEngineChangeFrequency", true);
                if (String.IsNullOrEmpty(changeFreq))
                {
                    changeFreq = "monthly";
                }
                //with the relative priority, this is a per page setting, so we're not passing true
                var priority = node.GetPropertyValue<string>("searchEngineRelativePriority");
                if (String.IsNullOrEmpty(priority))
                {
                    priority = "0.5";
                }
                <url>
                    <loc>@EnsureUrlStartsWithDomain(node.UrlWithDomain)</loc>
                    <lastmod>@(string.Format("{0:s}+00:00", node.UpdateDate))</lastmod>
                    <changefreq>@changeFreq</changefreq>
                    <priority>@priority</priority>
                </url>

        }

     @helper RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage, int maxSiteMapDepth, string[] documentTypeBlacklist)
            {          
                    foreach (var page in parentPage.Children.Where(f=>!documentTypeBlackList.Contains(f.DocumentTypeAlias) && !f.GetPropertyValue<bool>("hideFromXmlSiteMap"))
                    {
                        @RenderSiteMapUrlEntry(page)
                        if (page.Level < maxSiteMapDepth && page.Children.Any(f=>!f.GetPropertyValue<bool>("hideFromXmlSiteMap")){
                        @RenderSiteMapUrlEntriesForChildren(page, maxSiteMapDepth, documentTypeBlacklist)
                        }               
                    }
            }

       @functions {
            private static string EnsureUrlStartsWithDomain(string url)
            {
                if (url.StartsWith("http")){
                    return url;
                }
            else {
                //whatever makes sense for your site here...
                var domainPrefix = string.Format("https://{0}/", HttpContext.Current.Request.ServerVariables["HTTP_HOST"]);
                return domainPrefix + url;
            }}

        }
#### Add sitemap to robots.txt

Finally let search engines know the url for your sitemap by updating your robots.txt file accordingly:

    Sitemap: https://www.yourlovelysite.com/xmlsitemap
    User-agent: *

Once you introduce a Sitemap for the first time, you might suddenly find yourself being crawled by multiple different search engine bots, which is exactly what you want, however if your site or hosting is a littly creaky, you might want to add a crawl rate to the robots.txt to instruct well behaved search engine bots to give a bit of breathing space to your site in between crawl requests:

    Sitemap: https://www.yourlovelysite.com/xmlsitemap
    User-agent: *
    Crawl-delay: 10



---
description: "A guide to creating an XML sitemap in Umbraco"
---

# Creating an XML Site Map

Adding an XML sitemap to your site makes it easier for search engines such as Google to find and index your websites pages. Having a sitemap will improve the Search Engine Optimization (SEO) for your website.

There is not an XML sitemap generator in Umbraco, which is why this tutorial will show you how to create one.

If you are in a hurry, there are some community packages that will do the job for you:

* [SEO Toll Kit](https://marketplace.umbraco.com/package/seotoolkit.umbraco)

## What does an XML sitemap look like?

An XML sitemap is a list of URLs for the content on your site.

See [Sitemaps XML format](https://www.sitemaps.org/protocol.html) for the XML schema the sitemap needs to conform to.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    <url>
        <loc>https://www.example.com/</loc>
        <lastmod>2005-01-01</lastmod>
        <changefreq>monthly</changefreq>
        <priority>0.8</priority>
    </url>
</urlset>
```

The XML sitemap is a guide for search engines to discover and index your content. Each page on your site that you wish to feature will be represented by a `<url>` entry in the list.

## Approach

There are different ways of approaching this task. The best approach will be determined by the size of your site, and your preference for implementing functionality in Umbraco.

In this tutorial we are going to write the code directly in a Template using Razor and `IPublishedContent`. You may want to take a different approach, like using route hijacking to write the code in an MVC controller.

The following will be covered in this tutorial:

* We'll create a new Document Type called 'XmlSiteMap' with a corresponding 'XmlSiteMap' Template. Visiting page based on this Document Type will trigger the rendering of the XML sitemap.
  * The XmlSiteMap Document Type will contain an 'Excluded Document Types' property to list types of content we wish to exclude from the sitemap. Alternatively, you could create an 'Included Document Types' to specify types that should be included rather than excluded.
* We'll create a 'SiteMap' composition, containing a consistent set of sitemap related properties. This composition will be added to all of the different Document Types in the site.
  * The 'SiteMap' composition will contain a 'hide from Xml Site Map' checkbox, to give editors the ability to hide a certain page from the XML Sitemap.

## 1. Create an XmlSiteMap Document Type

![View of the properties defined on the finished XmlSiteMap Document Type](images/v8/create-sitemap-doctype.png "View of the properties defined on the finished XmlSiteMap Document Type")

1. Navigate to the **Settings** section in the Umbraco backoffice.
2. Create a new "Document Type with Template".
3. Name the new Document Type **XmlSiteMap**.
4. Add a TextString property called "Excluded Document Types" (alias: `excludedDocumentType`).
5. Save the XmlSiteMap Document Type.
6. Open the Document Type used in the root of your website.
7. Select the "Permissions" tab and add the new XmlSiteMap under "Allowed child node types".
8. Navigate to the **Content** section and create a new XmlSiteMap page in your content tree.
9. Use the alias to add the XmlSiteMap Document Type to the "Excluded Document Type" list: `xmlSiteMap`.

![View of the Content Tree after a Sitemap page has been added.](images/v8/create-sitemap-page.png "View of the Content Tree after a Sitemap page has been added.")

## 2. Create an XmlSiteMapSettings Composition

A sitemap entry will allow you to state the relative priority of any particular page in terms of its importance within your site. A value of 1.0 is the highest level of importance where 0.1 is at the other end of the scale. 

You can add a change frequence to define how often the content on a particular page is expected to change. This will help the search engine know when to return to reindex any regularly updated content.

Create the XmlSiteMapSettings composition (Document Type Without Template) with name: **XmlSiteMapSettings**

* **Search Engine Relative Priority** - Slider - MinValue: 0.1, MaxValue: 1, Step Increments 0.1, InitialValue 0.5 (Relative priority of this page between 0.1 and 1.0, where 1.0 is the most important page on the site and 0.1 isn't)
* **Search Engine Change Frequency** - Dropdown - always, hourly, daily, weekly, monthly, yearly, never (How often the content of this page changes, for google site map, if left blank will inherit the setting for the section)
* **Hide From Xml Sitemap** (hideFromXmlSitemap) - checkbox.

At this point your composition should look similar to this:&#x20;

<figure><img src="images/v8/create-sitemap-settings-composition.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Using pink for composition icons make them easier to spot in the list when you are curating your Document Types.
{% endhint %}

Add this composition to all of the document types on your site!&#x20;

<figure><img src="images/v8/create-sitemap-add-composition.png" alt=""><figcaption></figcaption></figure>

Now editors have the ability to set these values for each page of the site. Rather than expect them to set them on every single page, we'll use the values from the parent or parent's parent nodes, using 'recursion' up the Umbraco Content Tree. This enables the values to be set in one place for a particular section, eg. setting once on a News Section, would then apply to all News Articles.

### 3. Building the XmlSiteMap.cshtml template

We'll start by writing out in the template the xml schema for the sitemap and because we don't want our template to inherit any 'master' html layout we'll set the 'layout' to be null.

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@{
    Layout = null; 
    Context.Response.ContentType = "text/xml";
 }
 
 <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">[INSERT SITE MAP CONTENT HERE]</urlset>
```

### Getting a reference to the sitemap starting point

We're going to start at the site homepage, and since our XmlSiteMap page is created underneath this page, we can use the 'Site()' helper to find the starting point for the sitemap as IPublishedContent.

`IPublishedContent siteHomePage = Model.Root();`

### Rendering a site map entry

We will retrieve each page in the site as **IPublishedContent**, and read in the SearchEngineChangeFrequency(recursively), SearchEngineRelativePriority, Url, when it was last modified etc...

You can include HTML markup in the body of a method declared in a code block. This is a great way to organise your razor view implementation, to stop yourself repeating code and html in multiple places. Here we will have one place to write out the logic for our Url entry:

```csharp
@{
    void RenderSiteMapUrlEntry(IPublishedContent node)
    {
        var changeFreq = node.Value("searchEngineChangeFrequency", fallback: Fallback.To(Fallback.Ancestors, Fallback.DefaultValue), defaultValue: "monthly");
        // with the relative priority, this is a per page setting only, so we're not using recursion, so we won't set Fallback.ToAncestors here and we'll default to 0.5 if no value is set
        var priority = node.HasValue("searchEngineRelativePriority") ? node.Value<string>("searchEngineRelativePriority") : "0.5";

        <url>
            <loc>@node.Url(mode: UrlMode.Absolute)</loc>
            <lastmod>@(string.Format("{0:s}+00:00", node.UpdateDate))</lastmod>
            <changefreq>@changeFreq</changefreq>
            <priority>@priority</priority>
        </url>

    }

}
```

{% hint style="info" %}
We're using `IPublishedContent` in this example but if you prefer to use **ModelsBuilder** you could take advantage of the fact that the XMl Sitemap Settings composition will create an interface called `IXmlSiteMapSettings`. This will allow you to adjust the helper to accept this 'type' eg `RenderSiteMapUrlEntry(IXmlSiteMapSettings node)` and allow you to read the properties without the `Value` helper, eg `node.SearchEngineRelativePriority`. You would still need to create an extension method on `IXmlSiteMapSettings` to implement the recursive functionality we make use of on the `SearchEngineChangeFrequency` property.
{% endhint %}

#### Xml Sitemap for the homepage

So for the homepage we'll now have:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@{
    Layout = null; 
    Context.Response.ContentType = "text/xml";
    IPublishedContent siteHomePage = Model.Root(); 
}
    
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
@{
    RenderSiteMapUrlEntry(siteHomePage)
}
</urlset>
```

visit the url of your sitemap page (http://yoursite.com/sitemap) and this will render a single sitemap entry for the homepage, which ermmmm, isn't very comprehensive!

![Example of Sitemap](images/sitemap.png)

#### Looping through the rest of the site

So now we need to find the pages created beneath the homepage, and see if they should be added to the sitemap, and then in turn look at the pages beneath those etc, until the entire content tree is traversed.

We can use **IPublishedContent**'s _.Children_ method to return all the pages directly beneath a particular page eg:

```
IEnumerable<IPublishedContent> sitePages = siteHomePage.Children();
```

So we need to loop through each of these 'child' pages, and write out their sitemap markup using our helper, and then in turn loop through their children (grandchildren?) etc and so on... (great-great-grandchildren...)

```csharp
foreach (var page in sitePages){
    @RenderSiteMapUrlEntry(page)
    if (page.Children.Any()){
        var childPages = page.Children();
        foreach (var childPage in childPages){
            @RenderSiteMapUrlEntry(childPage)
            if (childPage.Children.Any()){
                var grandChildPages = childPage.Children();
                foreach (var grandChildPage in grandChildPages){
                    // ... on forever how do we stop?
                }
            }
        }
    }
}
```

So hopefully you can see the problem here, how deep do we go? How do we handle the repetition forever...

... well we can use recursion - we can create a further razor helper that 'calls itself' \[insert inception reference here]...

#### Recursive Helper

If we create a helper called `RenderSiteMapUrlEntriesForChildren` that accepts a 'Parent Page' parameter as the starting point. Then we can find the children of this Parent Page, write out their Site Map Entry, and then call this same method again from itself - recursion!

```csharp
@{
    void RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage)
    {
        foreach (var page in parentPage.Children)
        {
            RenderSiteMapUrlEntry(page);
            if (page.Children.Any()){
                RenderSiteMapUrlEntriesForChildren(page);
            }
        }
    }
}
```

Let's update our template to call this recursive helper:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@{
    Layout = null;
    Response.ContentType = "text/xml";
    IPublishedContent siteHomePage = Model.Root();
    }
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
    @{
        RenderSiteMapUrlEntry(siteHomePage);
        RenderSiteMapUrlEntriesForChildren(siteHomePage);
    }
</urlset>
```

and we should have a full XML sitemap rendered for the site!

![Example of Sitemap with children](images/sitemapWithChildren.png)

#### Checking if a page should be on the sitemap

This is all very well, but what if some super secret pages shouldn't be on the sitemap? and what about the document type excluded list we mentioned earlier? and what if we only want to go 3 levels deep?

**HideFromSiteMap**

We added a `hideFromXmlSitemap` checkbox to all of our document types via our `XmlSiteMapSettings` composition. Let's update the helper to only return children that haven't got the checkbox set, excluding these pages (and any beneath them) from the sitemap.

```csharp
void RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage)
{
    foreach (var page in parentPage.Children.Where(x =>!x.Value<bool>("hideFromXmlSiteMap")))
    {
        @RenderSiteMapUrlEntry(page)
        if (page.Children.Any(x =>!x.Value<bool>("hideFromXmlSiteMap"))){
            @RenderSiteMapUrlEntriesForChildren(page)
        }
    }
}
```

Now revisit a page in the content tree, and tick the Hide from SiteMap option, if all has gone well, it will disappear from the XmlSitemap page!

**Depth**

What if we only want to restrict 'how deep' the sitemap should go?

If we add to our XmlSiteMap document type a new property of numeric type called 'maxSiteMapDepth'... we can use that value to determine when to stop iterating:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@{
    Layout = null;
    Response.ContentType = "text/xml"; 
    IPublishedContent siteHomePage = Model.Root();
    int maxSiteMapDepth = Model.HasValue("maxSiteMapDepth") ? Model.Value<int>("maxSiteMapDepth") : int.MaxValue; 
}
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">@RenderSiteMapUrlEntry(siteHomePage)@RenderSiteMapUrlEntriesForChildren(siteHomePage, maxSiteMapDepth)</urlset>

.....

void RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage)
{
    foreach (var page in parentPage.Children.Where(f=>!f.Value<bool>("hideFromXmlSiteMap")))
    {
        @RenderSiteMapUrlEntry(page)
        if (page.Level < maxSiteMapDepth && page.Children.Any(f=>!f.Value<bool>("hideFromXmlSiteMap"))){
            @RenderSiteMapUrlEntriesForChildren(page, maxSiteMapDepth)
        }
    }
}
```

Set your `MaxSiteMap` depth to be 2 on your XmlSiteMap content item, and save and republish. Your sitemap will now only contain entries for the top two levels. Leaving the value blank, will mean that no Maximum Depth restriction will be applied.

**Excluded DocumentType list**

Our Xml Sitemap includes an entry for itself on the XML Sitemap, I thought we had excluded that document type, when we created the excludedDocumentType property...

... we did but we haven't checked this value in the helper yet.

```csharp
string excludedDocumentTypeList = Model.Value<string>("excludedDocumentTypes");
string[] excludedDocumentTypes = (!String.IsNullOrEmpty(excludedDocumentTypeList)) ? excludedDocumentTypeList.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(p => p.Trim()).ToArray() : new string[] { };
```

now we can pass this value into our helper

```csharp
void RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage)
{
    foreach (var page in parentPage.Children.Where(f => !excludedDocumentTypes.Contains(f.ContentType.Alias) && !f.Value<bool>("hideFromXmlSiteMap")))
    {
        @RenderSiteMapUrlEntry(page)
        if (page.Level < maxSiteMapDepth && page.Children.Any(f => !excludedDocumentTypes.Contains(f.ContentType.Alias) && !f.Value<bool>("hideFromXmlSiteMap")))
        {
            @RenderSiteMapUrlEntriesForChildren(page, maxSiteMapDepth, excludedDocumentTypes)
        }
    }

}
```

### The finished sitemap template

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage

@{
    Layout = null;
    var siteHomePage = Model.Root();
    Context.Response.ContentType = "text/xml";
    int maxSiteMapDepth = Model.HasValue("maxSiteMapDepth") ? Model.Value<int>("maxSiteMapDepth") : int.MaxValue;

    string excludedDocumentTypeList = Model.Value<string>("excludedDocumentTypes");
    string[] excludedDocumentTypes = (!String.IsNullOrEmpty(excludedDocumentTypeList)) ? excludedDocumentTypeList.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(p => p.Trim()).ToArray() : new string[] { };
}



<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemalocation="http://www.google.com/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
    
    @{
        RenderSiteMapUrlEntry(siteHomePage);
        RenderSiteMapUrlEntriesForChildren(siteHomePage);
    }
    

</urlset>


@{
    void RenderSiteMapUrlEntry(IPublishedContent node)
    {
        var changeFreq = node.Value("searchEngineChangeFrequency", fallback: Fallback.To(Fallback.Ancestors, Fallback.DefaultValue), defaultValue: "monthly");
        // with the relative priority, this is a per page setting only, so we're not using recursion, so we won't set Fallback.ToAncestors here and we'll default to 0.5 if no value is set
        var priority = node.HasValue("searchEngineRelativePriority") ? node.Value<string>("searchEngineRelativePriority") : "0.5";

        <url>
            <loc>@node.Url(mode: UrlMode.Absolute)</loc>
            <lastmod>@(string.Format("{0:s}+00:00", node.UpdateDate))</lastmod>
            <changefreq>@changeFreq</changefreq>
            <priority>@priority</priority>
        </url>

    }

    void RenderSiteMapUrlEntriesForChildren(IPublishedContent parentPage)
    {
        foreach (var page in parentPage.Children.Where(x => !excludedDocumentTypes.Contains(x.ContentType.Alias) && !x.Value<bool>("hideFromXmlSiteMap")))
        {
            RenderSiteMapUrlEntry(page);
            if (page.Level < maxSiteMapDepth && page.Children.Any(x => !x.Value<bool>("hideFromXmlSiteMap")))
            {
                RenderSiteMapUrlEntriesForChildren(page);
            }
        }

    }

}
```

#### Add sitemap to robots.txt

Finally let search engines know the url for your sitemap by updating your robots.txt file accordingly:

```
Sitemap: https://www.yourlovelysite.com/xmlsitemap
User-agent: *
```

Once you introduce a Sitemap for the first time, you might suddenly find yourself being crawled by multiple different search engine bots. This is exactly what you want! However if your site or hosting is a little creaky, you might want to add a crawl rate to the robots.txt to instruct well behaved search engine bots to give a bit of space to your site between requests:

```
Sitemap: https://www.yourlovelysite.com/xmlsitemap
User-agent: *
Crawl-delay: 10
```

#### Test your Xml SiteMap in a validation tool

Visit [Xml-Sitemaps.com](https://www.xml-sitemaps.com/validate-xml-sitemap.html) to test the validity of your generated Xml Site Map.

#### Summary

This is one way to add an XML Sitemap to your site, depending on your site it might not always be the 'best way' eg it will be much faster using XSLT. Particularly for large sites.

This tutorial aims to serve as an introduction to Razor, Helpers, Functions, IPublishedContent, and working with the Umbraco Content Tree. It is not trying to establish the 'only best practice' way to achieve an Xml SiteMap.

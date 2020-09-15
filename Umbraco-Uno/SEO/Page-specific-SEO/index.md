---
versionFrom: 8.0.0
---

# SEO for specific pages

Besides the [sitewide SEO settings](../General-SEO) you also have an SEO section on each of your content pages.

These settings are specific to each of the pages, and we highly recommend that you carefully fill out each of the fields in order get the best SEO score for your Umbraco Uno website.

In this article you will find a guide on how to find and setup the page specific SEO settings that are available.  You will also find a complete and detailed list about each of the fields, how to fill them in and where on your website each of them are used.

## How to setup SEO for your pages

To access the SEO section of a content page, you have to navigate to the page. We will use the default **Accommodatio** page as an example in this guide:

1. Go to one of your pages, for this guide we will use ***Accommodation***
2. When you are there scroll until you reach the SEO section

    ![SEO section on a page](images/Seo-section-on-a-page.png)

3. Now you are presented with a list of SEO settings specific for this page that you can fill out. Fill out all relevant fields with information for your project.

4. Finalize by clicking “Save”

## Page specific SEO settings explained

### Title

This field is used to define the title of a page.

For Google to properly display it in the search results **it should be kept below 50-60 characters**. If it is too long Google will only display the first part of it and truncate the rest, which could lead to some unwanted results.

Title is added as the `<title>` element for your page, which is used by search engines as the title tag in the search engine results pages (SERP).

Title is also added as the value to the Open Graph property `OG:title`, which is used by social media sites like Facebook and LinkedIn when the content is shared on their platforms.

Finally, Title is added as the value to the Twitter property `twitter:title`, which is used by Twitter when the content is shared on their platform.

### Description

This field is used to give a short description of the page.

For Google to properly display it in the search results **it should be kept below 155 characters**. If it is too long Google will only display the first part of it and truncate the rest, which could lead to some unwanted results.

Description is added as the meta description for your page, which is used by search engines as the short description in the search engine results pages (SERP).

Description is also added as the value to the Open Graph property `OG:description`, which is used by social media sites like Facebook and LinkedIn when the content is shared on their platforms.

Finally, Description is added as the value to the Twitter property `twitter:description`, which is used by Twitter when the content is shared on their platform.

### Image

This field is used to add a descriptive image for the page. The image is used by social media platforms when your content is shared.

Image is added as the value to the Open Graph property `og:image`, which is used by social media sites like Facebook and LinkedIn when the content is shared on their platforms.

Image is also added as the value to the Twitter property `twitter:image`, which is used by Twitter when the content is shared on their platform.

### Hide in Sitemap

A sitemap is automatically generated for your website and is used by search engine crawlers to crawl and index your website.

If you do not want to have this specific page in the sitemap you can set **Hide In Sitemap** to true/on. If this setting is toggled the page will be hidden in the sitemap. You can see your sitemap at `domain.com/sitemap`.

### Sitemap Page Priority

Sitemap Page Priority is added as the value for the sitemap property `<priority>`.

1 is highest priority and 0 is lowest priority. Priority is used by search engine crawlers as an indication for which pages you want them to prioritize when they crawl your website.

### Sitemap Page Change Frequently

Sitemap Page Change Frequently is added as the value for the sitemap property `<changefreq>`. This is used by search engine crawlers as an indication for which pages you want them to crawl more often than others.

### Noindex / Nofollow

The Noindex / Nofollow dropdown is used to set `<meta name=”robots”>` for the page.

The values for this setting consists of to seperate values, index/noindex and follow/nofollow.

The first input is index/noindex. This is used to tell search engine crawlers whether or not your page should be added to the search index. If a page is added to the search index it is eligible to show up in the search results.

The second input is follow/nofollow. This is used to tell search engine crawlers whether or not they should follow all links present on your page. If you want to set follow/nofollow on individual links, you can do so by adding it as a link attribute on the specific links instead of using this setting.

Consult the table below, to learn more about what each of the options in the dropdown will do for your page.

|Value                 |Description     |
|----------------------|----------------|
|Blank                 |Search engines will treat it as if it was set to “index, follow”. Your page will be added to the search index and links on the page will be followed when they crawl the page.|
|**index, follow**     |Your page will be added to the search index. Links on the page will be followed when the page is crawled.|
|**noindex, follow**   |Your page will not be added to the search index. Links on the page will be followed when the page is crawled.|
|**noindex, nofollow** |Your page will not be added to the search index. Links on the page will not be followed when the page is crawled.|
|**index, nofollow**   |Your page will be added to the search index. Links on the page will not be followed when the page is crawled.|

### Canonical Url

This field is used to set `<link rel=”canonical”>` for the page.

This is used for pages that are full or close copies of a different page on your website. If two pages have identical content it can cause duplicate content issues for your website. To avoid these you can use this setting to pick the original version of the page.

This does not stop search engine crawlers from crawling your content. Instead it tells them that this page is not the original and that they should instead show the original page in the search results.

### Custom URL

:::note
This field is not found in the “SEO” section, but is instead found in the “Settings” below.
:::

This field is used to set a custom URL for the page. When this is not set the URL of a page is determined by the name of the page. If the URL is a child of another page it will always keep the page path.

## Post specific SEO settings explained

Blog posts are slightly different than normal content pages. They have different fields and also have an additional section called "Meta" that is relevant for SEO. Below we’ll go through the different fields that have an impact on SEO.
​
### Page name

The name of the blog post is used in the backoffice blog post overview and is also used to generate the URL.
​
Page name is also added as the “name” property in the schema markup type “WebPage” that is added to the blog post.
​
### Heading

This field is used as the headline for your blog post and is shown on the blog post itself and on the blog overview page.
​
Heading is also added as the “headline” property in the schema markup type “BlogPosting” that is added to the blog post.
​
### Image (in the "Content" section)

The image you upload here is used as the top image shown on the blog post page.
​
Image is also added as the “url” property for "image" in the schema markup type “BlogPosting” that is added to the blog post.
​
### Date

The date is used to show the publishing date on the blog overview page and on the blog post itself. It is also used to sort the blog posts on the blog overview page (most recent blog posts are shown first).
​
Date is also added as the “datePublished” property in the schema markup type “BlogPosting” that is added to the blog post.
​
### Description (in the "Meta" section)

This description is shown when listing the blog post on the blog post overview page.
​
Description is also added as the “description” property in the schema markup type “BlogPosting” that is added to the blog post.
​
### Author

This field is added as the “author” property in the schema markup type “BlogPosting” that is added to the blog post.

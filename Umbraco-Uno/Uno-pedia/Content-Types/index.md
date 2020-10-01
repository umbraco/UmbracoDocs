---
versionFrom: 8.0.0
---

# Content Types

Umbraco Uno ships with a total of 11 Content Types. 5 of these you will set up and expand on as you build your website. 4 of them are pages concerning settings or other basic website functionality, 1 acts as a folder and the final Content Type is used for the search functionality on the website.

In this section you can learn more about the available Content Types in the Starter Kit, where to find them and the recommended way of using them.

## [Site (Start)](Site-Start)

The Site content type is the frontpage of your website, and is built using widgets. Site contains a lot of configuration options that will apply to the entire website, such as customizable options for the Navigation, Header and Footer of the website.

[Learn more about how to configure the frontpage on your website.](Site-Start)

## [Page](Page)

The Page content type is the default type for creating landingpages.

## [Feed](Feed)

The Feed content type provides you with an option to setup a feed on your website. This could be a blog or a section section. Once you've setup a feed page you can start adding posts/articles into the feed.

[More about how to setup a feed.](Feed)

## [Global Content](Global-Content)

The Global Content feature provides you with an option to create smaller parts of content that can be used on multiple pages.

This could be used for a sign-up form that you would like to show on various pages on your website. Instead of creating it again and again, you can create it as *Global Content*, and then use the *Global Content Widget* to pull it in where you need it.

[Learn more about the possibilites with Global Content.](Global-Content)

## Search

The Search page will be part of the starter content / default content, and is used for displayed search results when the search functionality on the frontend is used.

It is possible to add widgets to the Search page. These will be displayed under the search results.

It's possible to [configure SEO](../Settings/Specific-Settings/#seo) for the Search page, as well as a set of [page specific settings](../Settings/Specific-Settings/#settings).

## Sitemap

The Sitemap content type can only be added a subpage under the root page in the Content tree. An item based on this content type is part of the starter/default content, which means it will rarely be necessary to create a new instance of this.

A sitemap is primarily used to further the SEO of websites. It will contain a list of all content and media items on the websites, while also giving search engines details about what type of content each item contains and the relation between them.

All content added to the website will by default be added to the sitemap as well. This can be configured for each individual content item, by using three options in the SEO group: *Hide in Sitemap*, *Sitemap Page Priority* and *Sitemap Page Change Frequently*.

A sitemap content item will be excluded from the default navigation menu.

## Settings

When building an Umbraco Uno website the Settings content type and subpages are essential. This is where you configure your website, connect mailservices and social media and decide on both general and specific options for the theme of the website.

### [General settings](../Settings/General-Settings)

These are usually settings that has an effect on the entire site, and include things like connecting your SMTP service, setting up tracking for Google and managing the cookie consent.

You can manage the general settings for your website on the *General* content node, which you can find as a child node to *Settings*.

### [Theme settings](../Settings/Theme-settings)

As the name indicates, theme settings is where you go to manage the theme of your website. This includes matching the colors and logos to your company identity and defining various sizes and spaces around the website.

You can manage the theme settings for your website on the *Theme* content node, which you can find as a child node to *Settings*.

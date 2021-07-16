---
versionFrom: 8.0.0
---

# Settings

When building a website using the Umbraco Uno there are multiple settings and configuration options that you need to consider. This includes choosing the correct colors, connecting your Google Analytics account and defining content for the footer of the website.

This section contains everything you need to know, in order to configure the website to suite your needs and/or requirements.

There are **four primary areas** you need to know about, when setting up and configuring your website. These are:

1. General settings
2. Theme settings
3. SEO settings
4. Page specific settings

## [General settings](General-Settings)

These are usually settings that has an effect on the entire site, and include things like setting up tracking for Google and managing the cookie consent.

You can manage the general settings for your website on the *General* page, which you can find as a child page to *Settings*.

## [Theme settings](Theme-settings)

As the name indicates, theme settings is where you go to manage the theme of your website. This includes matching the colors and logos to your company identity and defining various sizes and spaces around the website.

You can manage the theme settings for your website on the *Theme* page, which you can find as a child page to *Settings*.

## [SEO settings](SEO-Settings)

In order for your website to perform well in search results, Umbraco Uno ships with a set of configuration SEO settings that we highly recommend using.

Most SEO settings are managed from the *SEO* page, which you can find as a child page to *Settings*.

## [Page specific settings](Specific-Settings)

On each content item you create in the content section, you will have a set of settings and configuration options specific to the content type the item is based on. These are split up into groups and includes settings related to SEO and options for the navigation bar.

## Manual Redirects

When you rename a page on your website or move a page below another page, Umbraco Uno will automatically create a redirect based on the change. This means, than if your visitors use the old path to an article that was moved, they will still be showed the correct content.

It is possible to create custom redirects as well, by adding the *Manual Redirects* page as a child page to *Settings*. Once this has been setup, redirects are created as items from the *Manual Redirects* page.

Learn more about how to configure and work with manual redirects in the [Manual Redirects settings](../../SEO/Manual-redirect-settings-in-uno/index.md) article.

## Forms

When you are working with Umbraco Forms in your Umbraco Uno project, you might want to use *Google Recatpcha* which is a field you can add to your forms.

In order for the Recaptcha field to work properly, you will need to configure a key. Learn more about how this works and how to set it up in the [Creating Content](../../Creating-Content/#working-with-forms) article.

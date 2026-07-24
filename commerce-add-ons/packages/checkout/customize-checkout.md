---
description: This documentation shows how to customize the Checkout package for Umbraco Commerce.
---

# Customize Checkout

It is assumed that you already have an Umbraco website configured Umbraco Commerce installed and a store set up. If you are not at this stage yet, read the [core Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/) to learn how to get started.

Umbraco Commerce Checkout is a free and open-source add-on package for Umbraco Commerce. It is possible to amend the default behavior to customize the checkout to your needs.

## Setup

To allow customization you must first 'override' the existing files for the step required to be modified.

To do this follow these steps:

1. Copy the equivalent [files and partials](https://github.com/umbraco/Umbraco.Commerce.Checkout/tree/main/src/Umbraco.Commerce.Checkout/Views/UmbracoCommerceCheckout).
2. Add them to `Views/UmbracoCommerceCheckout` in your project directory. It might be necessary to create the folder first.
3. Make a small text change to one of the Views to verify that the files are in use.
4. Rebuild and restart your site, then verify that the changes are carried out and displayed correctly.

The Checkout package ships its Views precompiled. When you add a matching View to your project's `Views/UmbracoCommerceCheckout` folder, your copy takes precedence over the packaged one, letting you override a single step without having to redefine them all.

{% hint style="info" %}
**Umbraco 17 and later (including Umbraco 18): view changes require a rebuild**

From Umbraco CMS 17 onwards, Razor runtime compilation is no longer enabled by default. It has been removed from the CMS core and moved to the optional [`Umbraco.Cms.DevelopmentMode.Backoffice`](https://docs.umbraco.com/umbraco-cms/reference/configuration/runtimesettings) package.

Overriding Views still works, but your overrides are compiled into the site at **build time**. After adding or editing a View, you must **rebuild and restart** the site for the changes to appear - editing a `.cshtml` file and only refreshing the browser will have no effect.

To restore the previous behavior, where View changes are picked up without a rebuild during local development, add the `Umbraco.Cms.DevelopmentMode.Backoffice` package to your project. For background, see the [Umbraco CMS version-specific upgrade notes](https://docs.umbraco.com/umbraco-cms/get-started/upgrading-and-migrating/version-specific).
{% endhint %}

You are now ready to start customizing the Checkout page to fit the design of your website.

## Useful links

Here are a few useful links to learn more about the Umbraco Commerce Checkout package:

* [Umbraco Commerce Checkout source code](https://github.com/umbraco/Umbraco.Commerce.Checkout)
* [Umbraco Commerce Checkout issue tracker](https://github.com/umbraco/Umbraco.Commerce.Checkout/issues)

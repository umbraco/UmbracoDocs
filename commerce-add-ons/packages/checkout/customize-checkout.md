---
description: This documentation shows how to customize the Checkout package for Umbraco Commerce.
---

# Customize Checkout

It is assumed that you already have an Umbraco website configured Umbraco Commerce installed and a store set up. If you are not at this stage yet, read the [core Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/) to learn how to get started.

Umbraco Commerce Checkout is a free and open-source add-on package for Umbraco Commerce. It is possible to amend the default behavior to customize the checkout to your needs.

## How overriding works

The Checkout package ships its Views **precompiled** into the package assembly. To change a View, you provide your own copy at the same path (`Views/UmbracoCommerceCheckout/...`). When your site **compiles that View at build time**, your copy takes precedence over the packaged one, letting you override a single step without redefining them all.

{% hint style="warning" %}
**Umbraco 17 and later: your site must compile Views at build time**

New Umbraco projects use the `InMemoryAuto` Models Builder mode, which sets the following in the project's `.csproj`:

```xml
<RazorCompileOnBuild>false</RazorCompileOnBuild>
<RazorCompileOnPublish>false</RazorCompileOnPublish>
```

With these settings, Views you add under `Views/UmbracoCommerceCheckout` are **not compiled**, so the packaged (precompiled) Views keep being used and your changes never appear - even after a rebuild.

Razor **runtime compilation** does *not* help here: it does not override a package's precompiled Views, so installing `Umbraco.Cms.DevelopmentMode.Backoffice` will not make file-based overrides take effect either.

To use file-based overrides, your site must compile Views at build time:

1. Switch Models Builder to a source-code mode (for example `SourceCodeAuto` or `SourceCodeManual`) - see [Models Builder settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/modelsbuildersettings).
2. Remove `<RazorCompileOnBuild>false</RazorCompileOnBuild>` and `<RazorCompileOnPublish>false</RazorCompileOnPublish>` from your `.csproj` (or set them to `true`).
3. Rebuild the site.

For background on why runtime compilation was removed from the core in Umbraco 17, see the [Umbraco CMS version-specific upgrade notes](https://docs.umbraco.com/umbraco-cms/get-started/upgrading-and-migrating/version-specific).
{% endhint %}

## Setup

Once your site is configured to compile Views at build time (see the note above), follow these steps:

1. Copy the equivalent [files and partials](https://github.com/umbraco/Umbraco.Commerce.Checkout/tree/main/src/Umbraco.Commerce.Checkout/Views/UmbracoCommerceCheckout).
2. Add them to `Views/UmbracoCommerceCheckout` in your project directory. It might be necessary to create the folder first.
3. Make a small text change to one of the Views.
4. Rebuild and restart your site, then verify that the change is displayed correctly.

You are now ready to start customizing the Checkout page to fit the design of your website.

## Alternative: use a Template

If you would rather not change your build-time compilation settings, you can assign a **Template** to the checkout page in the backoffice and place your markup there. When a checkout page has a Template assigned, Checkout renders that Template instead of its built-in View. Templates are edited through the backoffice and do not depend on overriding the packaged Views.

## Useful links

Here are a few useful links to learn more about the Umbraco Commerce Checkout package:

* [Umbraco Commerce Checkout source code](https://github.com/umbraco/Umbraco.Commerce.Checkout)
* [Umbraco Commerce Checkout issue tracker](https://github.com/umbraco/Umbraco.Commerce.Checkout/issues)

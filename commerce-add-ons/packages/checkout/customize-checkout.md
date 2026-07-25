---
description: This documentation shows how to customize the Checkout package for Umbraco Commerce.
---

# Customize Checkout

It is assumed that you already have an Umbraco website configured Umbraco Commerce installed and a store set up. If you are not at this stage yet, read the [core Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/) to learn how to get started.

Umbraco Commerce Checkout is a free and open-source add-on package for Umbraco Commerce. It is possible to amend the default behavior to customize the checkout to your needs.

## How overriding works

The Checkout package ships its Views **precompiled** into the package assembly. To change a View, you provide your own copy at the same path under `Views/UmbracoCommerceCheckout`. For your copy to be used, **your site must also compile a View at that path at build time** - your compiled View then takes precedence over the package's precompiled one.

{% hint style="warning" %}
**Umbraco 17 and later: dropping in a View is not enough on its own**

New Umbraco projects are created in `BackofficeDevelopment` development mode, which sets the following in the project's `.csproj`:

```xml
<RazorCompileOnBuild>false</RazorCompileOnBuild>
<RazorCompileOnPublish>false</RazorCompileOnPublish>
```

With these settings your site does **not** compile the Views you add under `Views/UmbracoCommerceCheckout`, so the package's precompiled Views keep being used and your changes never appear - even after a rebuild.

Razor **runtime compilation** does not work around this. It compiles on-disk Views only at paths where no precompiled View exists (this is what lets you live-edit your own templates and partials). It does **not** displace a package's precompiled View, so installing `Umbraco.Cms.DevelopmentMode.Backoffice` does not make Checkout overrides take effect either.

To use file-based overrides, your site must compile Views at **build time**:

1. Switch Models Builder to a source-code mode (`SourceCodeAuto` or `SourceCodeManual`) and generate your models - see [Models Builder settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/modelsbuildersettings). Build-time Razor compilation is incompatible with the default `InMemoryAuto` mode, because in-memory models do not exist at build time.
2. Remove `<RazorCompileOnBuild>false</RazorCompileOnBuild>` and `<RazorCompileOnPublish>false</RazorCompileOnPublish>` from your `.csproj` (or set them to `true`).
3. Rebuild the site.

This is the same configuration Umbraco requires for [Production runtime mode](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/runtime-modes), so it also moves you toward a production-ready setup.
{% endhint %}

## Setup

Once your site is configured to compile Views at build time (see the note above), follow these steps:

1. Copy the equivalent [files and partials](https://github.com/umbraco/Umbraco.Commerce.Checkout/tree/main/src/Umbraco.Commerce.Checkout/Views/UmbracoCommerceCheckout).
2. Add them to `Views/UmbracoCommerceCheckout` in your project directory. It might be necessary to create the folder first.
3. Make a small text change to one of the Views.
4. Rebuild and restart your site, then verify that the change is displayed correctly.

You are now ready to start customizing the Checkout page to fit the design of your website.

## Alternative: use a Template

If you would rather not change your build-time compilation settings, you can assign a **Template** to the checkout page in the backoffice and place your markup there. A Template lives at its own View path with no precompiled View competing with it, so it renders (and live-edits) normally, and Checkout renders it instead of its built-in View.

Note that a Template receives the checkout page's `IPublishedContent` as its model - not the view model the packaged Views use - so with this approach you build that step's markup yourself against the Umbraco Commerce APIs.

## Useful links

Here are a few useful links to learn more about the Umbraco Commerce Checkout package:

* [Umbraco Commerce Checkout source code](https://github.com/umbraco/Umbraco.Commerce.Checkout)
* [Umbraco Commerce Checkout issue tracker](https://github.com/umbraco/Umbraco.Commerce.Checkout/issues)

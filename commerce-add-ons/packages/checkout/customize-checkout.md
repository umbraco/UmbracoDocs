---
description: This documentation shows how to customize the Checkout package for Umbraco Commerce.
---

# Customize Checkout

It is assumed that you already have an Umbraco website configured Umbraco Commerce installed and a store set up. If you are not at this stage yet, read the [core Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/) to learn how to get started.

Umbraco Commerce Checkout is a free and open-source add-on package for Umbraco Commerce. It is possible to amend the default behavior to customize the checkout to your needs.

## Overriding the checkout Views

To customize one, add your copy to the same path under Views/UmbracoCommerceCheckout. Ensure your site compiles Views at build time so your copy is used instead of the packaged one.

{% hint style="warning" %}
New Umbraco projects (17+) are set up for backoffice development, which disables build-time View compilation:

```xml
<RazorCompileOnBuild>false</RazorCompileOnBuild>
<RazorCompileOnPublish>false</RazorCompileOnPublish>
```

While this is set, Views you add under `Views/UmbracoCommerceCheckout` are ignored and your changes will not appear. To enable overrides:

1. Switch Models Builder to a source-code mode (`SourceCodeAuto` or `SourceCodeManual`) and generate your models. Build-time compilation is not compatible with the default `InMemoryAuto` mode - see [Models Builder settings](https://docs.umbraco.com/umbraco-cms/reference/configuration/modelsbuildersettings).
2. Remove the `RazorCompileOnBuild` and `RazorCompileOnPublish` lines above (or set them to `true`).

This matches the configuration Umbraco requires for [Production runtime mode](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/server-setup/runtime-modes).
{% endhint %}

Once your site compiles Views at build time, override a checkout step as follows:

1. Copy the equivalent [files and partials](https://github.com/umbraco/Umbraco.Commerce.Checkout/tree/main/src/Umbraco.Commerce.Checkout/Views/UmbracoCommerceCheckout).
2. Add them to `Views/UmbracoCommerceCheckout` in your project directory. It might be necessary to create the folder first.
3. Make your changes.
4. Rebuild and restart your site, then verify that the change is displayed correctly.

## Alternative: use a Template

Instead of overriding the Views, you can assign a **Template** to the checkout page in the backoffice and place your markup there. Checkout will use the Template instead of its built-in View.

With this approach, the Template receives the checkout page's IPublishedContent as its model—not the packaged Views' view model.

You then build that step's markup yourself against the Umbraco Commerce APIs.

## Useful links

Here are a few useful links to learn more about the Umbraco Commerce Checkout package:

* [Umbraco Commerce Checkout source code](https://github.com/umbraco/Umbraco.Commerce.Checkout)
* [Umbraco Commerce Checkout issue tracker](https://github.com/umbraco/Umbraco.Commerce.Checkout/issues)

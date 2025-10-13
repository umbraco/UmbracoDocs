---
description: This documentation shows how to customize the Portal package for Umbraco Commerce.
---

# Customize Portal

It is assumed that you already have an Umbraco website configured Umbraco Commerce installed and a store set up. If you are not at this stage yet, please read the [core Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/) to learn how to get started.

Umbraco Commerce Portal is a free and open-source add-on package for Umbraco Commerce. It is possible to amend the default behavior to customize the portal to your needs.

## Setup

To allow customization you must first 'override' the existing files for the step required to be modified. 

To do this follow these steps:

1. Copy the equivalent [files and partials](https://github.com/umbraco/Umbraco.Commerce.Portal/tree/main/src/Umbraco.Commerce.Portal/Views/UmbracoCommercePortal). 
2. Add them to `Views/UmbracoCommercePortal` in your project directory. It might be necessary to create the folder first.
3. Make a small text change to one of the Views to verify that the files are in use.
4. Verify that the changes are carried out and displayed correctly.

You are now ready to start customizing the Portal page to fit the design of your website.

## Useful links

Here are a few useful links to learn more about the Umbraco Commerce Portal package:

* [Umbraco Commerce Portal source code](https://github.com/umbraco/Umbraco.Commerce.Portal)
* [Umbraco Commerce Portal issue tracker](https://github.com/umbraco/Umbraco.Commerce.Portal/issues)

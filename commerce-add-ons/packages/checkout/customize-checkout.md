---
description: This documentation shows how to customize the Checkout package for Umbraco Commerce.
---

# Customize Checkout

It is assumed that you already have an Umbraco website configured Umbraco Commerce installed and a store set up. If you are not at this stage yet, please read the [core Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/) to learn how to get started.

Umbraco Commerce Checkout is a free and open-source add-on package for Umbraco Commerce. It is possible to amend the default behavior to customize the checkout to your needs.

## Setup

To allow customization you must first 'override' the existing files for the step required to be modified. 

To do this follow these steps:

1. Copy the equivalent [files and partials](https://github.com/umbraco/Umbraco.Commerce.Checkout/tree/main/src/Umbraco.Commerce.Checkout/Views/UmbracoCommerceCheckout). 
2. Add them to `Views/UmbracoCommerceCheckout` in your project directory. It might be necessary to create the folder first.
3. Make a small text change to one of the Views to verify that the files are in use.
4. Verify that the changes are carried out and displayed correctly.

You are now ready to start customizing the Checkout page to fit the design of your website.

## Useful links

Here are a few useful links to learn more about the Umbraco Commerce Checkout package:

* [Umbraco Commerce Checkout source code](https://github.com/umbraco/Umbraco.Commerce.Checkout)
* [Umbraco Commerce Checkout issue tracker](https://github.com/umbraco/Umbraco.Commerce.Checkout/issues)

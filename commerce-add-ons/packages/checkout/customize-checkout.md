---
description: This documentation shows how to customize the Checkout package for Umbraco Commerce.
---

# Customize Checkout

It is assumed that before we begin that you already have an Umbraco website configured and Umbraco Commerce installed and a store set up. If you are not at this stage yet, please read the [core Umbraco Commerce documentation](https://docs.umbraco.com/umbraco-commerce/) to learn how to get started.

Umbraco Commerce Checkout is a free and open-source add-on package for Umbraco Commerce. It is possible to amend the default behaviour to customize the checkout towards your needs.

## Setup

In order to allow customization you must first 'override' the existing files for the step required to be modified. 

To do this you need to copy the equivalent (files and partials)[https://github.com/umbraco/Umbraco.Commerce.Checkout/tree/main/src/Umbraco.Commerce.Checkout/Views/UmbracoCommerceCheckout]. 

Copy the files and add them to `Views/UmbracoCommerceCheckout` in your project directory. It might be necessary to create the folder first.

Verify that the files are in use by making a simple text change to one of the Views. Visit the step where the change was carried out to ensure it displays accordingly.

## Useful links

As well as the content in these docs, here are a few useful links to learn more about the Umbraco Commerce Checkout package itself.

* [Umbraco Commerce Checkout source code](https://github.com/umbraco/Umbraco.Commerce.Checkout)
* [Umbraco Commerce Checkout issue tracker](https://github.com/umbraco/Umbraco.Commerce.Checkout/issues)

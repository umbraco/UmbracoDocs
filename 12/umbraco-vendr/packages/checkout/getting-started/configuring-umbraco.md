---
title: Configuring Umbraco
description: Configuring Umbraco for Vendr Checkout, an add-on package for Vendr, the eCommerce solution for Umbraco v8+
---

After installing Vendr Checkout, a series of content nodes will be created for you in your site that will control the checkout flow. On the root of these nodes you can configure a series of options to customize the checkout flow to your needs.

## Configuring Vendr Checkout

![Vendr Checkout Configuration](/media/screenshots/checkout/checkout_configuration.png)

| Name | Description |
| ---- | ----------- |
| Store Logo | A link to a media item to use as the store logo. If one is not selected, then the store name will be displayed instead. |
| Store Address | The official address of the store to be displayed in the footer of all email communications. |
| Theme Color | The color theme to use for the checkout design. |
| Collect Shipping Info | A checkbox to set whether to collect shipping info or not. If deselected, all shipping info related fields / steps will be removed from the checkout flow |
| Order Line Property Aliases | A comma separated list of order line property aliases to display in the order summary. |
| Checkout Back Page | The page to go back to when backing out of the checkout flow. |
| Terms and Conditions Page | The page on the site containing the terms and conditions of the store. |
| Privacy Policy Page | The page on the site containing the privacy policy. |
| Hide from Navigation | Checkbox to hide the checkout page from the sites main navigation. |

In addition to these root node settings, each checkout step page also has a number of configurable options:

| Name | Description |
| ---- | ----------- |
| Short Step Name | A short name for this step to display in the checkout navigation. |
| Step Type | The checkout step to display for this step of the checkout flow. |

## Linking to the Checkout

With the checkout setup and configured the final step is to configure your cart page to link through to the checkout flow. How you do this is completely up to you so you could link to the URL `/checkout` or use a content picker to select the checkout node to link to.
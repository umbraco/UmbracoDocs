---
description: >-
  Detailed instructions on how to install and configure Cart into your
  Umbraco Commerce implementation.
---

# Installation

The Cart package can be installed directly into your project's code base using NuGet packages.

## NuGet Package Installation

To install the Umbraco Commerce Cart package via NuGet run the following command directly in the NuGet Manager Console window in Visual Studio:

```bash
PM> Install-Package Umbraco.Commerce.Cart
```

## Client Assets Installation

Once installed, add the following CSS include to your layout templates `head` section

```html
<link href="/App_Plugins/UmbracoCommerceCart/umbraco-commerce-cart.css" rel="stylesheet">
```

and the following JavaScript include before the closing `body` tag.

```html
<script src="/App_Plugins/UmbracoCommerceCart/umbraco-commerce-cart.js" defer></script>
```

Once installed, head to the [Configuration](./configuration.md) section to configure Cart for your solution.
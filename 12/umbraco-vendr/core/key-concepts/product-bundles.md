---
title: Product Bundles
description: Creating bundles of products with Vendr, the eCommerce solution for Umbraco
---

Occasionally you may need to create a product with multiple sub-products. A good example of this is when buying a computer where you may pick the computer as the main product, but then you can choose the different components to make up the computer, such as the CPU or hard disk options. The final order line then becomes the composite order line of the selected primary product and all its sub-product options. To achieve this kind of configurable product in Vendr, we can use a feature called product bundling.

## Creating a Bundle

To create a bundle, we first add the primary product to an order as we normally would, but in addition to the product/quantity information, we also provide a unique `bundleId` to identify that by adding this product, it should create a bundle order line.

```csharp
// Define a unique bundle id for the order line
var bundleId = "MyUniqueBundleId";

// Add the primary product to the order giving it a bundle ID
order.AddProduct(productReference, productQuantity, bundleId);
```

## Adding Sub Products to a Bundle

With the primary product added as a bundle, we can then add sub products to that bundle by calling one of the `AddProductToBundle` order methods.


```csharp
// Define a unique bundle id for the order line
var bundleId = "MyUniqueBundleId";

// Add the primary product to the order giving it a bundle ID
order.AddProduct(productReference, productQuantity, bundleId);

// Add a sub product to the bundle by calling a AddProductToBundle method
// passing in the same bundle ID as the primary order line
order.AddProductToBundle(bundleId, subProductReference, subProductQuantity);

```

## Order Line Price Calculation

By adding sub products to a bundle, Vendr knows to automatically sum up all the sub product prices together and add them to the unit price of the primary order line for you, meaning there is nothing extra you need to do in the calculation process.

## Displaying Bundles in the Back-Office

As you can imagine, product bundles could get rather large making it a little difficult to display them in the back-office. Thankfully, Vendr also takes care of this for you, bundling order lines together in a collapsible user interface allowing you to get a clear view of your orders whilst still being able to drill into the detail of the items purchased.

![Product bundles in the backoffice](../media/backback-office-bundles.png)

---
description: Creating product variants with Umbraco Commerce.
---

# Product Variants

Product variants are the ability to define variants of a given product. If a product was available in multiple color options, you would create a primary product with product variants for each of the color options.

Out of the box, Umbraco Commerce supports two types of product variant setups.

## Child Variants

Child variants are where the product variants are set up as child nodes below the primary product. Generally speaking, this setup is only sustainable for single variant options, where there is only one differing option between the variants.

By using child variants the only thing you need to create is your own variant nodes as you already do in Umbraco.

When a child variant is added Umbraco Commerce checks the primary product node for any properties that can't be found on the variant child node.

This approach is how most of [the official Demo store](https://github.com/umbraco/Umbraco.Commerce.DemoStore) is set up.

## [Complex Variants](complex-variants.md)

Complex variants are where products vary by multiple possible options, such as by size, color, and fit. Complex variants tend to create a lot of variant products which makes the child variants approach impractical.

For complex variants, Umbraco Commerce comes with a variants property editor which will handle a lot of this complexity for you. You can set up a variant element type to use as your data blueprint for your variant products. This can then be linked to the property editor. The variants property editor will use this as the data structure for your variants. You will be presented with the relevant UI to input the product details.

{% hint style="info" %}
For more information on how you can setup Complex Variants, head to the [Complex Variants](complex-variants.md) article.
{% endhint %}

### [Product Attributes](complex-variants.md#product-attributes)

To aid with the setup of the complex variants, Umbraco Commerce has the **Product Attributes** concept which defines the individual options that make up your product variants. This could be colors, sizes, and fits. Each product attribute is made up of a label and as many values as needed.

Product attributes are used by the complex variants property editor allowing you to select the combinations of product variants you wish to create. It will automatically generate the product variant entries for you, ready for product information updating.

{% hint style="info" %}
For more information on how you can setup Product attributes, head to the [Complex Variants](complex-variants.md#product-attributes) article.
{% endhint %}

---
title: Product Variants
description: Creating product variants with Vendr, the eCommerce solution for Umbraco
---

Product variants are the ability to define variants of a given product, for example if a product was available in multiple colour options, you would create a primary product with product variants for each of the colour options.

Out of the box, Vendr supports two types of product variant setups.

## Child Variants

Child variants are where the product variants are setup as child nodes below the primary product. Generally speaking this setup is only sustainable for single variant options, where there is only one differing option between the variants. The upside of child variants is that it's much simpler to implement as all that is needed is to create your variant nodes as you already do in Umbraco.

Vendr is smart enough to know that when a child variant is added that it can check the primary product node for any properties it expects that can't be found on the variant child node.

This approach is how most of the official [Vendr Demo](https://try.vendr.net) store is setup.

## Complex Variants

Complex variants are where products vary by multiple possible options, such as by size, colour and fit. With complex variants, this tends to create a lot of variant products which makes the child variants approach impractical.

For complex variants, Vendr comes with a variants property editor which will handle a lot of this complexity for you. Working in a similar manor to Umbraco's own block-list editor, you can setup a variant element type to use as your data blueprint for your variant products and link this to the property editor. The variants property editor will then use this as the data structure for your variants and present you with the relevant UI to input the products details.

### Product Attributes

To aid with the setup of the complex variants, Vendr also has a concept of **Product Attributes** which define these individual options that make up your product variants, such as colors, sizes and fits. Each product attribute is made up of a label and as many values as needed.

Product attributes are then used by the complex variants property editor allowing you to select the combinations of product variants you wish to create and it will automatically generate the product variant entries for you, ready for product information updating.

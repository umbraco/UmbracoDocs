---
description: Key Umbraco node properties used by Vendr, the eCommerce solution for Umbraco
---

# Umbraco Properties

Vendr uses Umbraco nodes as it's source of information. In order for Vendr to gather the information it needs however, it requires that a number of properties be defined at different locations with specific property aliases.

## Properties

| Alias | Type | Description |
| -- | -- | -- |
| `store` | Vendr.StorePicker | Often placed on the site root node, but can be placed on any node higher than the product nodes themselves, this property links the website to a specific Vendr store configuration |
| `productName` | Textstring | Optional product node property that allows you to define an explicit product name other than the product nodes `.Name` property, which will be used as fallback |
| `sku` | Textstring | Product node property defining the unique `SKU` of the product |
| `price` | Vendr.Price | Product node property defining the prices for the product |
| `stock` | Vendr.Stock | Product node property defining the stock level of the product |
| `taxClass` | Vendr.StoreEntityPicker | Optional product node property that allows you to define an explicit `Tax Class` for the product, should it differ from the stores default |
| `isGiftCard` | True/False | Optional product node property that defined whether the product node should be considered a Gift Card product, in which case it triggers the automatic generation of a Gift Card in the backoffice and emails it directly to the customer on checkout |
| `productSource` | ContentPicker | Optional product node property allowing you to link a product to another product outside of it's hierarchy to be used as it's source of product information |
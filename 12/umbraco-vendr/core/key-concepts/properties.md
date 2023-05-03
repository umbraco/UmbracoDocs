---
title: Properties
description: Order / Order Line meta data in Vendr, the eCommerce solution for Umbraco
---

Out of the box, there is very little information that Vendr really needs to know about a product in order for it to do it's job, however there are times when developers require an ability to store additional information against an Order / Order Line, such as the billing / shipping address of an Order, or any specific configuration details of a given Product on an Order Line.

To help facilitate this Vendr has the concept of a Properties collection on both the Order entity and the Order Line entity respectively. The Properties collection of these entities can be thought of as a general store for additional information required by an implementation, but not strictly required by Vendr itself.

Essentially, anything you need to remember about an Order / Order Line can be stored in it's Properties collection.

## Setting Properties

In order to set a Property on an Order / Order Line, it first needs to be [in it's Writable state](../readonly-and-writable-entities/#converting-a-readonly-entity-into-a-writable-entity), and then it's a case of calling one of the related property setting methods: 

````csharp
// Set a single property
order.SetProperty("propertyAlias", "Property Value");

// Set multiple properties at once
order.SetProperties(new Dictionary<string, string>{
    { "propertyAlias1", "Property Value 1" },
    { "propertyAlias2", "Property Value 2" },
    { "propertyAlias3", "Property Value 3" }
})

// Remove a property
order.RemoveProperty("propertyAlias");

````

 Property values can either be a `string`, or a Vendr `PropertyValue` which allows you to define a value as being Server Side Only meaning it won't returned via non-server APIs or Read Only meaning it can't be updated once set.

 
````csharp
// Set a string property
order.SetProperty("propertyAlias", "Property Value");

// Set a PropertyValue property as Read Only
order.SetProperty("propertyAlias", new PropertyValue("Property Value", isReadOnly: true));

````

## System Properties

When there are occasions that Vendr needs to capture some information about an Order / Order Line, it too uses the Properties collection to store this information. It's useful to know what these properties are as you should avoid using these system related property keys.

### Order System Properties

| Alias | Description |
| ----- | ----------- |
| `email` | The email address of the person placing the order. Is where `order.CustomerInfo.Email` reads it's value from. |
| `firstName` | The first name of the person placing the order. Is where `order.CustomerInfo.FirstName` reads it's value from. |
| `lastName` | The last name of the person placing the order. Is where `order.CustomerInfo.LastName` reads it's value from. |

### Order Line System Properties

| Alias | Description |
| ----- | ----------- |
| `sku` | The SKU of the product, extracted from the product node via the [Product Adapter](../product-adapters/). |

## Automatic Properties

For Order Lines, as well as the ability to set Properties manually as outlined above, there is also a built-in mechanism within Vendr that can be configured to automatically copy properties from a Product information source to the Order Line automatically, and that is by using the **Product Property Aliases** field on the Store settings screen.

![Product Property Aliases Configuration](../media/product_property_aliases.png)

When set to a comma separated list of property aliases, whenever a Product is added to the Order containing those properties, those property values will automatically be copied to the Order Lines Properties collection.

This is useful for occasions such as rendering out the Order Lines on a Cart page and you have some Product information you also want to display. By copying it to the Order Lines Properties collection, you have instant access to those properties without need to re-fetch the original Product entity to look them up.

## Product Uniqueness Properties

Another use of the Properties collection for an Order Line is that of identifying product "Uniqueness". Product uniqueness is how Vendr identifies whether a Product being added to a Cart should be considered as Quantity increase on an existing Order Line, or whether it should be considered as a unique product combination and so should be given an Order Line of it's own. A good example of this when you have configurable products, such as customizable T-Shirt designs, and so each unique configuration should be considered as it's own Order Line so that you can manage the specific configurations.

Product uniqueness is configured via the **Product Uniqueness Property Aliases** field on the Store setting screen.

![Product Uniqueness Property Aliases Configuration](../media/product_uniqueness_property_aliases.png)

When set to a comma separated list of property aliases (either Product properties, or manually defined Order Line properties), whenever a Product is added to an Order, these properties are compared against all pre-existing Order Lines for that Product, and should their values be different, then a unique Order Line will be created for that Product.

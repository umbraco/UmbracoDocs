---
description: Order and Order Line metadata in Umbraco Commerce.
---

# Properties

There is little information that Umbraco Commerce needs to know about a product in order for it to do its job. There are, however, times when developers require the ability to store additional information against an Order or Order Line. This could be the billing/shipping address of an Order, or any specific configuration details of a given Product on an Order Line.

To help facilitate this Umbraco Commerce has the concept of a Properties collection on both the Order entity and the Order Line entity respectively. The Properties collection of these entities can be thought of as a general store for additional information required by an implementation, but not strictly required by Umbraco Commerce itself.

Anything you need to remember about an Order / Order Line can be stored in its Properties collection.

## Setting Properties

To set a Property on an Order or Order Line, it needs to be [in its Writable state](readonly-and-writable-entities.md#converting-a-readonly-entity-into-a-writable-entity). Then it's a case of calling one of the related property setting methods:

```csharp
// Set a single property
await order.SetPropertyAsync("propertyAlias", "Property Value");

// Set multiple properties at once
await order.SetPropertiesAsync(new Dictionary<string, string>{
    { "propertyAlias1", "Property Value 1" },
    { "propertyAlias2", "Property Value 2" },
    { "propertyAlias3", "Property Value 3" }
})

// Remove a property
await order.RemovePropertyAsync("propertyAlias");

```

Property values can either be a `string`, or a Umbraco Commerce `PropertyValue` which allows you to define a value as being Server Side Only. This means that it won't be returned via non-server APIs or Read Only meaning it can't be updated once set.

```csharp
// Set a string property
await order.SetPropertyAsync("propertyAlias", "Property Value");

// Set a PropertyValue property as Read Only
await order.SetPropertyAsync("propertyAlias", new PropertyValue("Property Value", isReadOnly: true));
```

## System Properties

On occasions where Umbraco Commerce needs to capture some information about an Order or Order Line, it uses the Properties collection to store this information. It's useful to know what these properties are as you should avoid using these system-related property keys.

### Order System Properties

| Alias       | Description                                                                                                    |
| ----------- | -------------------------------------------------------------------------------------------------------------- |
| `email`     | The email address of the person placing the order. Is where `order.CustomerInfo.Email` reads it's value from.  |
| `firstName` | The first name of the person placing the order. Is where `order.CustomerInfo.FirstName` reads it's value from. |
| `lastName`  | The last name of the person placing the order. Is where `order.CustomerInfo.LastName` reads it's value from.   |

### Order Line System Properties

| Alias | Description                                                                                               |
| ----- | --------------------------------------------------------------------------------------------------------- |
| `sku` | The `SKU` of the product, extracted from the product node via the [Product Adapter](product-adapters.md). |

## Automatic Properties

Umbraco Commerce has a built-in mechanism that can be configured to automatically copy properties from a Product information source to the Order Line automatically. This is done by using the **Product Property Aliases** field on the Store settings screen.

![Product Property Aliases Configuration](../media/product\_property\_aliases.png)

When a Product is added to the Order containing a comma-separated list of property aliases, the property values are automatically copied to the Order Lines Properties collection.

This is useful for occasions such as rendering out the Order Lines on a Cart page and you have Product information you want to display. By copying it to the Order Lines Properties collection, you have instant access to those properties without the need to re-fetch the original Product entity.

## Product Uniqueness Properties

Another use of the Properties collection for an Order Line is that of identifying product "Uniqueness".

Umbraco Commerce uses Product Uniqueness to identify either of the two:

* Whether a Product is added to a Cart should be considered as a Quantity increase on an existing Order Line
* Whether it should be considered as a unique product combination and so should be given an Order Line of its own.

A good example of this is when you have configurable products, such as customizable T-Shirt designs. In this case, each unique configuration should be considered as its own Order Line so that you can manage the specific configurations.

Product uniqueness is configured via the **Product Uniqueness Property Aliases** field on the Store setting screen.

![Product Uniqueness Property Aliases Configuration](../media/product\_uniqueness\_property\_aliases.png)

When set to a comma-separated list of property aliases and a Product is added to an Order, the properties are compared against all pre-existing Order Lines for that Product. Should their values be different, then a unique Order Line will be created for that Product.

## Order Property Map

In Umbraco Commerce, you may need to access order information in a structured way for shipping calculations and using the Storefront and Management API's. An order property map can be set up to specify how items in an order's properties collection correspond to properties of a structured model.

Order property maps can be defined per store, but there is also a default map that is pre-configured.

Order property maps are defined via the [`IUmbracoCommerceBuilder`](./umbraco-commerce-builder.md) interface.

```csharp
// Create a new mapping for the given store
builder.WithOrderPropertyConfigs()
    .Add("storeAlias", map => map
        // Define your property map here
    );

// Update the default mapping
builder.WithOrderPropertyConfigs()
    .UpdateDefault(map => map
        // Define your property map here
    );
```

The default property map is configured as follows:

```csharp
builder.WithOrderPropertyConfigs()
    .AddDefault(map => map
        // Customer
        .For(x => x.Customer.FirstName).MapFrom(Core.Constants.Properties.Customer.FirstNamePropertyAlias)
        .For(x => x.Customer.LastName).MapFrom(Core.Constants.Properties.Customer.LastNamePropertyAlias)
        .For(x => x.Customer.Email).MapFrom(Core.Constants.Properties.Customer.EmailPropertyAlias)
        .For(x => x.Customer.Telephone).MapFrom("telephone")
        // Billing
        .For(x => x.Billing.Contact.FirstName).MapFrom("billingFirstName")
        .For(x => x.Billing.Contact.LastName).MapFrom("billingLastName")
        .For(x => x.Billing.Contact.Email).MapFrom("billingEmail")
        .For(x => x.Billing.Contact.Telephone).MapFrom("billingTelephone")
        .For(x => x.Billing.CompanyName).MapFrom("billingCompany")
        .For(x => x.Billing.CompanyTaxCode).MapFrom("billingCompanyTaxCode")
        .For(x => x.Billing.AddressLine1).MapFrom("billingAddressLine1")
        .For(x => x.Billing.AddressLine2).MapFrom("billingAddressLine2")
        .For(x => x.Billing.City).MapFrom("billingCity")
        .For(x => x.Billing.ZipCode).MapFrom("billingZipCode")
        // Shipping
        .For(x => x.Shipping.SameAsBilling).MapFrom("shippingSameAsBilling")
        .For(x => x.Shipping.Contact.FirstName).MapFrom("shippingFirstName")
        .For(x => x.Shipping.Contact.LastName).MapFrom("shippingLastName")
        .For(x => x.Shipping.Contact.Email).MapFrom("shippingEmail")
        .For(x => x.Shipping.Contact.Telephone).MapFrom("shippingTelephone")
        .For(x => x.Shipping.CompanyName).MapFrom("shippingCompany")
        .For(x => x.Shipping.CompanyTaxCode).MapFrom("shippingCompanyTaxCode")
        .For(x => x.Shipping.AddressLine1).MapFrom("shippingAddressLine1")
        .For(x => x.Shipping.AddressLine2).MapFrom("shippingAddressLine2")
        .For(x => x.Shipping.City).MapFrom("shippingCity")
        .For(x => x.Shipping.ZipCode).MapFrom("shippingZipCode")
        //Notes
        .For(x => x.Notes.CustomerNotes).MapFrom("customerNotes")
        .For(x => x.Notes.InternalNotes).MapFrom("internalNotes"));
```
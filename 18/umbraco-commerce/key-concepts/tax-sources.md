---
description: Identifying the source of taxation of an Order within Umbraco Commerce.
---

# Tax Sources

A Tax Source identifies which geographic location an Order should use in order to calculate its tax liability. Depending on the country that the web store is operating in and the country, an order is being purchased from/shipping to, this can dictate how your taxes should be calculated.

To aid with this Umbraco Commerce allows the Tax Source of a Store to be configured via the implementation of a Tax Source Factory. The Tax Source Factory is responsible for determining the source of Tax given the billing and shipping country of an Order.

Out of the box, Umbraco Commerce comes with two Tax Source Factory implementations:

* **DestinationTaxSourceFactory** - (Default) Sets the Tax Source as being the destination country where an Order will be shipped to.
* **OriginTaxSourceFactory** - Sets the Tax Source as being the origin country where an Order was billed to.

## Changing the Tax Source Factory

Tax Source Factories are [registered via the IUmbracoCommerceBuilder](umbraco-commerce-builder.md) interface using the `AddUnique<ITaxSourceFactory, TReplacementTaxSourceFactory>()` method on the `Services` property where the `TReplacementTaxSourceFactory` parameter is the type of your replacement Tax Source Factory implementation.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyServices(IUmbracoCommerceBuilder builder)
    {
        // Replacing the default Tax Source Factory implementation
        builder.Services.AddUnique<ITaxSourceFactory, OriginTaxSourceFactory>();

        // Return the builder to continue the chain
        return builder;
    }
}
```

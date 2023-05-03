---
title: Tax Sources
description: Identifying the source of taxation of an Order within Vendr, the eCommerce solution for Umbraco
---

A Tax Source identifies which geographic location an Order should use in order to calculate its tax liability. Depending on the country that the web store is operating in, and the country an order is being purchased from / shipping to, this can dictate how your taxes should be calculated.

To aid with this Vendr allows the Tax Source of a Store to be configured via the implementation of a Tax Source Factory. The Tax Source Factory is responsible for determining the source of Tax given the billing and shipping country of an Order.

Out of the box, Vendr comes with two Tax Source Factory implementations:

* **DestinationTaxSourceFactory** - (Default) Sets the Tax Source as being the destination country where an Order will be shipped to.

* **OriginTaxSourceFactory** - Sets the Tax Source as the being the origin country where an Order was billed to.

## Changing the Tax Source Factory

Tax Source Factories are [registered via the IVendrBuilder](../vendr-builder/#registering-dependencies) interface using the `AddUnique<ITaxSourceFactory, TReplacementTaxSourceFactory>()` method on the `Services` property where the `TReplacementTaxSourceFactory` parameter is the Type of your replacement Tax Source Factory implementation.


````csharp
public static class VendrBuilderExtensions
{
    public static IVendrBuilder AddMyServices(IVendrBuilder builder)
    {
        // Replacing the default Tax Source Factory implementation
        builder.Services.AddUnique<ITaxSourceFactory, OriginTaxSourceFactory>();

        // Return the builder to continue the chain
        return builder;
    }
}
````

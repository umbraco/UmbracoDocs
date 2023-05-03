---
title: Price/Amount Adjustments
description: Adjusting prices in Vendr, the eCommerce solution for Umbraco
---

Quite often in a solution you may want to tweak the figures of an order, be that reducing the price of a product if a customer purchases a given amount of a product, or maybe specific customers incur an additional fee. To handle this, Vendr has the concept of Price/Amount Adjustments. What adjustments allow you to do is create a record/log of any changes that occur to a price/amount throughout the calculation process. Vendr then uses these adjustments in the calculation process to work out its final pricing, and also provides this list of all the adjustments on the order for easy reference, making it clear exactly how the price was calculated.

Vendr has two types of adjustments:

* **Price Adjustment** - Adjusts one of the orders price properties (e.g. discounts, fees).
* **Amount Adjustment** - Adjusts the final transaction amount of an order (e.g. gift cards, loyalty points).

## Creating Custom Adjustments

Adjustments are applied using a `IPriceAdjuster` or `IAmountAdjuster` with developers able to create their own adjusters to apply custom adjustments.

````csharp
public class MyPriceAdjuster : PriceAdjusterBase
{
    public override void ApplyPriceAdjustments(PriceAdjusterArgs args)
    {
        // Calculate Adjustment
        // Discount adjustments should be negative
        // where as Fee adjustments should be positive

        // Create a £10 discount
        var price = new Price(-8.33, -1.67, args.Order.CurrencyId);
        var adjustment = new MyAdjustment("My Discount", "MD-001", price);

        // Add the adjustment to the sub total price
        args.SubtotalPriceAdjustments.Add(adjustment);
    }
}
````

Adjusters apply adjustments to their given price they wish to affect. Adjustments are strongly typed and so each adjuster should define their own adjustment type, providing properties to collect any relevant information for the adjustment (this "meta data" gets serialized with the adjustment as is constantly available when accessing the given adjustment).  

````csharp
[Serializable]
public class MyAdjustment : PriceAdjustment<MyAdjustment>
{
    public string MyAdjustmentRef { get; set; }

    // A parameterless constructor is required for cloning
    public MyAdjustment()
        : base()
    { }

    // Additional helper constructors
    public MyAdjustment (string name, string reference, Price adjustment)
        : base(name, adjustment)
    {
        MyAdjustmentRef = reference;
    }
}
````

Adjustments inherit from either `PriceAdjustment<TSelf>` or `AmountAdjustment<TSelf>` depending on the type of adjustment being applied. Both base classes follow a similar structure, the difference being whether the adjustment value is a `Price` or `Amount`.

````csharp
public abstract class PriceAdjustment<TSelf> 
{
    public Type Type { get; }
    public string Name { get; }
    public Price Price { get; }
    public Price OriginalPrice { get; }
}
````

Once defined, the adjuster should be registered with the DI container to enable Vendr to be aware of it and include it in it's calculation process.


````csharp
public static class VendrBuilderExtensions
{
    public static IVendrBuilder AddMyServices(IVendrBuilder builder)
    {
        // Register the price adjuster
        builder.WithPriceAdjusters()
            .Append<MyPriceAdjuster>();

        // Return the builder to continue the chain
        return builder;
    }
}

---
description: Learn about adjusting prices in Umbraco Commerce.
---

# Price/Amount Adjustments

In some cases, you may want to tweak the figures of an order. It could be reducing the price of a product if a customer purchases a given amount of a product. To handle this, Umbraco Commerce has the concept of Price/Amount Adjustments. What adjustments allow you to do is create a record/log of any changes that occur to a price/amount throughout the calculation process. Umbraco Commerce uses the adjustments in the calculation process to work out its final pricing and provides this list of the adjustments on the order. This makes it clear exactly how the price was calculated.

Umbraco Commerce has two types of adjustments:

* **Price Adjustment** - Adjusts one of the orders' price properties (discounts, fees).
* **Amount Adjustment** - Adjusts the final transaction amount of the order (gift cards, loyalty points).

## Creating Custom Adjustments

Adjustments are applied using a `IPriceAdjuster` or `IAmountAdjuster` with developers able to create their own adjusters to apply custom adjustments.

```csharp
public class MyPriceAdjuster : PriceAdjusterBase
{
    public override async Task ApplyPriceAdjustmentsAsync(PriceAdjusterArgs args)
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
```

Adjusters apply adjustments to the given price they wish to affect. Adjustments are strongly typed and each adjuster should define their own adjustment type, providing properties to collect any relevant information for the adjustment. This "metadata" gets serialized with the adjustment as is constantly available when accessing the given adjustment.

```csharp
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
```

Adjustments inherit from either `PriceAdjustment<TSelf>` or `AmountAdjustment<TSelf>` depending on the type of adjustment being applied. Both base classes follow a similar structure, the difference being whether the adjustment value is a `Price` or `Amount`.

```csharp
public abstract class PriceAdjustment<TSelf> 
{
    public Type Type { get; }
    public string Name { get; }
    public Price Price { get; }
    public Price OriginalPrice { get; }
}
```

Once defined, the adjuster should be registered with the DI container to enable Umbraco Commerce to be aware of it and include it in the calculation process.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyServices(IUmbracoCommerceBuilder builder)
    {
        // Register the price adjuster
        builder.WithPriceAdjusters()
            .Append<MyPriceAdjuster>();

        // Return the builder to continue the chain
        return builder;
    }
}
```

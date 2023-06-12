---
description: Freezing prices for shopping carts in Umbraco Commerce.
---

# Price Freezing

Price Freezing in Umbraco Commerce is the ability to freeze prices for products that are added to the shopping cart. Umbraco Commerce takes a snapshot of a product's price once it's added to the shopping card. This is done in order to ensure the price is honored for the life of the shopping cart. This process prevents a customer's shopping cart from suddenly changing in value should a price change occur whilst their cart session is in progress.

A product's price is frozen from the point it is added to the current Order, and only for the current Currency of the Order. Should the Customer change the Currency of their Order, then a new snapshot of the product price will be taken for that Currency.

## Controlling Price Freezing

There are times when you may wish to control when a frozen price should expire. This could be if a product was incorrectly priced, or if you have rules on how long an Order-session is allowed to maintain price.

On these occasions, you can force frozen prices to expire by using the `IPriceFreezerService` and its `ThawPrices` method.

All frozen prices have an `OrderId` property and a `Key` that uniquely identifies them. For product prices, this key consists of a generated token of the following format `{StoreId}_{OrderId}_{ProductReference}`. In addition, the product prices Currency, and date of the freeze are also tracked. It is important to know these details as we can use all of these attributes to target which prices we wish to thaw.

For example, to thaw all prices for a product with the reference `c0296b75-1764-4f62-b59c-7005c2348fdd` we could call:

```csharp
_priceFreezerService.ThawPrices(partialKey: "c0296b75-1764-4f62-b59c-7005c2348fdd");
```

Or to thaw all prices for a given Currency that are greater than 30 days old we could call:

```csharp
_priceFreezerService.ThawPrices(currencyId: currency.Id, olderThan: DateTime.Now.AddDays(-30));
```

---
description: Performing calculations with Calculators in Umbraco Commerce.
---

# Calculators

Calculators are small service implementations with the sole responsibility of calculating prices for a given aspect of an Order. There are five main Calculator service interfaces in Umbraco Commerce:

* **IShippingCalculator** - Responsible for calculating the Shipping Method price/tax rate of a given Shipping Method.
* **IPaymentCalculator** - Responsible for calculating the Payment Method price/tax rate of a given Payment Method.
* **IProductCalculator** - Responsible for calculating the Product unit price/tax rate of a given Product.
* **IOrderLineCalculator** - Responsible for calculating the price/tax rate of a given OrderLine.
* **IOrderCalculator** - Responsible for calculating the entire Order.

All Calculator services can be replaced with alternative implementations should you wish to change how Umbraco Commerce performs its calculations.

## Defining a Custom Calculator Implementation

The individual Calculator interfaces may differ but the process for defining a custom Calculator implementation is the same for all of them. It is possible to create a new class that implements the default system Calculator that you wish to replace. You can then override the relevant calculation methods.

```csharp
public class VolumeDiscountProductCalculator : ProductCalculatorBase
{
    private readonly ITaxService _taxService;
    private readonly IStoreService _storeService;

    public VolumeDiscountProductCalculator(ITaxService taxService, IStoreService storeService)
    {
        _taxService = taxService;
        _storeService = storeService;
    }

    public override async Task<Attempt<TaxRate>> TryCalculateProductTaxRateAsync(
        IProductSnapshot productSnapshot,
        TaxSource taxSource,
        TaxRate fallbackTaxRate,
        ProductCalculatorContext context = null,
        CancellationToken cancellationToken = default)
    {
        productSnapshot.MustNotBeNull(nameof(productSnapshot));
        fallbackTaxRate.MustNotBeNull(nameof(fallbackTaxRate));

        TaxRate taxRate = fallbackTaxRate;

        // Use the product's tax class if one is assigned
        if (productSnapshot.TaxClassId != null)
        {
            taxRate = (await _taxService.GetTaxClassAsync(productSnapshot.TaxClassId.Value))
                .GetTaxRate(taxSource);
        }

        return Attempt.Succeed(taxRate);
    }

    public override async Task<Attempt<Price>> TryCalculateProductPriceAsync(
        IProductSnapshot productSnapshot,
        Guid currencyId,
        TaxRate taxRate,
        ProductCalculatorContext context = null,
        CancellationToken cancellationToken = default)
    {
        taxRate.MustNotBeNull(nameof(taxRate));

        StoreReadOnly store = await _storeService.GetStoreAsync(productSnapshot.StoreId);

        // Get the base unit price for the currency
        var unitPrice = productSnapshot.Prices?.FirstOrDefault(x => x.CurrencyId == currencyId)?.Value ?? 0m;

        // Apply volume discount based on quantity
        var quantity = context?.OrderLine?.Quantity ?? 1m;
        var discountedPrice = unitPrice;

        if (quantity >= 100)
        {
            discountedPrice = unitPrice * 0.85m; // 15% discount for 100+ items
        }
        else if (quantity >= 50)
        {
            discountedPrice = unitPrice * 0.90m; // 10% discount for 50-99 items
        }
        else if (quantity >= 10)
        {
            discountedPrice = unitPrice * 0.95m; // 5% discount for 10-49 items
        }

        // Calculate final price with tax using the store's tax configuration
        var price = Price.Calculate(discountedPrice, taxRate, currencyId, store.PricesIncludeTax);

        return Attempt.Succeed(price);
    }
}

```

## Registering a custom Calculator implementation

Calculators are [registered via the IUmbracoCommerceBuilder](umbraco-commerce-builder.md) interface using the `AddUnique<TServiceInterface, TReplacementService>()` method on the `Services` property. The `TServiceInterface` parameter in this case is the Calculator interface Type you wish to replace and `TReplacementService` is the Type of your custom Calculator implementation.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyServices(IUmbracoCommerceBuilder builder)
    {
        // Replacing the product calculator implementation
        builder.Services.AddUnique<IProductCalculator, MyProductCalculator>();

        // Return the builder to continue the chain
        return builder;
    }
}
```

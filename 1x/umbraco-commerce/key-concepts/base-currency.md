---
description: Base Currency for standardized reporting in Umbraco Commerce.
---

# Base Currency

Within Umbraco Commerce we have support for showing analytics reports, including summaries of sales figures. At the same time, Umbraco Commerce also supports orders being placed in multiple currencies. These pose a problem of how to display a succinct sales figure when the orders are placed in multiple currencies. The answer to this is the store's **Base Currency**.

When you configure a store you need to assign a base currency to it. This currency is there to identify which currency the store should use as its basis for reports and sales figures. This will be used regardless of whatever currency the order was placed in.

When a store has a base currency configured, any order placed will track the price of the order in the customer's chosen currency. It will also track the current exchange rate between that currency and the store's base currency. Whenever a report is run the order total prices will be converted using this exchange rate. This means that they can all be automatically presented in the single base currency of the store.

## Currency Exchange Rates

Umbraco Commerce uses an `ICurrencyExchangeRateService` to retrieve the most up-to-date rate to be able to track the current exchange rate. This is done for each individual order.

Out of the box, Umbraco Commerce comes with a number of available services you can choose to use. Some are free services, whilst others require a paid subscription.

* **ExchangeRatesApiCurrencyExchangeRateService** uses the free [exchangeratesapi.io](https://exchangeratesapi.io/) API and is the default option.
* **FixerCurrencyExchangeRateService** uses the [fixer.io](https://fixer.io/) API which is a reliable paid option (with a reasonable free plan).
* **CurrencyLayerCurrencyExchangeRateService** uses the [currencylayer.com](https://currencylayer.com/) API which is another reliable paid option (with a reasonable free plan).

If you wish to change the currency exchange rate service used, you can do so via the [dependency injection](dependency-injection.md) approach. This is used to override the default service configuration. For services that require configuration to be passed in, such as service API keys, you'll need to use the factory-based override as follows:

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyServices(IUmbracoCommerceBuilder builder)
    {
        // Register the fixer tax service with your API key
        builder.Services.AddUnique<ICurrencyExchangeRateService>(new FixerCurrencyExchangeRateService("YOUR_FIXER_API_KEY"));
        
        // Return the builder to continue the chain
        return builder;
    }
}
```

## Historic Orders

Umbraco Commerce has a background service that will attempt to ensure that all historic orders without an exchange rate defined get updated. This is done in case the third-party APIs fail and we need a method of cleaning data. It is also done in case the store base currency is ever changed. In this case, we need to re-process all orders again with the newly selected base currency.

The currency exchange rate background task will run once every 24 hours or after 20 seconds after an app pool recycle.

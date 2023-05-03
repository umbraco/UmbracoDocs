---
title: Base Currency
description: Base Currency for standardized reporting in Vendr, the eCommerce solution for Umbraco
---

Within Vendr we have support for showing analytics reports, including summaries of sales figures. At the same time, Vendr also supports orders being placed in multiple currencies. Together these pose a problem of how to display a succinct sales figure, when the orders that make up those figures are placed in multiple currencies. The answer to this in Vendr is the store's **Base Currency**.

When you configure a store you will need to assign a base currency to it. This currency is ultimately there to identify which currency the store should use as it's basis for reports and sales figures regardless of whatever currency the order was placed in.

When a store has a base currency configured, from that point on, any order placed will not only track the price of the order in the customers chosen currency, but also the current exchange rate between that currency and the stores base currency. By doing this, whenever a report is run in Vendr, the order total prices will be converted using this exchange rate such that they can all be automatically presented in the single base currency of the store.

## Currency Exchange Rates

In order for Vendr to track the current exchange rate of the orders currency, an `ICurrencyExchangeRateService` is used to connect to a 3rd party exchange rates API to retrieve the most up to date rate. Out of the box, Vendr comes with a number of available services you can choose to use. Some are free services, whilst others require a paid subscription.

* **ExchangeRatesApiCurrencyExchangeRateService** uses the free [exchangeratesapi.io](https://exchangeratesapi.io/) API and is the default option OTB.
* **FixerCurrencyExchangeRateService** uses the [fixer.io](https://fixer.io/) API which is a very popular and reliable paid for option (with a reasonable free plan).
* **CurrencyLayerCurrencyExchangeRateService** uses the [currencylayer.com](https://currencylayer.com/) API which is another very popular and reliable paid for option (with a reasonable free plan).

If you wish to change the currency exchange rate service used at any time you can do so via the [dependency injection](../dependency-injection/) approach of overriding the default service configuration. For services that require configuration to be passed in, such as service API keys, you'll need to use the factory based override as follows.

````csharp
public static class VendrBuilderExtensions
{
    public static IVendrBuilder AddMyServices(IVendrBuilder builder)
    {
        // Register the fixer tax service with your API key
        builder.Services.AddUnique<ICurrencyExchangeRateService>(new FixerCurrencyExchangeRateService("YOUR_FIXER_API_KEY"));
        
        // Return the builder to continue the chain
        return builder;
    }
}
````

## Historic Orders

As well as setting the exchange rate of an order at the point of purchase, Vendr also has a background service that will attempt to ensure that all historic orders without an exchange rate defined get updated. The reason for this is because sometimes 3rd party API's fail and so we need a method of cleaning data if this is the case, and also because if the store base currency is ever changed, then we need to re-process all orders again with the newly selected base currency.

The currency exchange rate background task will run once every 24 hours or after 20 seconds after an app pool recycle.
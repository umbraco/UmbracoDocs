---
description: >-
  Currency Exchange Rate Service Provider for currency conversion in Umbraco
  Commerce.
---

# Currency Exchange Rate Service Provider

Umbraco Commerce can track the current exchange rate of orders compared to the stores [Base Currency](base-currency.md). This is necessary to produce reports and analytics in a single currency.

### Currency Exchange Rate Services

Umbraco Commerce uses an `ICurrencyExchangeRateService` to retrieve the most up-to-date rate and track the current exchange rate. This is done for each order.

Out of the box, Umbraco Commerce comes with a number of available services you can choose to use. Some are free services, while others require a paid subscription.

* **ExchangeRateHostCurrencyExchangeRateService** uses the free [exchangerate.host](https://exchangerate.host/) API.
* **ExchangeRatesApiCurrencyExchangeRateService** uses the free [exchangeratesapi.io](https://exchangeratesapi.io/) API.
* **FixerCurrencyExchangeRateService** uses the [fixer.io](https://fixer.io/) API which is a reliable paid option (with a reasonable free plan).
* **CurrencyLayerCurrencyExchangeRateService** uses the [currencylayer.com](https://currencylayer.com/) API which is another reliable paid option (with a reasonable free plan).

If you are using multiple currencies in your store then you should sign up for and configure an exchange rate service to ensure accurate reporting. You can do so via the [dependency injection](dependency-injection.md) approach. This is used to override the default service configuration. For services that require configuration to be passed in, such as service API keys, you'll need to use the factory-based override as follows:

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

If you have multiple currencies enabled but have not configured an exchange rate service, Umbraco Commerce will display a warning. This alert appears on the store dashboard and analytics section, indicating that the reported data may be inaccurate.

![No Exchange Rate Service Provider Warning](../.gitbook/assets/no-exchange-rate-provider.png)

### Historic Orders

Umbraco Commerce has a background service that will attempt to ensure that all historic orders without an exchange rate defined get updated. This is done in case the third-party APIs fail and we need a method of cleaning data. It is also done in case the store base currency is ever changed. In this case, we need to re-process all orders again with the newly selected base currency.

The currency exchange rate background task will run once every 24 hours or after 20 seconds after an app pool recycle.

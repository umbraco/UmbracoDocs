---
description: Base Currency for standardized reporting in Umbraco Commerce.
---

# Base Currency

Within Umbraco Commerce we have support for showing analytics reports, including summaries of sales figures. At the same time, Umbraco Commerce also supports orders being placed in multiple currencies. These pose a problem of how to display a succinct sales figure when the orders are placed in multiple currencies. The answer to this is the store's **Base Currency**.

When you configure a store you need to assign a base currency to it. This currency is there to identify which currency the store should use as its basis for reports and sales figures. This will be used regardless of whatever currency the order was placed in.

When a store has a base currency configured, any order placed will track the price of the order in the customer's chosen currency. It will also track the current exchange rate between that currency and the store's base currency. Whenever a report is run the order total prices will be converted using this exchange rate. This means that they can all be automatically presented in the single base currency of the store.

## Currency Exchange Rate Services

Umbraco Commerce uses an `ICurrencyExchangeRateService` to retrieve the most up-to-date rate and track the current exchange rate. For more details on configuring an exchange rate service, see the [Currency Exchange Rate Service Providers](./currency-exchange-rate-service-providers.md) article.
---
description: Realtime sales tax features via Sales Tax Providers in Umbraco Commerce.
---

# Sales Tax Providers

Sales Tax Providers are how Umbraco Commerce can perform real-time sales tax operations. Their job is to provide a standard interface between third-party sales tax operators and Umbraco Commerce. This is done to allow the passing of information between the two platforms.

How the integrations work is often different for each sales tax operator. The Umbraco Commerce Sales Tax Providers add a flexible interface that should work with most sales tax operators.

## Example Sales Tax Provider

An example of a bare-bones Sales Tax Provider would look something like this:

```csharp
[SalesTaxProvider("my-sales-tax-provider-alias")]
public class MySalesTaxProvider :  SalesTaxProviderBase<MySalesTaxProviderSettings>
{
    public MySalesTaxProvider(UmbracoCommerceContext umbracoCommerce)
        : base(umbracoCommerce)
    { }

    ...
}

public class MySalesTaxProviderSettings
{
    [SalesTaxProviderSetting]
    public string ApiKey { get; set; }

    ...
}

```

All Sales Tax Providers inherit from a base class `SalesTaxProviderBase<TSettings>`. `TSettings` is the type of a Plain Old Class Object (POCO) model class representing the Sales Tax Providers settings. The class must be decorated with `SalesTaxProviderAttribute` which defines the Sales Tax Providers `alias`.

The settings class consists of a series of properties, each decorated with a `SalesTaxProviderSettingAttribute`. These will all be used to dynamically build an editor interface for the given settings in the backoffice.

Labels and descriptions for providers and their settings are controlled through [Localization](#localization) entries.

## Sales Tax Provider Responsibilities

The responsibilities of a Sales Tax Provider are:

* **Realtime Rates** - Calculating sales tax rate options for a given Order.

### Realtime Rates

Real-time rates are returned by implementing the `CalculateSalesTaxAsync` method. To facilitate rate calculation, a `SalesTaxProviderContext` object is passed to this method providing useful, contextual information, including:

* **Order** - The Order and its items to be shipped.
* **OrderCalculation** - The current order calculation state.
* **FromAddress** - The address from which shipments will be shipped from.
* **ToAddress** - The address to which shipments will be shipped to.
* **Settings** - The sales tax provider settings are captured via the backoffice UI.
* **AdditionalData** - A general dictionary store for any data that may need passing between methods.
* **HttpContext** - A reference to the current HTTP context.

Implementors should use these details to pass to the 3rd party sales tax operators API and retrieve the sales tax costs. These should then be returned to Umbraco Commerce as a `SalesTaxCalculationResult` which contains an `Amount` property for the total sales tax amount.

## Localization

When displaying your provider in the backoffice UI, it is neceserray to provide localizable labels. This is controlled by Umbraco's [UI Localization](https://docs.umbraco.com/umbraco-cms/extending/language-files/ui-localization) feature.

Umbraco Commerce will automatically look for the following entries:

| Key                                                                            |  Description |
|--------------------------------------------------------------------------------| --- |
| `ucSalesTaxProviders_{providerAlias}Label`                             | A main label for the provider |
| `ucSalesTaxProviders_{providerAlias}Description`                       | A description for the provider |
| `ucSalesTaxProviders_{providerAlias}Settings{settingAlias}Label`       | A label for a provider setting |
| `ucSalesTaxProviders_{providerAlias}Settings{settingAlias}Description` | A description for a provider setting |

Here `{providerAlias}` is the alias of the provider and `{settingAlias}` is the alias of a setting.

---
description: Realtime shipping features via Shipping Providers in Umbraco Commerce.
---

# Shipping Providers

Shipping Providers are how Umbraco Commerce can perform real-time shipping operations. Their job is to provide a standard interface between third-party shipping operators and Umbraco Commerce. This is done to allow the passing of information between the two platforms.

How the integrations work is often different for each shipping operator. The Umbraco Commerce Shipping Providers add a flexible interface that should work with most shipping operators.

## Example Shipping Provider

An example of a bare-bones Shipping Provider would look something like this:

```csharp
[ShippingProvider("my-shipping-provider-alias")]
public class MyShippingProvider :  ShippingProviderBase<MyShippingProviderSettings>
{
    public MyShippingProvider(UmbracoCommerceContext umbracoCommerce)
        : base(umbracoCommerce)
    { }

    ...
}

public class MyShippingProviderSettings
{
    [ShippingProviderSetting]
    public string ApiKey { get; set; }

    ...
}

```

All Shipping Providers inherit from a base class `ShippingProviderBase<TSettings>`. `TSettings` is the type of a Plain Old Class Object (POCO) model class representing the Shipping Provider's settings. The class must be decorated with `ShippingProviderAttribute` which defines the Shipping Providers `alias`.

### Shipping Provider Settings
The settings class consists of a series of properties, each decorated with a `ShippingProviderSettingAttribute`. These attributes are used to dynamically build an editor interface for the settings in the backoffice.

Labels and descriptions for providers and their settings are controlled through [Localization](#localization) entries.

{% hint style="info" %}
The **Validate Shipping Provider Settings** feature is available in Umbraco Commerce 16.4.0 and later
{% endhint %}

Umbraco Commerce supports validating shipping provider settings by using `System.ComponentModel.DataAnnotations.ValidationAttribute`.

```csharp
public class MyShippingProviderSettings
{
    [System.ComponentModel.DataAnnotations.Required] // Validation Attribute
    [System.ComponentModel.DataAnnotations.StringLength(100)] // Validation Attribute
    [ShippingProviderSetting(SortOrder = 100)]
    public string ContinueUrl { get; set; }
    ...
}
```
## Shipping Provider Responsibilities

The responsibilities of a Shipping Provider are:


* **Realtime Rates** - Calculating shipping rate options for a given Order.

### Realtime Rates

Real-time rates are returned by implementing the `GetShippingRatesAsync` method. To facilitate rate calculation, a `ShippingProviderContext` object is passed to this method providing useful, contextual information, including:

* **Order** - The Order and its items to be shipped.
* **MeasurementSystem** - The measurement system of the Store associated with the given Order.
* **Packages** - A list of packages that make up this shipment. Each package contains a reference of the order lines it contains, its overall dimensions and weight, and both sender and receiver address details. See the [Shipping Package Factories documentation](./shipping-package-factories.md) for more details on how these are created.
* **Settings** - The shipping provider settings are captured via the backoffice UI.
* **AdditionalData** - A general dictionary store for any data that may need passing between methods.
* **HttpContext** - A reference to the current HTTP context.

Implementors should use these details to pass to the 3rd party shipping operators API and retrieve the estimated shipping costs. These should then be returned to Umbraco Commerce as a `ShippingRatesResult` which contains a `IEnumerable<ShippingRate> Rates` property. A `ShippingRate` value for each carrier/service returned by the operator should be supplied. A `ShippingRate` consists of the following properties:

* **Option** - A `ShippingOption` instance, which consists of an `Id` and `Name` property for the given shipping service.
* **PackageId** - The ID of the package from the `ShippingProviderContext` that this rate is associated with.
* **Value** - A `Price` value for this rate.

## Localization

When displaying your provider in the backoffice UI, it is neceserray to provide localizable labels. This is controlled by Umbraco's [UI Localization](https://docs.umbraco.com/umbraco-cms/extending/language-files/ui-localization) feature.

Umbraco Commerce will automatically look for the following entries:

| Key |  Description |
| --- | --- | 
| `ucShippingProviders_{providerAlias}Label` | A main label for the provider |
| `ucShippingProviders_{providerAlias}Description` | A description for the provider |
| `ucShippingProviders_{providerAlias}Settings{settingAlias}Label` | A label for a provider setting |
| `ucShippingProviders_{providerAlias}Settings{settingAlias}Description` | A description for a provider setting |

Here `{providerAlias}` is the alias of the provider and `{settingAlias}` is the alias of a setting.
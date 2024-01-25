---
description: Realtime shipping features via Shipping Providers in Umbraco Commerce.
---

# Shipping Providers

Shipping Providers are how Umbraco Commerce is able to perform realtime shipping opperations. Their job is to provide a standard interface between third-party shipping opperators and Umbraco Commerce itself. This is done in order to allow the passing of information between the two platforms.

How the integrations work is often different for each shipping opperator. The Umbraco Commerce Shipping Providers add a flexible interface that should be able to work with most shipping opperators.

## Example Shipping Provider

An example of a bare-bones Shipping Provider would look something like this:

```csharp
[ShippingProvider("my-shipping-provider-alias", "My Shipping Provider Name", "My Shipping Provider Description")]
public class MyShippingProvider :  ShippingProviderBase<MyShippingProviderSettings>
{
    public MyShippingProvider(UmbracoCommerceContext umbracoCommerce)
        : base(umbracoCommerce)
    { }

    ...
}

public class MyShippingProviderSettings
{
    [ShippingProviderSetting(Name = "API Key", 
        Description = "The API key to the shipping opperators API",
        SortOrder = 100)]
    public string ApieKey { get; set; }

    ...
}

```

All Shipping Providers inherit from a base class `ShippingProviderBase<TSettings>`. `TSettings` is the type of a Plain Old Class Object (POCO) model class representing the Shipping Providers settings. The class must be decorated with `ShippingProviderAttribute` which defines the Shipping Providers `alias`, `name` and `description`, and can also specify an `icon` to be displayed in the Umbraco Commerce backoffice.

The settings class consists of a series of properties, each decorated with a `ShippingProviderSettingAttribute` defining a name, description, and possible angular editor view file. These will all be used to dynamically build an editor interface for the given settings in the backoffice.

## Shipping Provider Responsibilities

There responsibilities of a Shipping Provider are:

* **Realtime Rates** - Calculating shipping rate options for a given Order.

### Realtime Rates

Realtime rates are returned by implementing the `GetShippingRatesAsync` method. In order to facilitate rate calculation, a `ShippingProviderContext` object is passed to this method providing useful, contextual information, including:

* **Order** - The Order and it's items to be shipped.
* **MeasurementSystem** - The measurement system of the Store associated with the given Order.
* **Packages** - A list of packages that make up this shippment. Each package contains a reference of the order lines it contains, it's overall dimensions and weight and both a sender and receiver address details. See the [Shipping Package Factories documentation](./shipping-package-factories.md) for more details on how these are created.
* **Settings** - The shipping provider settings captured via the backoffice UI.
* **AdditionalData** - A general dictionary store for any data that may need passing between methods.
* **HttpContext** - A reference to the current HTTP context.

Implementors should use these details to pass to the 3rd party shipping opperators API and retrieve the estimated shipping costs. These should then be returned to Umbraco Commerce as a `ShippingRatesResult` which contains a `IEnumerable<ShippingRate> Rates` property. A `ShippingRate` value for each carrier / service returned by the opperator should be supplied. A `ShippingRate` consists of the following properties:

* **Option** - A `ShippingOption` instance, which consists of an `Id` and `Name` property for the given shipping service.
* **PackageId** - The ID of the package from the `ShippingProviderContext` that this rate is associated with.
* **Value** - A `Price` value for this rate.


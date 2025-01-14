---
description: Realtime shipping features via Shipping Providers in Umbraco Commerce.
---

# Shipping Providers

Shipping Providers are how Umbraco Commerce can perform real-time shipping operations. Their job is to provide a standard interface between third-party shipping operators and Umbraco Commerce. This is done to allow the passing of information between the two platforms.

How the integrations work is often different for each shipping operator. The Umbraco Commerce Shipping Providers add a flexible interface that should work with most shipping operators.

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
    public string ApiKey { get; set; }

    ...
}

```

All Shipping Providers inherit from a base class `ShippingProviderBase<TSettings>`. `TSettings` is the type of a Plain Old Class Object (POCO) model class representing the Shipping Provider's settings. The class must be decorated with `ShippingProviderAttribute` which defines the Shipping Providers `alias`, `name` and `description`, and can also specify an `icon` to be displayed in the Umbraco Commerce backoffice.

The settings class consists of a series of properties, each decorated with a `ShippingProviderSettingAttribute` defining a name, description, and possible angular editor view file. These will all be used to dynamically build an editor interface for the given settings in the backoffice.

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


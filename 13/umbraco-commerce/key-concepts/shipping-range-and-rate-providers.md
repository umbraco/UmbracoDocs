---
description: Dynamic shipping rate providers in Umbraco Commerce.
---

# Shipping Rate Range / Rate Providers

With Umbraco Commerce's dynamic shipping rates feature it is possible to configure diffrent rules for calculating an orders shipping rate. With the Shipping Rate Range Provider and Shipping Rate Provider feature, it is possible to extend these rules with your own logic.

## Shipping Rate Range Provider

The role of a Shipping Rate Range Provider is to define a unit from which to calculate shipping rates (ie, weight, subtotal, etc), and then to determine within what range of values a given order falls within. It is also responsible for defining what editor view to use when entering range values in the UI.

### System Shipping Rate Ranger Providers

Out of the box Umbraco Commerce ships with the following Shipping Rate Range Providers:

* **Subtotal** - Determines whether an orders subtotal falls within a given range.
* **Weight** - Determines whether an orders overall weight falls within a given range.

### Custom Shipping Rate Range Providers

Should you wish to define some other unit on which to calculate rates upon, you can create your own Shipping Rate Range Providers by implementing the `ShippingRateRangeProvider<TRangeModel>` base class.

```csharp
[ShippingRateRangeProvider("myunit", "My Unit",
    editorView: "/App_Plugins/UmbracoCommerceExt/backoffice/views/myunit.html",
    sortOrder: 30)]
public class MyShippingRateRangeProvider : ShippingRateRangeProvider<decimal?>
{
    public override Attempt<int> TryFindRangeIndex(ShippingRateRangeCalculationContext<decimal?> ctx)
    {
        // Use the ctx.Ranges property to find the index that that ctx.Order falls within
        // return Attempt.Succeed(index);
    }
}
```

The class should be decorated with the `ShippingRateRangeProviderAttribute` which defines an alias, name, description, editor view and label view for the provider. It implementes  a single method `TryFindRangeIndex` which, given a `ShippingRateRangeCalculationContext`, should find the index the current order falls within a series of preconfigured ranges created via the UI. The `ShippingRateRangeCalculationContext` contains a series of useful properties which you can use to form your calculation.

* **Ranges** - A list of configured ranges from the UI from which to find the index of the given order.
* **Order** - The order to use when finding the current range.
* **Store** - The store the order belongs to.
* **Currency** - The given currency of the order.
* **TaxRate** - The tax rate for the shipping method.
* **Packages** - A list of packages created for this shipment.
* **OrderCalculation** - The current in progress order calculation, should there be one.

#### Registering your custom Shipping Rate Range Provider

Shipping Rate Range Providers are automatically added by type so there is no specific registration code you need to implement. By inheritting from the `ShippingRateRangeProvider<TRangeModel>` base class, Umbraco Commerce will automatically load your implementation and add it to the Shipping Rate Range Providers collection.

## Shipping Rate Provider

The role of a Shipping Rate Provider is to provide a specific rate calculation. Each range defined in a dynamic shipping method configuration can contain multiple Shipping Rate Provider configurations, allowing you to build up more advanced calculation logic. The set of rate providers to use in a given calculation is determined by the index returned from the Shipping Rate Range Provider.

### System Shipping Rate Providers

Out of the box Umbraco Commerce ships with the following Shipping Rate Providers:

* **PricePerOrder** - Defines a fixed price to apply per order.
* **PricePerOrderItem** - Defines a fixed price multiplied by the total number of items in the order.
* **PricePerOrderWeightUnit** - Defines a fixed price multiplied by the total order weight.
* **OrderSubtotalPercentage** - Define a percentage of the order subtotal to apply.

### Custom Shipping Rate Providers

Should you wish to define some other rate calculation logic, you can create your own Shipping Rate Providers by implementing the `ShippingRateProvider<TConfigModel>` base class.

```csharp
[ShippingRateProvider("myrate", "My Rate",
    editorView: "/App_Plugins/UmbracoCommerceExt/backoffice/views/myrate.html",
    sortOrder: 30)]
public class MyShippingRateProvider : ShippingRateProvider<int>
{
    public override Attempt<Price> TryGetRate(ShippingRateCalculationContext<int> ctx)
    {
        // Use the context parameter to calculate a rate ammount
        // return Attempt.Succeed(Price.Calculate(amount, ctx.TaxRate, ctx.Currency.Id, ctx.Store.PricesIncludeTax));
    }
}
```

The class should be decorated with the `ShippingRateProviderAttribute` which defines an alias, name, description, editor view and label view for the provider. It implementes a single method `TryGetRate` which, given a `ShippingRateCalculationContext`, should calculate the relevant rate. The `ShippingRateCalculationContext` contains a series of useful properties which you can use to form your calculation.

* **Model** - The value for this rate provider captured from the UI.
* **Order** - The order associated with this calculation.
* **Store** - The store the order belongs to.
* **Currency** - The given currency of the order.
* **TaxRate** - The tax rate for the shipping method.
* **Packages** - A list of packages created for this shipment.
* **OrderCalculation** - The current in progress order calculation, should there be one.

#### Registering your custom Shipping Rate Provider

Shipping Rate Providers are automatically added by type so there is no specific registration code you need to implement. By inheritting from the `ShippingRateProvider<TConfigModel>` base class, Umbraco Commerce will automatically load your implementation and add it to the Shipping Rate Providers collection.

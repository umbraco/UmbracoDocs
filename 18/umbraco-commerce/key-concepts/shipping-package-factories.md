---
description: Creating Order Packages in Umbraco Commerce.
---

# Shipping Package Factories

When calculating shipping rates, defining how an order is packaged is necessary. This includes the dimensions/weight of that package as well as the location from which and to which the package will be sent. All of this is the responsibility of the Shipping Package Factory to calculate.


## Stacked Shortest Dimension Package Factory

The out-of-the-box Package Factory that ships with Umbraco Commerce is the Stacked Shortest Dimension Package Factory. This factory works by aggregating the physical dimensions of each item in an order by stacking them on their shortest dimension. From there, we get the overall height of the package, with the length and width calculated as the maximum dimension of any order item.


The receiver address of the package is calculated from the order, with the sender address being the address of the default location for a store.

The Stacked Shortest Dimension Package Factory currently only supports returning a single package containing the entire contents of the order.

{% hint style="info" %}
Umbraco Commerce currently supports only package factories returning a single package. Supporting multiple packages will come as a future feature.

{% endhint %}

### Limitations

There are some limitations of the Stacked Shortest Dimension Package Factory that you may need to take into account:

* Assumes items can be stacked in any orientation
* Doesn't optimize for spreading items out in a box, only stacking into a single stack.

## Custom Package Factory

Given the limitations of the Stacked Shortest Dimension Package Factory, it may become necessary to implement your own packaging algorithm. This can be achieved by implementing your package factory class and swapping out the default one in the DI container.

To implement your own package factory you need to implement the `ShippingPackageFactoryBase` class and implement the `CreatePackagesAsync` method.

```csharp
public class MyPackageFactory : ShippingPackageFactoryBase
{
    public MyPackageFactory(UmbracoCommerceContext umbracoCommerce)
        : base(umbracoCommerce)
    { }

    public override Task<IEnumerable<Package>> CreatePackagesAsync(ShippingMethodReadOnly shippingMethod, OrderReadOnly order)
    {
        // Calculate and return packages
    }
}
```

From within this method you can use whatever logic you need to create packages and calculate their dimensions.

To replace the default factory, register your factory implementation with the DI container in its place. See the [Replacing Dependencies documentation](../key-concepts/dependency-injection.md#replacing-dependencies) for more details.


```csharp
builder.Services.AddUnique<IShippingPackageFactory, MyPackageFactory>();
```
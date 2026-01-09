---
description: >-
  Define when a Discount should apply and what should be the Reward in Umbraco
  Commerce.
---

# Discount Rules / Rewards

Discounts in Umbraco Commerce are defined using a series of rules and reward builders that let you configure the following:

* When a Discount should apply.
* What the Reward should be for that Discount.

These builders come with a handful of the most common Rules and Rewards that should suit the majority of web stores' needs. When need to create your own Rules or Rewards then these are extendable via a Provider model allowing you to incorporate your own custom logic.

## Discount Rules

There are two types of Discount Rules in Umbraco Commerce:

* **Order Discount Rules**: Determine whether a discount should apply to an Order. Returns a Fulfilled/Unfulfilled status depending on whether the Rule logic has been met.
* **Order Line Discount Rules**: Determine whether a discount should apply to an Order Line within an Order. Returns a Fulfilled/Unfulfilled status depending on whether the Rule logic has been met. Where the status is Fulfilled, a list of all Order Lines that are fulfilled by this Rule is also returned.

### Example: Custom Order Discount Rule Provider

An example of an Order Discount Rule Provider would look something like this:

```csharp
[DiscountRuleProvider("myCustomOrderRule", "My Custom Order Rule")]
public class MyCustomOrderRuleProvider : OrderDiscountRuleProviderBase<MyCustomOrderRuleProviderSettings>
{
    public override DiscountRuleResult ValidateRule(DiscountRuleContext ctx, MyCustomOrderRuleProviderSettings settings)
    {
        if (/* Some custom logic */)
            return Fulfilled();
        
        return Unfulfilled();
    }
}

public class MyCustomOrderRuleProviderSettings
{
    [DiscountRuleProviderSetting(Key = "priceType",
        Name = "Price Type",
        Description = "The type of price to compare against")]
    public OrderPriceType PriceType { get; set; }

    ...
}

```

All Order Discount Rule Providers inherit from a base class `OrderDiscountRuleProviderBase<TSettings>`. `TSettings` is the type of a Plain Old Class Object (POCO) model class representing the Discount Rule Providers settings.

{% hint style="info" %}
See the [Settings Objects](discount-rules-and-rewards.md#settings-objects) section below for more information on Settings objects.
{% endhint %}

The class must be decorated with `DiscountRuleProviderAttribute` which defines the Discount Rule Providers `alias` and `name`, and can also specify a `description` or `icon` to be displayed in the backoffice. The `DiscountRuleProviderAttribute` is also responsible for defining a `labelView` for the Provider.

{% hint style="info" %}
See the [Label views](discount-rules-and-rewards.md#label-views) section below for more information on Label Views.
{% endhint %}

Rule Providers have a `ValidateRule` method that accepts a `DiscountRuleContext` as well as an instance of the Providers `TSettings` settings model. Inside this you can perform your custom logic, returning a `DiscountRuleResult` to notify Umbraco Commerce of the Rule outcome.

If the passed-in context (which contains a reference to the Order) meets the Rule's criteria, then a fulfilled `DiscountRuleResult` can be returned by calling `return Fulfilled();`. Alternatively, if the Order didn't meet the Rules criteria an unfulfilled `DiscountRuleResult` can be returned by calling `return Unfulfilled();`.

### Example: Custom Order Line Discount Rule Provider

An example of an Order Line Discount Rule Provider would look something like this:

```csharp
[DiscountRuleProvider("myCustomOrderLineRule", "My Custom Order Line Rule")]
public class MyCustomOrderLineRuleProvider : OrderLineDiscountRuleProviderBase<MyCustomOrderLineRuleProviderSettings>
{
    public override DiscountRuleResult ValidateRule(DiscountRuleContext ctx, MyCustomOrderLineRuleProviderSettings settings)
    {
        if (/* Some custom logic */)
            return Fulfilled(fulfilledOrderLines);
        
        return Unfulfilled();
    }
}

public class MyCustomOrderLineRuleProviderSettings
{
    [DiscountRuleProviderSetting(Key = "priceType",
        Name = "Price Type",
        Description = "The type of price to compare against")]
    public OrderPriceType PriceType { get; set; }

    ...
}

```

All Order Line Discount Rule Providers inherit from a base class `OrderLineDiscountRuleProviderBase<TSettings>` and follows much the same requirements as the Order Discount Rule Provider defined above. Where they differ is in the `ValidateRule` method implementation and when a fulfilled `DiscountRuleResult` is returned. In this case, an Order Line Discount Rule returns a collection of Order Lines processed by the Rule that have met the rules criteria. Whether the rules are met, is checked by calling `return Fulfilled(fulfilledOrderLines);`.

## Discount Rewards

### Example: Custom Discount Reward Provider

An example of a Discount Reward Provider would look something like this:

```csharp
[DiscountRewardProvider("myDiscountReward", "My Discount Reward")]
public class MyDiscountRewardProvider : DiscountRewardProviderBase<MyDiscountRewardProviderSettings>
{
    public override DiscountRewardCalculation CalculateReward(DiscountRewardContext ctx, MyDiscountRewardProviderSettings settings)
    {
        var result = new DiscountRewardCalculation();

        // Some custom calculation logic goes here 

        return result;
    }
}

public class MyDiscountRewardProviderSettings
{
    [DiscountRewardProviderSetting(Key = "priceType",
        Name = "Price Type",
        Description = "The price that will be affected by this reward")]
    public OrderPriceType PriceType { get; set; }

    ...
}

```

All Discount Reward Providers inherit from a base class `DiscountRewardProviderBase<TSettings>`. `TSettings` is the Type of a POCO model class representing the Discount Reward Providers settings.

{% hint style="info" %}
See the [Settings Objects](settings-objects.md) documentation for more information on Settings objects.
{% endhint %}

The class must be decorated with `DiscountRewardProviderAttribute` which defines the Discount Reward Providers `alias` and `name`. It can also specify a `description` or `icon` to be displayed in the Umbraco Commerce backoffice. The `DiscountRewardProviderAttribute` is responsible for defining a `labelView` for the Provider.

{% hint style="info" %}
See the [Label views](discount-rules-and-rewards.md#label-views) section below for more information on Label Views.
{% endhint %}

Reward Providers have a `CalculateReward` method that accepts a `DiscountRewardContext` as well as an instance of the Providers `TSettings` settings model. Inside this, you can perform your custom calculation logic, returning a `DiscountRewardCalculation` instance that defines any Reward values to apply to the Order.

```csharp
// Add a shipping total discount
result.ShippingTotalPriceAdjustments.Add(new DiscountAdjustment(ctx.Discount, price));

// Add a subtotal discount
result.SubtotalPriceAdjustments.Add(new DiscountAdjustment(ctx.Discount, price));
```

## Common Features

### Settings Objects

{% hint style="info" %}
See the [Settings Objects](settings-objects.md) documentation for more information on Settings objects.
{% endhint %}

### Label Views

Both the `DiscountRuleProviderAttribute` and the `DiscountRewardProviderAttribute` allow you to define a `labelView` for the Provider. It should be the path to an Angular JS view file that will be used to render a label in the Rule/Reward Builder UI. Where no `labelView` is supplied, one will be looked for by convention at the following location:

`~/app_plugins/umbracocommerce/views/discount/{Type}/labelViews/{ProviderAlias}.html`

`Type` is either `rules` or `rewards`, depending on the Type of Provider it refers to. `ProviderAlias` is the alias of the Provider.

The Rule/Reward Label View should provide a user-friendly summary of its settings to display in the relevant Builder UI.

![Discount Rule Label Views](../.gitbook/assets/discount_rule_builder_label_views.png)

The Label View file will be passed a `model` property which will be a JavaScript representation of the given Providers settings object.

```html
<span ng-if="model.priceType">Order {{ model.priceType | umbracoCommerceSplitCamelCase }} Discount</span>

```

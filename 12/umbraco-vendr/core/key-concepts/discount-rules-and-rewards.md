---
title: Discount Rules / Rewards
description: Define when a Discount should apply and what should be the Reward in Vendr, the eCommerce solution for Umbraco
---

When creating Discounts in the Vendr back-office they are defined using a series of rule and reward builders that let you configure exactly when a Discount should apply and what exactly the Reward should be for that Discount.

Out of the box, these builders come with a handful of the most common Rules / Rewards that should suit the majority of web stores needs, however if you should need to create your own Rules / Rewards then these are extendable via a Provider model allowing you to incorporate your own custom logic.

## Discount Rules

There are two types of Discount Rules in Vendr and these are:

* **Order Discount Rules** - Determine whether a discount should apply to an Order, returning a Fulfilled/Unfulfilled status whether the Rule logic has been met.

* **Order Line Discount Rules** - Determine whether a discount should apply to an Order Line within an Order, returning a Fulfilled/Unfulfilled status whether the Rule logic has been met. Where the status is Fulfilled, a list of all Order Lines that are fulfilled by this Rule are also returned.

### Example Custom Order Discount Rule Provider

An example of an Order Discount Rule Provider would look something like this:

````csharp
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

````

All Order Discount Rule Providers inherit from a base class `OrderDiscountRuleProviderBase<TSettings>` where `TSettings` is the Type of a POCO model class representing the Discount Rule Providers settings.

<message-box type="info" heading="More on Settings Objects">

See the [Settings Objects](#settings-objects) section below for more information on Settings objects.

</message-box>

The class must be decorated with `DiscountRuleProviderAttribute` which defines the Discount Rule Providers `alias` and `name`, and can also specify a `description` or `icon` to be displayed in the Vendr back-office. The `DiscountRuleProviderAttribute` is also responsible for defining a `labelView` for the Provider.

<message-box type="info" heading="More on Label Views">

See the [Label views](#label-views) section below for more information on Label Views.

</message-box>

Rule Providers then have a `ValidateRule` method which accepts a `DiscountRuleContext` as well as an instance of the Providers `TSettings` settings model, inside which you can perform your custom logic, returning a `DiscountRuleResult` to notify Vendr of the Rule outcome.

If the passed in context (which contains a reference to the Order) meets the Rule's criteria, then a fulfilled `DiscountRuleResult` can be returned by calling `return Fulfilled();` or alternatively if the Order didn't meet the Rules criteria an unfulfilled `DiscountRuleResult` can be returned by calling `return Unfulfilled();`.

### Example Custom Order Line Discount Rule Provider

An example of an Order Line Discount Rule Provider would look something like this:

````csharp
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

````

All Order Line Discount Rule Providers inherit from a base class `OrderLineDiscountRuleProviderBase<TSettings>` and follows much the same requirements as the Order Discount Rule Provider defined above. Where they do differ though is in the `ValidateRule` method implementation and when a fulfilled `DiscountRuleResult` is returned, an Order Line Discount Rule should also return a collection of Order Lines processed by the Rule that have meet the rules criteria by calling `return Fulfilled(fulfilledOrderLines);`.


## Discount Rewards


### Example Custom Discount Reward Provider

An example of a Discount Reward Provider would look something like this:

````csharp
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

````

All Discount Reward Providers inherit from a base class `DiscountRewardProviderBase<TSettings>` where `TSettings` is the Type of a POCO model class representing the Discount Reward Providers settings.

<message-box type="info" heading="More on Settings Objects">

See the [Settings Objects](../settings-objects/) documentation for more information on Settings objects.

</message-box>

The class must be decorated with `DiscountRewardProviderAttribute` which defines the Discount Reward Providers `alias` and `name`, and can also specify a `description` or `icon` to be displayed in the Vendr back-office. The `DiscountRewardProviderAttribute` is also responsible for defining a `labelView` for the Provider.

<message-box type="info" heading="More on Label Views">

See the [Label views](#label-views) section below for more information on Label Views.

</message-box>

Reward Providers then have a `CalculateReward` method which accepts a `DiscountRewardContext` as well as an instance of the Providers `TSettings` settings model, inside which you can perform your custom calculation logic, returning a `DiscountRewardCalculation` instance which defines any Reward values to apply to the Order.

````csharp
// Add a shipping total discount
result.ShippingTotalPriceAdjustments.Add(new DiscountAdjustment(ctx.Discount, price));

// Add a subtotal discount
result.SubtotalPriceAdjustments.Add(new DiscountAdjustment(ctx.Discount, price));
````

## Common Features

### Settings Objects

<message-box type="info" heading="More on Settings Objects">

See the [Settings Objects](../settings-objects/) documentation for more information on Settings objects.

</message-box>

### Label Views

Both the `DiscountRuleProviderAttribute` and the `DiscountRewardProviderAttribute` required by Rule/Reward Providers allow you to define a `labelView` for the Provider which should be the path to an Angular JS based view file that will be used to render a label in the Rule/Reward Builder UI. Where no `labelView` is supplied, one will be looked for by convention at the following location:

`~/app_plugins/vendr/views/discount/{Type}/labelViews/{ProviderAlias}.html`

`Type` is either `rules` or `rewards`, depending on the Type of Provider it refers to, and `ProviderAlias` is the alias of the Provider.

The Rule/Reward Label View should provide a user friendly summary of it's settings to display in the relevant Builder UI.

![Discount Rule Label Views](../media/discount_rule_builder_label_views.png)

The Label View file will be passed a `model` property which will be a JavaScript representation of the given Providers settings object.

````html
<span ng-if="model.priceType">Order {{ model.priceType | vendrSplitCamelCase }} Discount</span>

````


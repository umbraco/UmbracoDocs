---
title: Order Calculation State
description: Calculation context in Vendr, the eCommerce solution for Umbraco
---

When extending the calculation process of Vendr, either by custom [calculators](../calculators/) or custom [pipeline tasks](../pipelines/) it is important to be aware of the `OrderCalculation` object.

## The Calculation Process

When an order asks to be re-calculated, this triggers a calculation pipeline which in turn runs a series of calculation tasks. It then calls a number of extendable calculators in order to work out the orders different prices. Throughout this process Vendr needs to keep track of all these prices as they change. At the same time it also needs to ensure that the calculation is transactional in case something goes wrong. To accomplish both of these requirements we use a temporary state object called `OrderCalculation` to store all the information. Only at the end of the calculation, if everything was successful, we copy those calculated prices back to the order.

## Accessing Price Values

In the different calculation extension points Vendr will often pass you **both** an `Order` object and the `OrderCalculation` object. We pass the order so that you can get access to any information held on it that you may need for calculations, such as custom properties. This shouldn't be used for accessing any price related values of the order.

As mentioned above, in order to maintain data integrity during the calculation process, the order itself is not updated until the end. This means that any calculations based on the order entities price values would be based on the orders **previously calculated price values**.

In order to base your calculation on the current calculated price values you should instead access the `OrderCalculation` object.

## The OrderCalculation Object

````csharp
public class OrderCalculation
{
    public Dictionary<Guid, OrderLineCalculation> OrderLines { get; }

    public Dictionary<string, Amount> GiftCardAmounts { get; }

    public List<string> FulfilledDiscountCodes { get; }

    public List<FulfilledDiscount> FulfilledDiscounts { get; }

    public TaxRate TaxRate { get; set; }

    public OrderSubtotalPrice SubtotalPrice { get; set; }

    public TaxRate ShippingTaxRate { get; set; }

    public TotalPrice ShippingTotalPrice { get; set; }

    public TaxRate PaymentTaxRate { get; set; }

    public TotalPrice PaymentTotalPrice { get; set; }

    public OrderTotalPrice TotalPrice { get; set; }
}

public class OrderLineCalculation
{
    public Dictionary<Guid, OrderLineCalculation> OrderLines { get; }

    public TaxRate TaxRate { get; set; }

    public OrderLineUnitPrice UnitPrice { get; set; }

    public OrderLineTotalPrice TotalPrice { get; set; }

    public Price RollingSubOrderLinesTotalPrice { get; set; }

    public Price RollingSubOrderLinesTotalDiscountPrice { get; set; }
}
````

From the `OrderCalculation` object you can access the different order prices, including order line calculations. The order line calculations are stored in a dictionary where key is the order lines ID, and value is an `OrderLineCalculation` object holding the calculated prices.

By using the prices from the `OrderCalculation` object you can ensure that your calculation is based on the most up to date values for the order.

{% hint style="info" %}
If your values are based on another price held on an order and you have access to an `OrderCalculation` object that isn't `null`, then **always** base your price on the `OrderCalculation` object's price values. It should also only fall back to the order entity if there is no `OrderCalculation` available.
{% endhint %}

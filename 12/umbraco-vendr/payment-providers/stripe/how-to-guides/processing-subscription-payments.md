---
title: How to Process Subscription Payments
description: >-
  Learn how to process subscription payments when using the Stripe payment
  provider in Umbraco Vendr.
---

# How to Process Subscription Payments

The Stripe Checkout payment provider is built to support both one-time and subscription-based payments including a mixture of the two. Before processing subscription payments you need to know the specific configuration steps required as well as some important limitations.

## Umbraco Configuration

To process Subscription payments you first need to identify recurring products and define their recurring nature. This is done by adding the following properties to your product nodes:

| Name                           | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `isRecurring`                  | True/false flag to indicate whether the given product is recurring or not                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `stripePriceId`                | Identifies a [Stripe Price](https://stripe.com/docs/billing/prices-guide) to use for this item. If a Price ID is found, the Stripe product/price will be used and the order line price will effectively be ignored in favor of the price held in Stripe. Because of this, it's important to ensure these values stay in sync. Otherwise, the customer will see one price on checkout and another at the payment gateway. If no price ID is found, an ["ad-hoc"](https://stripe.com/docs/billing/prices-guide#ad-hoc) price will be created using the order lines' total price |
| `stripeProductId`              | Relevant only if you don't provide a Stripe Price ID, this will allow all ad-hoc prices to be associated with a single Stripe Product definition within Stripe. If a product ID is not found, then an ad-hoc product will be created per order                                                                                                                                                                                                                                                                                                                                |
| `stripeRecurringInterval`      | Relevant only if you don't provide a Stripe Price ID, this allows you to define the interval for the ad-hoc price created. Can be either `day`, `week`, `month` or `year`                                                                                                                                                                                                                                                                                                                                                                                                     |
| `stripeRecurringIntervalCount` | Relevant only if you don't provide a Stripe Price ID, this allows you to define the interval count. For example, if the interval is `month` and the interval count is `2` then the item will be billed every two months                                                                                                                                                                                                                                                                                                                                                       |

In addition to the product properties defined above, you also need to configure your Vendr Stores `Product Property Aliases` field to copy these product properties to the generated order line.

| Name                     | Value                                                                                                |
| ------------------------ | ---------------------------------------------------------------------------------------------------- |
| Product Property Aliases | `isRecurring, stripeRecurringInterval, stripeRecurringIntervalCount, stripePriceId, stripeProductId` |

With the properties defined the transactions will be converted to a subscription if the order has any order lines containing recurring items. If your order contains both recurring and non-recurring items then the order will be processed as a subscription transaction. In this case, the value of the non-recurring items will be added as an invoice line item to be paid on the initial transaction only.

## Limitations

There are a number of limitations when using the Stripe Checkout payment provider for subscription payments.

1. The `Capture` configuration setting is not supported by Subscription payments. All Subscription transactions will have their initial payment processed immediately. This includes any one-time fees defined on the initial invoice.
2. No matter the number of recurring items in an order, each transaction will result in only one subscription being created including all recurring items. You can't create a Subscription per order line. If you need to purchase multiple Subscriptions, these must be processed as individual transactions.
3. You can't have non-order line discounts or gift cards that result in the order total being less than the sum total of any recurring order lines. You can discount a recurring item as an order line discount rule (only if using ad-hoc prices, and the value remains above 0). You couldn't give a 10% order discount unless you have other non-recurring items that would cover the cost of this discount.
4. The Stripe payment provider is only responsible for processing the initial Stripe transaction. All other "Subscription" integrations such as enabling member access etc. will need to be custom developed using the [Stripe Software Development Kit (SDK)](https://github.com/stripe/stripe-dotnet) and your own [webhook handler](https://stripe.com/docs/webhooks).

{% hint style="info" %}
If you need a ready-to-use management portal to allow the management of your Subscriptions use the [Stripe Customer Portal](https://stripe.com/docs/billing/subscriptions/integrating-customer-portal). The Stripe payment provider already captures the required fields as order properties for you to access.
{% endhint %}

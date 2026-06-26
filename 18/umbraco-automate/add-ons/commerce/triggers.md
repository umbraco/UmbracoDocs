---
description: >-
  Reference for the triggers contributed by the Umbraco.Commerce.Automate
  add-on.
---

# Triggers

The Commerce add-on contributes the following triggers. Every trigger can be filtered to specific stores via the **Stores** setting — leave it blank to match every store.

## Order Triggers

| Display Name | Alias |
| ------------ | ----- |
| Order Created | `umbracoCommerce.orderCreated` |
| Order Finalized | `umbracoCommerce.orderFinalized` |
| Order Status Changed | `umbracoCommerce.orderStatusChanged` |
| Order Assigned to Customer | `umbracoCommerce.orderAssignedToCustomer` |
| Product Added to Order | `umbracoCommerce.productAddedToOrder` |

## Payment and Shipping Triggers

| Display Name | Alias |
| ------------ | ----- |
| Payment Method Changed | `umbracoCommerce.paymentMethodChanged` |
| Shipping Method Changed | `umbracoCommerce.shippingMethodChanged` |
| Country/Region Changed | `umbracoCommerce.countryRegionChanged` |
| Payment Updated | `umbracoCommerce.paymentUpdated` |

## Stock Trigger

| Display Name | Alias |
| ------------ | ----- |
| Stock Changed | `umbracoCommerce.stockChanged` |

## Discount and Gift Card Triggers

| Display Name | Alias |
| ------------ | ----- |
| Discount/Gift Card Code Redeemed | `umbracoCommerce.codeRedeemed` |
| Gift Card Created | `umbracoCommerce.giftCardCreated` |
| Discount Created | `umbracoCommerce.discountCreated` |

## Email Triggers

| Display Name | Alias |
| ------------ | ----- |
| Email Sent | `umbracoCommerce.emailSent` |
| Email Failed | `umbracoCommerce.emailFailed` |

{% hint style="info" %}
Each Commerce trigger emits the relevant store and entity details. Inspect a real run in the **Runs** view to see the exact field names, then use the binding picker to reference them in downstream steps.
{% endhint %}

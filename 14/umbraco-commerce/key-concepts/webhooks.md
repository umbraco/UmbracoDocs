---
description: Webhook configuration in Umbraco Commerce.
---

# Webhooks

## Webhooks

Umbraco Commerce makes use of the webhooks feature added in Umbraco v13. See the [Webhooks documentation](https://docs.umbraco.com/umbraco-cms/reference/webhooks) for general webooks configuration.

## Events

Umbraco Commerce triggers webhooks for the following events:

* **Order Finalized** - Triggered when an order is converted from a cart to an actual finalized order. This event is useful for notifying external systems of new orders.
* **Order Status Changed** - Triggered when the status of an order changes. This event is useful for notifying external systems when an order is ready to ship, or has been canceled.

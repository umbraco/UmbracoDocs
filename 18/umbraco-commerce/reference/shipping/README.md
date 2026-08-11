---
description: Shipping options in Umbraco Commerce.
---

# Shipping

Umbraco Commerce offers three different shipping method configurations for calculating shipping rates, which are:

### [Fixed Rate Shipping](./fixed-rate-shipping.md)

The fixed rate shipping option allows you to configure a single fixed rate for the whole of an order.

### [Dynamic Rate Shipping](./dynamic-rate-shipping.md)

The dynamic rate shipping option allows you to configure a series of ranges from which an order will be checked against. These checks identify a which range the order falls within. For each range a series of rate options can be configured. Options include fixed rate per order, a fixed rate per order item, percentage based rates amongst others.

### [Realtime Rate Shipping](./realtime-rate-shipping.md)

The realtime rate shipping option allows you to configure a connection to a shipping operator to fetch realtime shipping rate estimates for an order.

## Shipping Calculators

Should you wish to take more control over the shipping calculation process you can swap out the whole shipping calculator implementation. See the [Calculator documentation](../../key-concepts/calculators.md) for more details.
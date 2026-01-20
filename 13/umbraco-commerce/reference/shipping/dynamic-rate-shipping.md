---
description: Dynamic Rate Shipping in Umbraco Commerce.
---

# Dynamic Rate Shipping

Dynamic rate shipping in Umbraco Commerce allows you to define a series of ranges from which an order will be checked against. These checks find which range a given order falls within which in turn identifies the rates that apply. For each range, a series of rate options can be configured. Examples include a fixed rate per order, a fixed rate per order item, or percentage-based rates. By combining these configurable ranges, and different rating options it allows you to create a more dynamic algorithm than the basic fixed-rate shipping option.

## Configuration

* Go to `Settings > Commerce > Stores > {Your Store} > Shipping Methods`

![Shipping Methods](../../.gitbook/assets/shipping_methods.png)

* Click `Create Shipping Method`
* Choose the `Basic` shipping provider

![Choose Shipping Provider](../../.gitbook/assets/create_shipping_method.png)

* Chose the `Dynamic` calculation mode option

![Choose Shipping Calculation Mode](../../.gitbook/assets/create_shipping_method2.png)

* Populate the shipping method name, alias, sku and optional image and tax rate

![Shipping Method Details](../../.gitbook/assets/dynamic_rate_shipping_details.png)

* Choose the range unit to base the rates upon
* Click `Add Range` to define each range

![Shipping Method Rates](../../.gitbook/assets/dynamic_rate_shipping_rates.png)

* Populate the from and to value of the range
* Populate the rate details from the available rate options, leaving blank any option you don't wish to apply

![Shipping Method Rate](../../.gitbook/assets/dynamic_rate_shipping_rates_dialog.png)

* Configure the countries in this shipping method should be allowed in

![Shipping Method Allowed Countries](../../.gitbook/assets/shipping_method_allowed_countries.png)

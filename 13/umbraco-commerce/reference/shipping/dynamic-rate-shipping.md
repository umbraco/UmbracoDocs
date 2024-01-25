---
description: Dynamic Rate Shipping in Umbraco Commerce.
---

# Dynamic Rate Shipping

Dynamic rate shipping in Umbraco Commerce allows you to define a series of ranges from which an order will be checked against to see which range it falls within. For each range a series of rate options can be configured such as a fixed rate per order, a fixed rate per order item or percentage based rates. By combining these configurable ranges, and different rating options it allows you to create a more dynamic rate algorythm than the basic fixed rate shipping option.

## Configuration

* Go to `Settings > Commerce > Stores > {Your Store} > Shipping Methods`

![Shipping Methods](../../media/shipping_methods.png)

* Click `Create Shipping Method`
* Choose the `Basic` shipping provider

![Choose Shipping Provider](../../media/create_shipping_method.png)

* Chose the `Dynamic` calculation mode option

![Choose Shipping Calculation Mode](../../media/create_shipping_method2.png)

* Populate the shipping method name, alias, sku and optional image and tax rate

![Shipping Method Details](../../media/dynamic_rate_shipping_details.png)

* Choose the range unit to base the rates upon
* Click `Add Range` to define a each range

![Shipping Method Rates](../../media/dynamic_rate_shipping_rates.png)

* Populate the from and to value of the range
* Populate the rate details from the available rate options, leaving blank any option you don't wish to apply

![Shipping Method Rate](../../media/dynamic_rate_shipping_rates_dialog.png)

* Configure the countries this shipping method should be allowed in

![Shipping Method Allowed Countries](../../media/shipping_method_allowed_countries.png)
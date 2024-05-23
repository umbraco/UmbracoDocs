---
description: Fixed Rate Shipping in Umbraco Commerce.
---

# Fixed Rate Shipping

Fixed rate shipping in Umbraco Commerce allows you to define a single, fixed shipping rate to apply to an order. This is the simplest of all the shipping calculation options, but is also the least flexible.

## Configuration

* Go to `Settings > Commerce > Stores > {Your Store} > Shipping Methods`

![Shipping Methods](../../media/shipping_methods.png)

* Click `Create Shipping Method`
* Choose the `Basic` shipping provider

![Choose Shipping Provider](../../media/create_shipping_method.png)

* Chose the `Fixed` calculation mode option

![Choose Shipping Calculation Mode](../../media/create_shipping_method2.png)

* Populate the shipping method name, alias, sku and optional image and tax rate
* Enter a fixed rate for the shipping method

![Shipping Method Details](../../media/fixed_rate_shipping_details.png)

* Configure the countries this shipping method should be allowed in

![Shipping Method Allowed Countries](../../media/fixed_rate_shipping_countries.png)

* Optionally define a country specific fixed rate should you wish to have different rates per country

![Shipping Method Country Specific Rates](../../media/fixed_rate_country_shipping_rates.png)
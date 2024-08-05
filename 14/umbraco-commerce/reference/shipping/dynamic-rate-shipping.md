---
description: Dynamic Rate Shipping in Umbraco Commerce.
---

# Dynamic Rate Shipping

Dynamic rate shipping in Umbraco Commerce allows you to define a series of ranges from which an order will be checked against. These checks find which range a given order falls within which in turn identifies the rates that apply. For each range, a series of rate options can be configured. Examples include a fixed rate per order, a fixed rate per order item, or percentage-based rates. By combining these configurable ranges, and different rating options it allows you to create a more dynamic algorithm than the basic fixed-rate shipping option.

## Configuration

* Go to `Settings > Commerce > Stores > {Your Store} > Shipping Methods`

![Shipping Methods](../../media/v14/shipping-methods-list-view.png)

* Click `Create Shipping Method`
* Choose the `Basic` shipping provider

![Choose Shipping Provider](../../media/v14/shipping-provider-modal.png)

* Chose the `Dynamic` calculation mode option

![Choose Shipping Calculation Mode](../../media/v14/shipping-provider-config-modal.png)

* Populate the shipping method name, alias, sku and optional tax rate

![Shipping Method Details](../../media/v14/shipping-method-general-settings.png)

* Choose the range unit to base the rates upon
* Click `Add Range` to define each range


![Shipping Method Rates](../../media/v14/shipping-method-dynamic-rates.png)

* Populate the from and to value of the range
* Populate the rate details from the available rate options, leaving blank any option you don't wish to apply

![Shipping Method Rate](../../media/v14/shipping-method-dynamic-rate-editor.png)

* Configure the countries in this shipping method should be allowed in


![Shipping Method Allowed Countries](../../media/v14/shipping-method-countries.png)
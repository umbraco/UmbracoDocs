---
description: >-
  Learn more about the advantages of using the Umbraco Commerce Deploy package with Umbraco
  Commerce.
---

# Deploying Changes

After installing Umbraco Commerce Deploy, it will automatically serialize any changes made in the Umbraco Commerce settings section to disk. They will be added to the `data\revision` folder alongside Umbraco's own serialized content.

These files should be committed to your repository. Umbraco Deploy will then monitor these files and automatically deploy changes between environments for you.

Learn more about how the deployment process works in the [Umbraco Deploy documentation](https://docs.umbraco.com/umbraco-deploy/).

## Ignoring Settings

Some entities in Umbraco Commerce accept configuration settings such as Payment Methods, Shipping Methods, and Tax Calculation Methods. These settings can be environment-specific, and therefore, you may not want to deploy them between environments. To prevent this from happening, you can add the following configuration options to your `appsettings.json` file.

{% code title="appsettings.json" %}

```json
{
  ...
  "Umbraco": {
    "Commerce": {
      "Deploy": {
        "PaymentMethods": {
          "IgnoreSettings": [ "liveApiKey", "testMode" ]
        },
        "ShippingMethods": {
          "IgnoreSettings": [ "liveApiKey", "testMode" ]
        },
        "TaxCalculationMethods": {
          "IgnoreSettings": [ "liveApiKey", "testMode" ]
        }
      }
    }
  }
  ...
}
```

{% encode %}

For each supported entity type, you can supply an `IgnoreSettings` option, which contains an array of aliases of the settings options to be ignored.
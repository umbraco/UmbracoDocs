---
description: >-
  Details an integration available for CommerceTools, built and maintained by
  Umbraco HQ.
---

# CommerceTools

This integration provides a product and category picker, with data sourced from a [CommerceTools](https://commercetools.com/) installation.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Commerce.CommerceTools)
* [Source code](https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.Commerce.CommerceTools)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.cms.integrations.commerce.commercetools)

## Minimum version requirements

### Umbraco CMS

| Major         | Minor/Patch |
| ------------- | ----------- |
| Version 8.0.0 | 8.5.4       |

{% hint style="warning" %}
This integration is currently only available for Umbraco 8.
{% endhint %}

## How To Use

From your CommerceTools account, retrieve the following details add them as application settings to your websites `web.config` file.

```xml
<add key="Umbraco.Cms.Integrations.Commerce.CommerceTools.OAuthUrl" value="https://auth.europe-west1.gcp.commercetools.com/oauth/token" />
<add key="Umbraco.Cms.Integrations.Commerce.CommerceTools.ApiUrl" value="https://api.europe-west1.gcp.commercetools.com" />
<add key="Umbraco.Cms.Integrations.Commerce.CommerceTools.ProjectKey" value="" />
<add key="Umbraco.Cms.Integrations.Commerce.CommerceTools.ClientId" value="" />
<add key="Umbraco.Cms.Integrations.Commerce.CommerceTools.ClientSecret" value="" />
<add key="Umbraco.Cms.Integrations.Commerce.CommerceTools.DefaultLanguage" value="en-US" />
```

In the Umbraco backoffice, navigate to _Settings > Data Types_ and create a new Data Type based on the available _CommerceTools Picker_.

The picker can be configured for selection of categories or products, defined as single or multiple picker, as well as other options:

![Data type configuration](https://github.com/umbraco/Umbraco.Cms.Integrations/raw/main/src/Umbraco.Cms.Integrations.Commerce.CommerceTools/img/data-type-config.png)

When rendering product or category information, a property value converter will provide a strongly typed collection or object with the following fields available:

* [Category](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Commerce.CommerceTools/Models/Category.cs)
* [Product](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Commerce.CommerceTools/Models/Product.cs)

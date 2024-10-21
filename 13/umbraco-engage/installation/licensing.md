---
description: >-
  To get the full experience with Umbraco Engage you need to purchase and
  install a license. Learn more about how a license work in this article.
---

# Licensing

Umbraco Engage is a commercial product. You can run Umbraco Engage unrestricted locally without the need for a license. Running Umbraco Engage in the public domain will display a warning banner in the backoffice and limit the maximum page views to 1000 per month. To remove these restrictions, you'll need to have a **valid license**.

## How does it work?

Licenses are sold per backoffice domain and will also work on all subdomains. If you have alternative staging/QA environment domains, additional domains can be added to the license on request.

{% hint style="info" %}
The licenses are not bound to a specific product version. They will work for all versions of the related product.
{% endhint %}

Let's say that you have a license configured for your domain, `mysite.com`, and you've requested two development domains, `devdomain.com` and `devdomain2.com`.

The license will cover the following domains:

* `localhost`
* `*.local`
* `*.mysite.com`
* `www.mysite.com`
* `devdomain.com`
* `www.devdomain.com`
* `devdomain2.com`
* `www.devdomain2.com`

{% hint style="info" %}
You can have only 1 license per Umbraco installation.
{% endhint %}

## What does a license cover?

There are a few differences as to what the licenses cover:

* A single license covers the installation of Umbraco Engage in 1 production backoffice domain, as well as in any requested development domains.
* The production domain includes **all subdomains** (e.g. `*.mysite.com`).
* The development domains work with or without the `www` subdomain.
* The license allows for an unlimited number of orders.
* The license also includes `localhost` and `*.local` as a valid domain.

{% hint style="info" %}
If you have multiple backoffice domains pointing at the same installation, you have the option to purchase and [add **additional domains**](the-licensing-model.md#add-additional-domains) to your license.

This is an add-on domain for existing licenses. Refunds will not be given for this product.
{% endhint %}

## Configuring your license

You can look at the pricing, features, and purchase a license on the [Umbraco Engage](https://umbraco.com/products/add-ons/engage/) page. A member of the [sales team](mailto:suits@umbraco.com) will manage this process. In the process, you will need to provide all domains you wish to have covered by the license such as primary and development/staging/QA domains. You should then receive a license code to be installed in your solution.

### Add additional domains

To add additional domains to your license, reach out to a member of the [Sales team](mailto:suits@umbraco.com) with your request and they will manage this process.

## Installing your license

Once you have received your license code it needs to be installed on your site.

1. Open the root directory for your project files.
2. Locate and open the `appSettings.json` file.
3. Add your Umbraco Engage license key to `Umbraco:Licenses:Umbraco.Engage`:

```json
"Umbraco": {
  "Licenses": {
    "Umbraco.Engage": "YOUR_LICENSE_KEY"
  }
}
```

### Verify the license installation

You can verify that your license is successfully installed by logging into your project's backoffice and navigating to the settings section. Here you will see a license dashboard which should display the status of your license.

![Umbraco Engage License Dashboard](../media/license-dashboard.png)

### When and how to configure an `UmbracoApplicationUrl`

If you are running on a single domain for both your frontend and backend environments, it's not necessary to configure a `UmbracoApplicationUrl`.

If you have different domains for your frontend and backend, then it's advised that you configure an `UmbracoApplicationUrl` set to your backoffice URL. This helps the licensing engine know which URL should be used for validation checks. Without this configuration setting, the licensing engine will try and work out the domain to validate from the HTTP request object. This can lead to errors when switching between domains.

An `UmbracoApplicationUrl` can be configured in your `appSettings.json` file like so:

```json
{
    "Umbraco": {
        "CMS": {
            "WebRouting": {
                "UmbracoApplicationUrl": "https://admin.my-custom-domain.com/"
            }
        }
    }
}
```

See the [Fixed Application URL](https://docs.umbraco.com/umbraco-cms/extending/health-check/guides/fixedapplicationurl) documentation for more details about this setting.

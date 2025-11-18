---
description: Learn about licensing, including coverage, installation, and validation options.
---

# Licensing

Umbraco UI Builder is a commercial product. You can use Umbraco UI Builder locally without a license. When running Umbraco UI Builder on a public domain the usage is limited to a single editable collection. To remove these restrictions, a **valid license** is required.

## How Licensing Works

Licenses are sold per backoffice domain and applies to all subdomains. If you have alternative staging/QA environment domains, additional domains can be added to the license on request.

{% hint style="info" %}
The licenses are not tied to a specific product version. They work across all versions of the related product.
{% endhint %}

### Example License Coverage

A license for `mysite.com` and requested dev domains (`devdomain.com` and `devdomain2.com`) will cover:

* `localhost`
* `*.local`
* `*.mysite.com`
* `www.mysite.com`
* `devdomain.com`
* `www.devdomain.com`
* `devdomain2.com`
* `www.devdomain2.com`

{% hint style="info" %}
Only one license per Umbraco installation is allowed.
{% endhint %}

## What a License Covers?

There are a few differences as to what the licenses cover:

* A single license covers the installation of Umbraco UI Builder in one production backoffice domain, as well as in any requested development domains.
* The production domain includes **all subdomains** (e.g. `*.mysite.com`).
* The development domains work with or without the `www` subdomain.
* The license allows for an unlimited number of editable collections.
* The license also includes `localhost` and `*.local` as a valid domain.

{% hint style="info" %}
If you have multiple backoffice domains pointing at the same installation, you can purchase and [add **additional domains**](licensing-model.md#adding-additional-domains) to your license.

This is an add-on domain for existing licenses. Refunds will not be given for this product.
{% endhint %}

## Purchasing your license

You can look at the pricing, features, and purchase a license on the [Umbraco UI Builder](https://umbraco.com/products/add-ons/ui-builder/) page. On this page, you can fill out the form with your project details and requirements.

A member of the Sales team will manage this process. In the process, you will need to provide all domains you wish to have covered by the license such as primary and staging/QA domains. You should then receive a license code to be installed in your solution.

### Adding Additional Domains

If you require to add additional domains to the license, [reach out to the sales team](https://umbraco.com/products/add-ons/ui-builder/). They will manage your request and take care of the process.

## Configuring your license

Once you've purchased your license with the correct domains, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.UIBuilder`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](https://docs.umbraco.com/umbraco-dxp/commercial-products/configure-licenses) article.

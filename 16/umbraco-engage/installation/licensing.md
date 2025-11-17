---
description: >-
  To get the full experience with Umbraco Engage you need to purchase and
  install a license. Learn more about how a license work in this article.
---

# Licensing

Umbraco Engage is a commercial product. You can run Umbraco Engage unrestricted locally without the need for a license and will display a trial banner. Running Umbraco Engage in the public domain will require you to have a **valid license**.

## How does it work?

Licenses are sold per backoffice domain. If you have alternative staging/QA environment domains or require one or more subdomains, additional domains can be added to the license on request.

{% hint style="info" %}
The licenses are not bound to a specific product version. They will work for all versions of the related product.
{% endhint %}

Let's say that you have a license configured for your domain, `mysite.com`, and you've requested two development domains, `devdomain.com` and `devdomain2.com`.

The license will cover the following domains:

* `localhost`
* `*.local`
* `*.test`
* `mysite.com`
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
* The development and production domains work with or without the `www` subdomain.
* The license also includes `localhost`, `*.local`, and `*.test` as valid domains.
* Each individual subdomain has to be specified as part of the license (e.g. `subdomain.mysite.com`), wildcard subdomains are not allowed.

{% hint style="info" %}
If multiple backoffice domains share the same installation, you have to purchase and add [**additional domains**](licensing.md#add-additional-domains) to your license.

This is an add-on domain for existing licenses. Refunds will not be given for this product.
{% endhint %}

## Purchasing your license

You can look at the pricing, features, and purchase a license on the [Umbraco Engage](https://umbraco.com/products/add-ons/engage/) page. A member of the sales team will manage this process. You will need to provide all domains you wish to have covered by the license, such as primary and development/staging/QA domains. You should then receive a license code to be installed in your solution.

### Add additional domains

To add additional domains to your license, [reach out to the sales team](https://umbraco.com/products/add-ons/engage/) with your request, and they will manage this process.

## Configuring your license

Once you've purchased your license with the correct domains, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.Engage`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](../../../marketplace-and-integrations/configure-licenses.md) article.

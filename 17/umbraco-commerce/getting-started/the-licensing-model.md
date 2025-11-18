# Licensing

Umbraco Commerce is a commercial product. You can run Umbraco Commerce unrestricted locally without the need for a license. Running Umbraco Commerce in the public domain will display a warning banner in the backoffice and will limit the maximum number of orders to 20. To remove these restrictions, you'll need to have a **valid license**.

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

* A single license covers the installation of Umbraco Commerce in 1 production backoffice domain, as well as in any requested development domains.
* The production domain includes **all subdomains** (e.g. `*.mysite.com`).
* The development domains work with or without the `www` subdomain.
* The license allows for an unlimited number of orders.
* The license also includes `localhost` and `*.local` as a valid domain.

{% hint style="info" %}
If you have multiple backoffice domains pointing at the same installation, you have the option to purchase and [add **additional domains**](the-licensing-model.md#add-additional-domains) to your license.

This is an add-on domain for existing licenses. Refunds will not be given for this product.
{% endhint %}

## Purchasing your license

You can look at the pricing, features, and purchase a license on the [Umbraco Commerce](https://umbraco.com/products/add-ons/commerce/) page. A member of the sales team will manage this process. You will need to provide all domains you wish to have covered by the license such as primary and development/staging/QA domains. You should then receive a license code to be installed in your solution.

### Add additional domains

If you require to add addition domains to the license, [reach out the sales team](https://umbraco.com/products/add-ons/commerce/) with your request and they will manage this process.

## Configuring your license

Once you've purchased your license with the correct domains, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.Commerce`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](../../../marketplace-and-integrations/configure-licenses.md) article.

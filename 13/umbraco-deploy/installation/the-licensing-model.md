# The Licensing Model

Umbraco Deploy is a commercial product. You will need a **valid license** to use the product.

A license for Umbraco Deploy is included when hosting on Umbraco Cloud.

## How does it work?

Licenses are sold per domain and will also work on all subdomains. With every license, you will also be able to configure two development/testing domains.

### Example

Let's say that you have a license configured for your domain, `mysite.com`, and you've configured two development domains, `devdomain.com` and `devdomain2.com`.

The license will cover the following domains:

* `localhost`
* `*.mysite.com`
* `www.mysite.com`
* `mysite.com.local`
* `devdomain.com`
* `www.devdomain.com`
* `devdomain2.com`
* `www.devdomain2.com`

{% hint style="info" %}
You can have only 1 license per Umbraco installation.
{% endhint %}

## What does a license cover?

There are a few differences as to what the licenses cover:

A single license covers one Umbraco solution. It includes all domains hosted by the solution, all production environments (if load-balancing), and all non-production environments.

To clarify the above:

* You only need one license when you have a solution covering multiple domains- for example, `www.mysite.com` and `www.mysite.dk` - load balanced in production over multiple servers running from the same database, managed from the same backoffice instance, and with any number of non-production environments (staging, QA, etc.)
* You need two licenses if you have a web presence that consists of two separate websites hosted on different domains or sub-domains - for example, `www.mysite.com` and shop.mysite.com - with each of these managed as a separate Umbraco installation using their own database and backoffice in production.

{% hint style="info" %}
The license for Umbraco Deploy comes with a recurring yearly fee. Learn more about this and pricing on [Umbraco.com](https://umbraco.com/products/umbraco-deploy/).
{% endhint %}

## Purchasing your license

You can look at the pricing, plans, features, and purchase the license on the [Umbraco Deploy On-premises](https://umbraco.com/products/add-ons/deploy/umbraco-deploy-on-premises/) page.

## Configuring your license

Once you've purchased your license with the correct domains, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.Deploy.OnPrem`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](../../../marketplace-and-integrations/configure-licenses.md) article.

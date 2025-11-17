# Licensing

Umbraco UI Builder is a commercial product. You can run an Umbraco UI Builder unrestricted locally without the need a license. Running Umbraco UI Builder on a public domain will display a warning banner in the backoffice and will limit usage to a single editable collection. To remove these restrictions, you'll need to have a **valid license**.

## How does it work?

Licenses are sold per backoffice domain and will also work on all subdomains. If you have alternative staging/qa environment domains, additional domains can be added to the license on request.

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

* A single license covers the installation of Umbraco UI Builder in 1 production backoffice domain, as well as in any requested development domains.
* The production domain includes **all subdomains** (e.g. `*.mysite.com`).
* The development domains work with or without the `www` subdomain.
* The license allows for an unlimited number of editable collections.
* The license also includes `localhost` and `*.local` as a valid domain.

{% hint style="info" %}
If you have multiple backoffice domains pointing at the same installation, you can purchase and [add **additional domains**](licensing-model.md#add-additional-domains) to your license.

This is an add-on domain for existing licenses. Refunds will not be given for this product.
{% endhint %}

## Purchasing your license

You can look at the pricing, features, and purchase a license on the [Umbraco UI Builder](https://umbraco.com/products/add-ons/ui-builder/) page. On this page, you can fill out the form with your project details and requirements. A member of the Sales team will manage this process. In the process, you will need to provide all domains you wish to have covered by the license such as primary and staging/QA domains. You should then receive a license code to be installed in your solution.

### Add additional domains

If you require to add additional domains to the license, [reach out to the sales team](https://umbraco.com/products/add-ons/ui-builder/). They will manage your request and take care of the process.

## Configuring your license

Once you've purchased your license with the correct domains, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.UIBuilder`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](../../../marketplace-and-integrations/configure-licenses.md) article.

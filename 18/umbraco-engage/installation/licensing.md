---
description: >-
  To get the full experience with Umbraco Engage you need to purchase and
  install a license. Learn more about how a license work in this article.
---

# Licensing

Umbraco Engage is a commercial product. You can run Umbraco Engage unrestricted locally without the need for a license and will display a trial banner. Running Umbraco Engage in the public domain will require you to have a **valid license**.

## How does it work?

Licenses are sold per Umbraco installation. This means one license covers a single Umbraco database and its associated web project.

While the license is sold per installation, it is configured on a domain basis. This allows the Umbraco licensing server to verify that the backoffice is being accessed from an authorized environment.

{% hint style="info" %}
The licenses are not tied to a specific product version. They work across all versions of the related product.
{% endhint %}

### Example License Configuration

When you purchase a license, you define one production domain (which includes all its subdomains) and up to two development or testing domains.

For a license configured for `mysite.com`, with development domains `devdomain.com` and `devdomain2.com`, the following are covered:

* **Local Development:** `localhost`, `*.local`, and `*.test`.
* **Production:** `mysite.com` and all subdomains (for example, `www.mysite.com`, `shop.mysite.com`).
* **Staging/QA:** Your two specifically registered domains, such as `devdomain.com` and `devdomain2.com`.

{% hint style="info" %}
Only one license per Umbraco installation is allowed.
{% endhint %}

## What does a license cover?

There are a few differences as to what the licenses cover:

* A single license covers the installation of Umbraco Engage in 1 production backoffice domain, as well as in any requested development domains.
* The development and production domains work with or without the `www` subdomain.
* The license also includes `localhost`, `*.local`, and `*.test` as valid domains.
* A license domain can be a wildcard, for example `*.mysite.com`. A wildcard covers every subdomain and `mysite.com` itself.
* Without a wildcard, each individual subdomain has to be specified as part of the license (for example, `subdomain.mysite.com`).

{% hint style="info" %}
If multiple backoffice domains share the same installation, you have to purchase and add [**additional domains**](licensing.md#add-additional-domains) to your license.

This is an add-on domain for existing licenses. Refunds will not be given for this product.
{% endhint %}

### Licensed features

A license enables Analytics, Personalization, and A/B testing as separate features. From Umbraco Engage 18.1, a feature that is not part of your license is turned off in the backoffice and in the Engage API. Personalization and A/B testing are then also not applied to visitors.

## Purchasing your license

You can look at the pricing, features, and purchase a license on the [Umbraco Engage](https://umbraco.com/products/add-ons/engage/) page. A member of the sales team will manage this process. You will need to provide all domains you wish to have covered by the license, such as primary and development/staging/QA domains. You should then receive a license code to be installed in your solution.

### Add additional domains

To add additional domains to your license, [reach out to the sales team](https://umbraco.com/products/add-ons/engage/) with your request, and they will manage this process.

## Configuring your license

Once you've purchased your license with the correct domains, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.Engage`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](https://docs.umbraco.com/umbraco-dxp/commercial-products/configure-licenses) article.

### Verify the license installation

You can verify that your license is successfully installed by logging into your project's backoffice and navigating to the **Engage** section. Here, you will see a license dashboard in the right pane, which should display the status of your license (**Valid**).

<figure><img src="../.gitbook/assets/image (13).png" alt=""><figcaption><p>Umbraco Engage start page with license information</p></figcaption></figure>

If the license (status) is not correct, verify the license in **Umbraco** -> **Settings** -> **Licenses** tab, and (re)validate if necessary.

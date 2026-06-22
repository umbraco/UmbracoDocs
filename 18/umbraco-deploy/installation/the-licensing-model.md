# The Licensing Model

Umbraco Deploy is a commercial product. You will need a **valid license** to use the product.

A license for Umbraco Deploy is included when hosting on Umbraco Cloud.

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

A single license covers one Umbraco solution. It includes all domains hosted by the solution, all production environments (if load-balancing), and all non-production environments.

To clarify the above:

* You only need one license when you have a solution covering multiple domains- for example, `www.mysite.com` and `www.mysite.dk` - load balanced in production over multiple servers running from the same database, managed from the same backoffice instance, and with any number of non-production environments (staging, QA, etc.)
* You need two licenses if you have a web presence that consists of two separate websites hosted on different domains or sub-domains - for example, `www.mysite.com` and `shop.mysite.com` - with each of these managed as a separate Umbraco installation using their own database and backoffice in production.

{% hint style="info" %}
The license for Umbraco Deploy comes with a recurring yearly fee. Learn more about this and pricing on [Umbraco.com](https://umbraco.com/products/umbraco-deploy/).
{% endhint %}

## Purchasing your license

You can look at the pricing, plans, features, and purchase the license on the [Umbraco Deploy On-premises](https://umbraco.com/products/add-ons/deploy/umbraco-deploy-on-premises/) page.

## Configuring your license

Once you've purchased your license with the correct domains, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.Deploy.OnPrem`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](https://docs.umbraco.com/umbraco-dxp/commercial-products/configure-licenses) article.

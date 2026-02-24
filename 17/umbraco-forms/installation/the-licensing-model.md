# Licensing

Umbraco Forms is a commercial product. You can run Umbraco Forms unrestricted locally without the need for a license. Running Umbraco Forms in the public domain will require a valid license.

Version 16 supports both the one-off purchase and (in 16.1+) subscription license. 

## How does it work?

Licenses are sold per domain and will also work on all subdomains. With every license, you will be able to configure two development/testing domains.

{% hint style="info" %}
The licenses are not bound to a specific product version. They will work for all versions of the related product, but version 17+ will only be available through a subscription-based license (see [announcement](https://github.com/umbraco/Announcements/issues/25)).
{% endhint %}

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

* A single license covers the installation of Umbraco Forms in 1 production domain, as well as in 2 development domains.
* The production domain includes **all subdomains** (e.g. `*.mysite.com`), as well as the `.local` extension (e.g. `mysite.com.local`).
* The development domains work with or without the `www` subdomain.
* The license allows for an unlimited number of forms.
* The license also includes `localhost` as a valid domain.

{% hint style="info" %}
If you have multiple domains pointing at the same installation, you have the option to purchase and [add **additional domains**](the-licensing-model.md#add-additional-domains) to your license.

Each additional domain includes 1 live domain and 2 development/testing domains.

This is an add-on domain for existing licenses. Refunds will not be given for this product.
{% endhint %}

## Configuring your license

You can look at the pricing, features, and purchase the license on the [Umbraco Forms](https://umbraco.com/products/add-ons/forms/) page.

### Add additional domains

If you require to add additional domains to the license, [reach out the sales team](https://umbraco.com/products/add-ons/forms/) with your request and they will manage this process.

### Installing subscription license product key

Once you've purchased your subscription license with the correct domains, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.Forms`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](https://docs.umbraco.com/umbraco-dxp/commercial-products/configure-licenses) article.

#### Federal Information Processing Standards (FIPS) Compliant Environments

The algorithm used to decrypt Forms licenses is not supported on locked down FIPS compliant environments, such as those used in the defense industry.

If you are in this situation and unable to resolve it via configuration of the environment, reach out to Umbraco Support.

We have the possibility of generating and providing Forms licenses using alternate algorithms.

Apply the following configuration with the appropriate algorithm - `DES` (the default), `TripleDES`, or `AES`:

```json
  "Umbraco": {
    "Licensing": {
      "LicenseEncodeAndDecodeAlgorithm": "DES|TripleDES|AES"
    },
```

Will this FAIL?


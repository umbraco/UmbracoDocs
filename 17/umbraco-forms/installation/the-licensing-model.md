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

If you require to add addition domains to the license, [reach out the sales team](https://umbraco.com/products/add-ons/forms/) with your request and they will manage this process.

### Reconfiguration of domains

Once a license has been configured with the domains, it is not possible to reconfigure them. An exception is when there is a mistake in the domain URL.

As reconfiguration is not possible, you will either need to purchase an additional domain or a [new license](https://umbraco.com/products/umbraco-forms/).

## Installing your license

You can configure either the one-off purchase license file or the subscription license product key. We do not recommend having both a license file and product key configured, but if you have, the product key is checked first.

### Installing one-off purchase license file

Once you've configured your license with the correct domains, you are ready to install the license on your Umbraco installation.

1. Obtain the license (a `.lic` file) from the sales team
2. Place the file in the `/umbraco/Licenses` directory in your Umbraco installation

The `.lic` file must be placed in the `/umbraco/Licenses` directory to be registered by Umbraco Forms. If the file isn't placed correctly, the application will automatically switch to trial mode.

#### Multiple license files

You can install multiple Umbraco Forms license files without merging them. Place each license file in the `/umbraco/Licenses` directory (or an alternative location). Each file should begin with `umbracoForms`, for example, `umbracoForms.example1.lic` and `umbracoForms.example2.lic`. This setup allows your installation to recognize multiple licensed domains.

#### Alternative license location

If you can't include the license file in the `/umbraco/Licenses` directory for any reason, it is possible to configure an alternative location for the file.

It can be configured in the Umbraco installation's `appsettings.json` file by adding the following configuration:

```json
{
  "Umbraco": {
    "Licensing": {
        "Directory": "~/custom-licenses-folder/"
    }
  }
}
```

The value contains the path of your custom license directory relative to the root of your Umbraco installation.

{% hint style="warning" %}
This will also change the location for other Umbraco-related licenses in this project.
{% endhint %}

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

### Installing subscription license product key

Once you've purchased your subscription license with the correct domains, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.Forms`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](https://docs.umbraco.com/umbraco-dxp/commercial-products/configure-licenses) article.

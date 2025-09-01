# Licensing

Umbraco Forms is a commercial product. You have a 14-day free trial to try out the product. After your trial expires, you'll need to have a **valid license** to keep using the product on your site.

## How does it work?

Licenses are sold per domain and will also work on all subdomains. With every license, you will be able to configure two development/testing domains.

{% hint style="info" %}
The licenses are not bound to a specific product version. They will work for all versions of the related product, but version 17+ will only be available through a subscription based license (see [announcement](https://github.com/umbraco/Announcements/issues/25)).
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

When you've bought a license you need to configure it with your domains. You can either configure your license right away or you can do it later by visiting your account on Umbraco.com.

1. Login to your account at [shop.umbraco.com](https://shop.umbraco.com).
2. Navigate to the **Manage Licenses** section.
3. Locate your unconfigured Forms license and choose **Configure / Add domain**.
4. Define the primary as well as up to two development domains for which the license will be used.

### Add additional domains

Once you have a configured Umbraco Forms license, you can add additional domains. This is relevant if you need your forms to be available on multiple public domains.

1. Login to your account at [shop.umbraco.com](https://shop.umbraco.com).
2. Navigate to the **Manage Licenses** section.
3. Locate your configured Forms license.
4. Choose **Configure / Add domain**.

<figure><img src="./images/image.png" alt=""><figcaption></figcaption></figure>

5. Select **Click here to buy** at the bottom of the configuration page.
6. Configure the additional domain after completing the purchase, or do it later via your account.

### Reconfiguration of domains

Once a license has been configured with the domains, it is not possible to reconfigure them. An exception is when there is a mistake in the domain URL.
As reconfiguration is not possible, you will either need to purchase an additional domain or a [new license](https://umbraco.com/products/umbraco-forms/).

## Installing your license

Once you've configured your license with the correct domains, you are ready to install the license on your Umbraco installation.

1. Download your license from your Umbraco.com account - this will give you a `.lic` file
2. Place the file in the `/umbraco/Licenses` directory in your Umbraco installation

The `.lic` file must be placed in the `/umbraco/Licenses` directory to be registered by Umbraco Forms. If the file isn't placed correctly, the application will automatically switch to trial mode. It is also recommended to restart your site after you have added the license file.

### Multiple license files

You can install multiple Umbraco Forms license files without merging them. Place each license file in the `/umbraco/Licenses` directory (or an alternative location). Each file should begin with `umbracoForms`, for example, `umbracoForms.example1.lic` and `umbracoForms.example2.lic`. This setup allows your installation to recognize multiple licensed domains.

### Alternative license location

If you can't include the license file in the `/umbraco/Licenses` directory for any reason, it is possible to configure an alternative location for the file.

It can be configured in the Umbraco installation's `appSettings.json` file by adding the following configuration:

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

## Federal Information Processing Standards (FIPS) Compliant Environments

The algorithm used to decrypt Forms licenses is not supported on locked down FIPS compliant environments, such as those used in the defense industry.

If you are in this situation and unable to resolve it via configuration of the environment, please reach out to Umbraco support.

We have the possibility of generating and providing Forms licenses using alternate algorithms.

{% hint style="info" %}
You can use this configuration if you reference `Umbraco.Licensing` version `13.0.1` or higher.
{% endhint %}

Apply the following configuration with the appropriate algorithm - `DES` (the default), `TripleDES`, or `AES`:

```json
  "Umbraco": {
    "Licensing": {
      "LicenseEncodeAndDecodeAlgorithm": "DES|TripleDES|AES"
    },
``````

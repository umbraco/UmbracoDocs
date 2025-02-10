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
If you have multiple backoffice domains pointing at the same installation, you can purchase and [add **additional domains**](licensing-model.md#add-additional-domains) to your license.

This is an add-on domain for existing licenses. Refunds will not be given for this product.
{% endhint %}

## Configuring Your License

You can look at the pricing, features, and purchase a license on the [Umbraco UI Builder](https://umbraco.com/products/add-ons/ui-builder/) page. On this page, you can fill out the form with your project details and requirements. 

A member of the Sales team will manage this process. In the process, you will need to provide all domains you wish to have covered by the license such as primary and staging/QA domains. You should then receive a license code to be installed in your solution.

### Adding Additional Domains

If you require to add additional domains to the license, [reach out to the sales team](https://umbraco.com/products/add-ons/ui-builder/). They will manage your request and take care of the process.

## Installing your license

Once you have received your license code it needs to be installed on your site.

1. Open the root directory of your project files.
2. Locate and open the `appSettings.json` file.
3. Add your Umbraco UI builder license key under `Umbraco:Licenses:Products:Umbraco.UIBuilder`:

```json
"Umbraco": {
    "Licenses": {
        "Products": {
            "Umbraco.UIBuilder": "YOUR_LICENSE_KEY"
         }
  }
}
```

{% hint style="info" %}
You might run into issues when using a period in the product name when using environment variables. Use an underscore in the product name instead, to avoid problems.

```json
"Umbraco_UIBuilder": "YOUR_LICENSE_KEY"
```

{% endhint %}

### Verifying the License

To verify that your license is successfully installed:

1. Log into Umbraco Backoffice.
2. Navigate to the **Settings** > **License** dashboard.
3. Your license status will be displayed.

### Validating a License Without an Internet connection

Some Umbraco installations will have a highly locked down production environment, with firewall rules that prevent outgoing HTTP requests. This will interfere with the normal process of license validation.

On start-up, and periodically whilst Umbraco is running, the license component used by Umbraco UIBuilder will make an HTTP POST request to `https://license-validation.umbraco.com/api/ValidateLicense`.

If it's possible to do so, the firewall rules should be adjusted to allow this request.

If such a change is not feasible, there is another approach you can use.

You will need to have a server, or serverless function, that is running and can make a request to the online license validation service. That needs to run on a daily schedule, making a request and relaying it onto the restricted Umbraco environment.

To set this up, firstly ensure you have a reference to `Umbraco.Licenses` version 13.1 or higher. If the version of UIBuilder you are using depends on an earlier version, you can add a direct package reference for `Umbraco.Licenses`.

Then configure a random string as an authorization key in configuration. This is used as protection to ensure only valid requests are handled. You can also disable the normal regular license checks - as there is no point in these running if they will be blocked:

```json
  "Umbraco": {
    "Licenses": {
      "Umbraco.UIBuilder": "<your license key>"
    },
    "LicensesOptions": {
      "EnableScheduledValidation": false,
      "ValidatedLicenseRelayAuthKey": "<your authorization key>"
    }
```

Your Internet enabled server should make a request of the following form to the online license validation service:

```
POST https://license-validation.umbraco.com/api/ValidateLicense
{
    "ProductId": "Umbraco.UIBuilder",
    "LicenseKey": "<your license key>",
    "Domain": "<your licensed domain>"
}
```

The response should be relayed exactly via an HTTP request to your restricted Umbraco environment:

```
POST http://<your umbraco environment>/umbraco/licenses/validatedLicense/relay?productId=<product id>&licenseKey=<license key>
```

A header with a key of `X-AUTH-KEY` and value of the authorization key you have configured should be provided.

This will trigger the same processes that occur when the normal scheduled validation completes ensuring your product is considered licensed.

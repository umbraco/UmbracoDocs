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

## Configuring your license

You can look at the pricing, features, and purchase a license on the [Umbraco UI Builder](https://umbraco.com/products/add-ons/ui-builder/) page. On this page, you can fill out the form with your project details and requirements. A member of the Sales team will manage this process. In the process, you will need to provide all domains you wish to have covered by the license such as primary and staging/QA domains. You should then receive a license code to be installed in your solution.

### Add additional domains

If you require to add additional domains to the license, [reach out to the sales team](https://umbraco.com/products/add-ons/ui-builder/). They will manage your request and take care of the process.

## Installing your license

Once you have received your license code it needs to be installed on your site.

1. Open the root directory for your project files.
2. Locate and open the `appSettings.json` file.
3. Add your Umbraco UI builder license key to `Umbraco:Licenses:Umbraco.UIBuilder`:

```json
"Umbraco": {
    "Licenses": {
        "Products": {
            "Umbraco.UIBuilder": "YOUR_LICENSE_KEY"
         }
  }    
}
```

### Verify the license installation

You can verify that your license is successfully installed by logging into your project's backoffice and navigating to the settings section. Here you will see a license dashboard which should display the status of your license.

### Validating a license without an outgoing Internet connection

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

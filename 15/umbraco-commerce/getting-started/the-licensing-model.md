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

## Configuring your license

You can look at the pricing, features, and purchase a license on the [Umbraco Commerce](https://umbraco.com/products/add-ons/commerce/) page. A member of the sales team will manage this process. You will need to provide all domains you wish to have covered by the license such as primary and development/staging/QA domains. You should then receive a license code to be installed in your solution.

### Add additional domains

If you require to add addition domains to the license, [reach out the sales team](https://umbraco.com/products/add-ons/commerce/) with your request and they will manage this process.

## Installing your license

Once you have received your license code it needs to be installed on your site.

1. Open the root directory for your project files.
2. Locate and open the `appSettings.json` file.
3. Add your Umbraco Commerce license key to `Umbraco:Licenses:Umbraco.Commerce`:

```json
"Umbraco": {
  "Licenses": {
    "Products": {
      "Umbraco.Commerce": "YOUR_LICENSE_KEY"
    }
  }
}
```



### Verify the license installation

You can verify that your license is successfully installed by logging into your project's backoffice and navigating to the settings section. Here you will see a license dashboard which should display the status of your license.

![Umbraco Commerce License Dashboard](../media/license-dashboard.png)

### When and how to configure an `UmbracoApplicationUrl`

If you are running on a single domain for both your frontend and backend environments, it's not necessary to configure a `UmbracoApplicationUrl`.

If you have different domains for your frontend and backend, then it's advised that you configure an `UmbracoApplicationUrl` set to your backoffice URL. This helps the licensing engine know which URL should be used for validation checks. Without this configuration setting, the licensing engine will try and work out the domain to validate from the HTTP request object. This can lead to errors when switching between domains.


An `UmbracoApplicationUrl` can be configured in your `appSettings.json` file like so:

```json
{
    "Umbraco": {
        "CMS": {
            "WebRouting": {
                "UmbracoApplicationUrl": "https://admin.my-custom-domain.com/"
            }
        }
    }
}
```

See the [Fixed Application URL](https://docs.umbraco.com/umbraco-cms/extending/health-check/guides/fixedapplicationurl) documentation for more details about this setting.

#### Configuring `UmbracoApplicationUrl` on Umbraco Cloud

If you are hosting on Umbraco Cloud you will find the configuration described above won't be reflected in your environment. The reason for this is that Umbraco Cloud sets this value as an environment variable set to the Cloud project domain (`<your project>.umbraco.io`). This overrides what is set via the `appSettings.json` file.

There are two options in this case:
- Either the domains for each of your Cloud environments can be added to your license.
- Or, for more control and to ensure this value is set correctly for other reasons, you can apply the configuration via code.

For example, in your `Program.cs`:

```csharp
services.Configure<WebRoutingSettings>(o => o.UmbracoApplicationUrl = "<your application URL>");
```

In practice, you will probably want to make this a bit more sophisticated. You can read the value from another configuration key, removing the need to hard-code it and have it set as appropriate in different environments. You can also move this code into a composer or an extension method if you prefer not to clutter up the `Program.cs` file.

### Validating a license without an outgoing Internet connection

Some Umbraco installations will have a highly locked down production environment, with firewall rules that prevent outgoing HTTP requests. This will interfere with the normal process of license validation.

On start-up, and periodically whilst Umbraco is running, the license component used by Umbraco Commerce will make an HTTP POST request to `https://license-validation.umbraco.com/api/ValidateLicense`.

If it's possible to do so, the firewall rules should be adjusted to allow this request.

If such a change is not feasible, there is another approach you can use.

You will need to have a server, or serverless function, that is running and can make a request to the online license validation service. That needs to run on a daily schedule, making a request and relaying it onto the restricted Umbraco environment.

To set this up, firstly ensure you have a reference to `Umbraco.Licenses` version 13.1 or higher. If the version of Commerce you are using depends on an earlier version, you can add a direct package reference for `Umbraco.Licenses`.

Then configure a random string as an authorization key in configuration. This is used as protection to ensure only valid requests are handled. You can also disable the normal regular license checks - as there is no point in these running if they will be blocked:

```json
  "Umbraco": {
    "Licenses": {
      "Umbraco.Commerce": "<your license key>"
    },
    "LicensesOptions": {
      "EnableScheduledValidation": false,
      "ValidatedLicenseRelayAuthKey": "<your authorization key>"
    }
```

Your Internet-enabled server should make a request of the following form to the online license validation service:

```
POST https://license-validation.umbraco.com/api/ValidateLicense
{
    "ProductId": "Umbraco.Commerce",
    "LicenseKey": "<your license key>",
    "Domain": "<your licensed domain>"
}
```

The response should be relayed exactly via an HTTP request to your restricted Umbraco environment:

```
POST http://<your umbraco environment>/umbraco/licenses/validatedLicense/relay?productId=<product id>&licenseKey=<license key>
```

A header with a key of `X-AUTH-KEY` and the value of the authorization key you have configured should be provided.

This will trigger the same processes that occur when the normal scheduled validation completes ensuring your product is considered licensed.

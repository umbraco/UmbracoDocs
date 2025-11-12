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

You can configure either the one-off purchase license file or when using version 16.1+ the subscription license product key. We do not recommend having both a license file and product key configured, but if you have, the product key is checked first.

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

Once you have received your license code it needs to be installed on your site.

1. Open the root directory for your project files.
2. Locate and open the `appsettings.json` file.
3. Add your Umbraco Forms license key to `Umbraco:Licenses:Umbraco.Forms`:

```json
"Umbraco": {
  "Licenses": {
    "Umbraco.Forms": "YOUR_LICENSE_KEY"
  }
}
```

{% hint style="info" %}
You might run into issues when using a period in the product name when using environment variables. Use an underscore in the product name instead, to avoid problems.

```json
"Umbraco_Forms": "YOUR_LICENSE_KEY"
```
{% endhint %}

#### Verify the license installation

You can verify that your license is successfully installed by logging into your project's backoffice and navigating to the settings section. Here you will see a license dashboard which should display the status of your license.

### When and how to configure an `UmbracoApplicationUrl`

If you are running on a single domain for both your frontend and backend environments, it's not necessary to configure a `UmbracoApplicationUrl`.

If you have different domains for your frontend and backend, it's advised to configure an `UmbracoApplicationUrl` set to your backoffice URL. This helps the licensing engine know which domain should be used for validation checks. Without this configuration setting, the licensing engine will use the domain from the HTTP request object. This can lead to errors when switching between domains.

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

If you are hosting on Umbraco Cloud, you can find that the configuration described above won't be reflected in your environment. The reason for this is that Umbraco Cloud sets this value as an environment variable set to the Cloud project domain (`<your project>.umbraco.io`). This overrides what is set via the `appsettings.json` file.

There are two options in this case:

- Either the domains for each of your Cloud environments can be added to your license.
- Or, you can apply the configuration via code for more control and to ensure this value is set correctly for other reasons.

For example, in your `Program.cs`:

```csharp
services.Configure<WebRoutingSettings>(o => o.UmbracoApplicationUrl = "<your application URL>");
```

In practice, make this more sophisticated. You can read the value from another configuration key, removing the need to hard-code it and have it set as appropriate in different environments. You can also move this code into a composer or an extension method if you prefer.

#### Validating a license without an outgoing Internet connection

Some Umbraco installations will have a highly locked-down production environment, with firewall rules that prevent outgoing HTTP requests. This will interfere with the normal process of license validation.

On start-up, and periodically whilst Umbraco is running, the license component will make an HTTP POST request to `https://license-validation.umbraco.com/api/ValidateLicense`.

The firewall rules should be adjusted to allow this request.

If such a change is not feasible, there is another approach, which is outlined below.

You will need to have a server, or serverless function, that is running and can request the online license validation service. That needs to run on a daily schedule, making a request and relaying it to the restricted Umbraco environment.

Then configure a random string as an authorization key in the configuration. This is used as protection to ensure only valid requests are handled.

Alternatively, you can also disable the normal regular license checks, as there is no point in these running if they will be blocked:

```json
  "Umbraco": {
    "Licenses": {
      "Umbraco.Forms": "<your license key>"
    },
    "LicensesOptions": {
      "EnableScheduledValidation": false,
      "ValidatedLicenseRelayAuthKey": "<your authorization key>"
    }
```

Your Internet-enabled server requests the following form from the online license validation service:

```
POST https://license-validation.umbraco.com/api/ValidateLicense
{
    "ProductId": "Umbraco.Forms",
    "LicenseKey": "<your license key>",
    "Domain": "<your licensed domain>"
}
```

The response is relayed exactly via an HTTP request to your restricted Umbraco environment:

```
POST http://<your umbraco environment>/umbraco/licenses/validatedLicense/relay?productId=<product id>&licenseKey=<license key>
```

A header with a key of `X-AUTH-KEY` and the value of the authorization key you have configured is provided.

This triggers the same processes that occur when the normal scheduled validation completes, ensuring your product is licensed.

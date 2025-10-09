# Configure Licenses

Commercial Umbraco products require a valid license to run in production environments. This article covers how to install, configure, and validate licenses for Umbraco's commercial products.

## Product-Specific License Information

For product-specific information including what a license covers, pricing, and how to purchase:

* [Umbraco Commerce Licensing](https://docs.umbraco.com/umbraco-commerce/getting-started/the-licensing-model)
* [Umbraco Deploy Licensing](https://docs.umbraco.com/umbraco-deploy/installation/the-licensing-model)
* [Umbraco Engage Licensing](https://docs.umbraco.com/umbraco-engage/installation/licensing)
* [Umbraco Forms Licensing](https://docs.umbraco.com/umbraco-forms/installation/the-licensing-model)
* [Umbraco UI Builder Licensing](https://docs.umbraco.com/umbraco-ui-builder/getting-started/licensing-model)
* [Umbraco Workflow Licensing](https://docs.umbraco.com/umbraco-workflow/installation/licensing)

## Installing Your License

Umbraco commercial products use configuration-based licenses. These are installed by adding your license key to the `appsettings.json` file.

{% hint style="info" %}
Umbraco Forms also supports file-based licenses, but starting from version 17, will only support the license key (see [announcement](https://github.com/umbraco/Announcements/issues/25)).
{% endhint %}

{% tabs %}
{% tab title="Version 14+" %}

For version 14 and above, licenses are configured under `Umbraco:Licenses:Products`:

1. Open the root directory for your project.
2. Locate and open the `appsettings.json` file.
3. Add your license key to `Umbraco:Licenses:Products:<ProductName>`:

```json
{
  "Umbraco": {
    "Licenses": {
      "Products": {
        "Umbraco.Commerce": "YOUR_LICENSE_KEY",
        "Umbraco.Deploy.OnPrem": "YOUR_LICENSE_KEY",
        "Umbraco.Engage": "YOUR_LICENSE_KEY",
        "Umbraco.Forms": "YOUR_LICENSE_KEY",
        "Umbraco.UIBuilder": "YOUR_LICENSE_KEY",
        "Umbraco.Workflow": "YOUR_LICENSE_KEY"
      }
    }
  }
}
```

{% endtab %}

{% tab title="Version 10-13" %}

For versions 10-13, licenses are configured under `Umbraco:Licenses`:

1. Open the root directory for your project files.
2. Locate and open the `appsettings.json` file.
3. Add your license key to `Umbraco:Licenses:<ProductName>`:

```json
{
  "Umbraco": {
    "Licenses": {
      "Umbraco.Commerce": "YOUR_LICENSE_KEY",
      "Umbraco.Deploy.OnPrem": "YOUR_LICENSE_KEY",
      "Umbraco.Engage": "YOUR_LICENSE_KEY",
      "Umbraco.Forms": "YOUR_LICENSE_KEY",
      "Umbraco.UIBuilder": "YOUR_LICENSE_KEY",
      "Umbraco.Workflow": "YOUR_LICENSE_KEY"
    }
  }
}
```

{% endtab %}
{% endtabs %}

{% hint style="info" %}
You might run into issues when using a period in the product name when using environment variables. Use an underscore in the product name instead, to avoid problems.

```json
"Umbraco_Commerce": "YOUR_LICENSE_KEY"
```

{% endhint %}

## Verifying the License Installation

You can verify that your license is successfully installed by logging into your project's backoffice:

1. Navigate to the **Settings** section.
2. Look for the **Licenses** dashboard.
3. Verify the license status displayed on the dashboard.

The dashboard will show the status of all installed commercial product licenses.

## Configuring UmbracoApplicationUrl

The website domain used for validating the license is determined from your Umbraco instance. To ensure the correct one is used, you can configure the `UmbracoApplicationUrl`.

### When to Configure UmbracoApplicationUrl

If you are running on a single domain for both your frontend and backend environments, it's not necessary to configure a `UmbracoApplicationUrl`.

If you have different domains for your frontend and backend, then it's advised that you configure an `UmbracoApplicationUrl` set to your backoffice URL. This helps the licensing engine know which URL should be used for validation checks. Without this configuration setting, the licensing engine will try and work out the domain to validate from the HTTP request object. This can lead to errors when switching between domains.

### How to Configure UmbracoApplicationUrl

An `UmbracoApplicationUrl` can be configured in your `appsettings.json` file:

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

### Configuring UmbracoApplicationUrl on Umbraco Cloud

If you are hosting on Umbraco Cloud, you will find that the configuration described above won't be reflected in your environment. The reason for this is that Umbraco Cloud sets this value as an environment variable set to the Cloud project domain (`<your project>.umbraco.io`). This overrides what is set via the `appsettings.json` file.

There are two options in this case:

* Either the domains for each of your Cloud environments can be added to your license.
* Or, for more control and to ensure this value is set correctly for other reasons, you can apply the configuration via code.

For example, in your `Program.cs`:

```csharp
builder.Services.Configure<WebRoutingSettings>(o => o.UmbracoApplicationUrl = "<your application URL>");
```

In practice, you will probably want to make this a bit more sophisticated. You can read the value from another configuration key, removing the need to hard-code it and have it set as appropriate in different environments. You can also move this code into a composer or an extension method if you prefer not to clutter up the `Program.cs` file.

## Validating a License Without an Outgoing Internet Connection

Some Umbraco installations will have a highly locked down production environment, with firewall rules that prevent outgoing HTTP requests. This will interfere with the normal process of license validation.

On start-up, and periodically whilst Umbraco is running, the license component will make an HTTP POST request to `https://license-validation.umbraco.com/api/ValidateLicense`.

If it's possible to do so, the firewall rules should be adjusted to allow this request.

If such a change is not feasible, there is another approach you can use.

### Setting Up License Relay

You will need to have a server, or serverless function, that is running and can make a request to the online license validation service. That needs to run on a daily schedule, making a request and relaying it onto the restricted Umbraco environment.

Configure a random string as an authorization key in configuration. This is used as protection to ensure only valid requests are handled. You can also disable the normal regular license checks - as there is no point in these running if they will be blocked:

{% tabs %}
{% tab title="Version 14+" %}

```json
{
  "Umbraco": {
    "Licenses": {
      "Products": {
        "Umbraco.Commerce": "<your license key>"
      },
      "EnableScheduledValidation": false,
      "ValidatedLicenseRelayAuthKey": "<your authorization key>"
    }
  }
}
```

{% endtab %}

{% tab title="Version 13.1" %}

Ensure you use the latest product version, so the package dependency on `Umbraco.Licenses` is updated to 13.1.0 or later.

```json
{
  "Umbraco": {
    "Licenses": {
      "Umbraco.Commerce": "<your license key>"
    },
    "LicensesOptions": {
      "EnableScheduledValidation": false,
      "ValidatedLicenseRelayAuthKey": "<your authorization key>"
    }
  }
}
```

{% endtab %}
{% endtabs %}

Your Internet-enabled server should make a request of the following form to the online license validation service:

```http
POST https://license-validation.umbraco.com/api/ValidateLicense
{
    "ProductId": "Umbraco.Commerce",
    "LicenseKey": "<your license key>",
    "Domain": "<your licensed domain>"
}
```

The response should be relayed exactly via an HTTP request to your restricted Umbraco environment:

```http
POST http://<your umbraco environment>/umbraco/licenses/validatedLicense/relay?productId=<product id>&licenseKey=<license key>
```

A header with a key of `X-AUTH-KEY` and the value of the authorization key you have configured should be provided.

This will trigger the same processes that occur when the normal scheduled validation completes ensuring your product is considered licensed.

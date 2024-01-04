# Licensing

Umbraco Workflow is a licensed product that does not require a purchase. New installations default to a trial license while the paid license is available for purchase.

## Purchasing an Umbraco Workflow License

If you want to buy an Umbraco Workflow license, reach out to the sales team at [**suits@umbraco.com**](mailto:suits@umbraco.com). Existing Plumber license holders who wish to upgrade to Umbraco Workflow should contact [**suits@umbraco.com**](mailto:suits@umbraco.com).

## Installing your license

Once you have received your license code it needs to be installed on your site.

1. Open the root directory for your project files.
2. Locate and open the `appSettings.json` file.
3. Add your Umbraco Workflow license key to `Umbraco:Licenses:Umbraco.Workflow`:

```json
"Umbraco": {
  "Licenses": {
    "Umbraco.Workflow": "YOUR_LICENSE_KEY"
  }
}
```

### Verify the license installation

You can verify that your license is successfully installed by logging into your project's backoffice and navigating to the settings section. Here you will see a licenses dashboard which should display the status of your license.

### When and how to configure an `UmbracoApplicationUrl`

The website domain used for validating the license is determined from your Umbraco instance. To ensure the correct one is used, you can configure the `UmbracoApplicationUrl`.

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

For example, in your `Program.cs` file:

```csharp
builder.Services.Configure<WebRoutingSettings>(o => o.UmbracoApplicationUrl = "<your application URL>");
```

In practice, you will probably want to make this a bit more sophisticated. You can read the value from another configuration key, removing the need to hard-code it and have it set as appropriate in different environments. You can also move this code into a composer or an extension method if you prefer not to clutter up the `Program.cs` file.

### Using a Trial License

The trial license introduces some restrictions around advanced features but is otherwise a full-featured workflow platform. The paid license is valid for one top-level domain and all its subdomains.

To impersonate the full license on a local site, set `EnableTestLicense` to `true` in the `appSettings.json` file:

```json
{
 “Umbraco”: {
   “Workflow”: {
     “EnableTestLicense”: true
   }
  }
}
```

{% hint style="info" %}
The test license is restricted to sites running in a development environment with a debugger attached. Hit F5 in Visual Studio, in Debug mode to enable the test license.
{% endhint %}

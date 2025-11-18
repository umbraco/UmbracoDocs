# Licensing

Umbraco Workflow is a licensed product that does not require a purchase. New installations default to a trial license while the paid license is available for purchase.

## Purchasing an Umbraco Workflow License

If you want to buy an Umbraco Workflow license, use [the contact form to get in touch](https://umbraco.com/products/add-ons/workflow#order).

### Free vs licensed versions

Umbraco Workflow is available in free and licensed versions. While the licensed version includes all features and no restrictions, the free version has some limitations.

In the free version, the following features are disabled:

- Document Type workflow configuration
- Document Type content review configuration
- History cleanup and related configuration
- Approval thresholds and related configuration
- Content comparison
- Exclude nodes

In the free version, a maximum of five approval groups can be created.

## Configuring your license

Once you've purchased your license, you are ready to configure the license key on your Umbraco installation.

The license key should be added to your configuration using product ID: `Umbraco.Workflow`.

For detailed instructions on how to install and configure your license, including version-specific examples and additional configuration options, see the [Configure Licenses](../../../marketplace-and-integrations/configure-licenses.md) article.

### Using a Trial License

The trial license introduces some restrictions around advanced features but is otherwise a full-featured workflow platform. The paid license is valid for one top-level domain and all its subdomains.

To impersonate the full license on a local site, set `EnableTestLicense` to `true` in the `appsettings.json` file:

```json
{
 "Umbraco": {
   "Workflow": {
     "EnableTestLicense": true
   }
  }
}
```

{% hint style="info" %}
The test license is restricted to sites running in a development environment with a debugger attached. Hit F5 in Visual Studio, in Debug mode to enable the test license.
{% endhint %}

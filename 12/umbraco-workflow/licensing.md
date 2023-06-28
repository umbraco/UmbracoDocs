# Licensing

Umbraco Workflow is a licensed product that does not require a purchase. New installations default to a trial license while the paid license is available for purchase.

## Purchasing an Umbraco Workflow License

If you want to buy an Umbraco Workflow license, reach out to the sales team at [**suits@umbraco.com**](mailto:suits@umbraco.com). Existing Plumber license holders who wish to upgrade to Umbraco Workflow should contact [**suits@umbraco.com**](mailto:suits@umbraco.com).

To add the license to your site update the `appSettings.json` file:

    ```
    {
      “Umbraco”: {
        “Licenses”: {
          “UmbracoWorkflow”: “YOUR-LICENSE-KEY”
        }   
      }  
    }
    ```

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

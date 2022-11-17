# Licensing

Umbraco Workflow is a licensed product but does not require a purchase to use. New installations are defaulted to a trial license while the paid license is available for purchase.&#x20;

The trial license introduces some restrictions around advanced features but is otherwise a full-featured workflow platform. The paid license is valid for one top-level domain and all its subdomains.

To impersonate the full license on a local site:

1. Set `EnableTestLicense` to `true` in the `appSettings.json` file:

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

## Purchasing an Umbraco Workflow License

If you want to buy an Umbraco Workflow license, reach out to the sales team at **suits@umbraco.com**. Existing Plumber license holders who wish to update to Umbraco Workflow should contact **suits@umbraco.com**.

To add the license to your site, follow these steps:

1. Update the `appSettings.json` file:

  ```json
  {
    “Umbraco”: {
      “CMS”: {
        “Licenses”: {
          “UmbracoWorkflow”: “YOUR-LICENSE-KEY”
        }
      }
    }
  }
  ```

2. Create a class in your website that implements the `IServerRoleAccessor` for the `SinlgeServerRoleAccessor` server role:

  ```cs
  public class SiteComposer : IComposer
  {
    public void Compose(IUmbracoBuilder builder)
    {
        builder.SetServerRegistrar<SinlgeServerRoleAccessor>();
    }
  }

  public class SinlgeServerRoleAccessor : IServerRoleAccessor
  {
    public ServerRole CurrentServerRole => ServerRole.Single;
  }
  ```

  {% hint style="info" %}
  License validation only runs on `Single` or `SchedulingPublisher` servers.
  {% endhint %}

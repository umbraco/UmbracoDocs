# Licensing

Umbraco Workflow is a licensed product that does not require a purchase. New installations default to a trial license while the paid license is available for purchase.

## Purchasing an Umbraco Workflow License

If you want to buy an Umbraco Workflow license, reach out to the sales team at [**suits@umbraco.com**](mailto:suits@umbraco.com). Existing Plumber license holders who wish to upgrade to Umbraco Workflow should contact [**suits@umbraco.com**](mailto:suits@umbraco.com).

To add the license to your site, follow these steps:

1.  Update the `appSettings.json` file:

    ```
    {
      “Umbraco”: {
        “Licenses”: {
          “UmbracoWorkflow”: “YOUR-LICENSE-KEY”
        }   
      }  
    }
    ```
2.  Create a class in your website, for example, `ServerRoleAccessor.cs` that implements the `IServerRoleAccessor` with `CurrentServerRole` set to either `Single` or `SchedulingPublisher` server role and register that class via a composer:

    ```
    using Umbraco.Cms.Core.Composing;
    using Umbraco.Cms.Core.Sync;
    using Umbraco.Cms.Infrastructure.DependencyInjection;

    public class SiteComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.SetServerRegistrar<SingleServerRoleAccessor>();
        }
    }

    public class SingleServerRoleAccessor : IServerRoleAccessor
    {
        public ServerRole CurrentServerRole => ServerRole.Single;
    }
    ```

{% hint style="info" %}
License validation _only_ runs on `Single` or `SchedulingPublisher` servers.
{% endhint %}

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

##

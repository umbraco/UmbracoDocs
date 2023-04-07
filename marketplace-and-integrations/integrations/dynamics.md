---
description: >-
  Details an integration available for Dynamics, built and maintained by Umbraco
  HQ.
---

# Dynamics

This integration provides a form picker and rendering component for forms managed within a Microsoft Dynamics 365 Marketing instance.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Crm.Dynamics)
* [Source code](https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.Crm.Dynamics)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.cms.integrations.crm.dynamics)

## Minimum version requirements

### Umbraco CMS

| Major      | Minor/Patch |
| ---------- | ----------- |
| Version 8  | 8.4.0       |
| Version 9  | 9.0.0       |
| Version 10 | 10.1.0      |
| Version 11 | 11.0.0      |

## Authentication

The package uses the OAuth protocol for authentication.

## Additional Configuration

To connect to your Dynamics 365 instance, the following configuration is required:

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
```json
"Umbraco": {
  "Integrations": {
      "Crm": {
        "Dynamics": {
          "Settings": {
            "HostUrl": "https://[INSTANCE].crm4.dynamics.com/",
            "ApiPath": "api/data/v9.2/"
          }
        }
      }
    }
  }
```
{% endcode %}
{% endtab %}

{% tab title="Version 8" %}
{% code title="web.config" %}
```xml
<appSettings>
  ...
  <add key="Umbraco.Cms.Integrations.Crm.Dynamics.HostUrl" value="https://[INSTANCE]/api.crm4.dynamics.com/" />
  <add key="Umbraco.Cms.Integrations.Crm.Dynamics.ApiPath" value="api/data/v9.2/" />
  ...
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

The above settings are for demonstration purposes. They might change depending on your personalized instance Web API.

### Self Hosted OAuth Configuration
Starting with version [1.2.0](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Crm.Dynamics/1.2.0), we are allowing developers to alternate the existing `OAuth Proxy for Umbraco Integrations` client for handling OAuth authorizations and redirects, with a custom authorization workflow managed entirely on their side. 

This means that you can setup your own app on _Microsoft_ for handling authorization requests and use an extended configuration like this:

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "Integrations": {
      "Crm": {
        "Dynamics": {
          "Settings": {
            ...
            "UseUmbracoAuthorization": true/false
          },
          "OAuthSettings": {
              "ClientId": "[your client id]",
              "ClientSecret": "[your client secret]",
              "RedirectUri": "https://[your website base URL]/umbraco/api/dynamicsauthorization/oauth",
              "TokenEndpoint": "https://login.microsoftonline.com/common/oauth2/v2.0/token",
              "Scopes": "https://[your instance].crm4.dynamics.com/.default"
            }
        }
      }
    }
  }
}
```
{% endcode %}
{% endtab %}

{% tab title="Version 8" %}
{% code title="web.config" %}
```xml
<appSettings>
  ...
  <add key="Umbraco.Cms.Integrations.Crm.Dynamics.UseUmbracoAuthorization" value="true/false" />
  <add key="Umbraco.Cms.Integrations.Crm.Dynamics.ClientId" value="[your client id]" />
  <add key="Umbraco.Cms.Integrations.Crm.Dynamics.ClientSecret" value="[your client secret]" />
  <add key="Umbraco.Cms.Integrations.Crm.Dynamics.RedirectUri" value="https://[your website base URL]/umbraco/api/dynamicsauthorization/oauth" />
  <add key="Umbraco.Cms.Integrations.Crm.Dynamics.TokenEndpoint" value="https://login.microsoftonline.com/common/oauth2/v2.0/token" />
  <add key="Umbraco.Cms.Integrations.Crm.Dynamics.Scopes" value="https://[your instance].crm4.dynamics.com/.default" />
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

The authorization mode is toggled by the `UseUmbracoAuthorization` flag, which by default is set to `true` so previous versions of the integration are not impacted.

Authorization specific methods are exposed by the [`IDynamicsAuthorizationService`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Crm.Dynamics/Services/IDynamicsAuthorizationService.cs) and implemented by two services:
- [UmbracoAuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Crm.Dynamics/Services/UmbracoAuthorizationService.cs)
- [AuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Crm.Dynamics/Services/AuthorizationService.cs)

The used service is provided using the `AuthorizationImplementationFactory` method, depending on the type of authorization selected.

If you are selecting your own authorization flow that uses the `AuthorizationService`, the redirect URL will be this one: `/umbraco/api/dynamicsauthorization/oauth`, from [`DynamicsAuthorizationController`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Crm.Dynamics/Controllers/DynamicsAuthorizationController.cs). Please make sure to set to correct URL in the settings of the website and in the configuration of your Shopify app.

The authorization controller uses the `window.postMessage` interface for cross-window communications when redirecting from the _Microsoft_ authorization server.

## Backoffice usage

To use the form picker, a new Data Type needs to be created based on the Dynamics Form Picker property editor.

The settings in `Web.config`/`appsettings.json` will be used for sending authorization and data requests to the Dynamics API, through the _0Auth Proxy for Umbraco Integrations_ or directly.

The _Connect_ button prompts the user with the Microsoft authorization window, which after a successful authentication will send the authorization code back.

The retrieved access token will be saved into the database and used for future requests.

_Revoke_ action will remove the access token from the database and the authorization process will need to be repeated.

## Front-end rendering

A strongly typed model will be generated by the property value converter. An HTML helper is available to render the form on the front end.

Ensure your template has a reference to the following using statement:

```csharp
@using Umbraco.Cms.Integrations.Crm.Dynamics.Helpers;
```

Assuming a property based on the created Data Type with the alias `dynamicsForm` has been created, render the form using:

```csharp
@Html.RenderDynamicsForm(Model.DynamicsForm)
```

The selected form is embedded either through an _iframe_ or by using scripts.

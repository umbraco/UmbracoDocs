---
description: >-
  Details an integration available for Hubspot, built and maintained by Umbraco
  HQ.
---

# HubSpot

This integration provides a form picker and rendering component for forms managed within a [Hubspot](https://www.hubspot.com/) account.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Crm.Hubspot)
* [Source code](https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.Crm.Hubspot)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.cms.integrations.crm.hubspot)

## Minimum version requirements

To ensure compatibility, check the **Dependencies** tab on NuGet for the required Umbraco CMS version. For example, see [Umbraco.Cms.Integrations.Crm.Hubspot](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Crm.Hubspot#dependencies-body-tab).

## Authentication

The package uses the OAuth protocol for authentication or private access tokens if you are using a private app installed on your HubSpot account.

## Additional Configuration

To support multi-region HubSpot forms, the following configuration is required:

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
```json
  "Umbraco": {
    "Integrations": {
      "Crm": {
        "Hubspot": {
          "Settings": {
            "ApiKey": "[your_private_app_access_token]",
            "Region": "[region]"
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
    <add key="Umbraco.Cms.Integrations.Crm.Hubspot.ApiKey" value="[your_private_app_access_token]" />
    <add key="Umbraco.Cms.Integrations.Crm.Hubspot.Region" value="[region]" />
  </appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

For example, in Europe, a setting of `eu1` should be used.

### Self Hosted OAuth Configuration

The easiest way to configure the integration is to make use of an application Umbraco has pre-configured with HubSpot. With this in place, the authorization flow will go through a proxy website Umbraco maintains before redirecting back to your Umbraco backoffice.

From version 2.1.0, we introduced an alternate approach that requires a little more setup. It removes the need for relying on any services from Umbraco when using the integration.

To use this you need to setup your own app with HubSpot and use an extended configuration like this:

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "Integrations": {
      "Crm": {
        "Hubspot": {
          "Settings": {
            ...
            "UseUmbracoAuthorization": true/false
          },
          "OAuthSettings": {
              "ClientId": "[your client id]",
              "ClientSecret": "[your client secret]",
              "RedirectUri": "https://[your website base URL]/umbraco/api/hubspotauthorization/oauth",
              "TokenEndpoint": "[hubspot token endpoint]",
              "Scopes": "[scopes]"
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
  <add key="Umbraco.Cms.Integrations.Crm.Hubspot.UseUmbracoAuthorization" value="true/false" />
  <add key="Umbraco.Cms.Integrations.Crm.Hubspot.ClientId" value="[your client id]" />
	<add key="Umbraco.Cms.Integrations.Crm.Hubspot.ClientSecret" value="[your client secret]" />
	<add key="Umbraco.Cms.Integrations.Crm.Hubspot.RedirectUri" value="https://[your website base URL]/umbraco/api/hubspotauthorization/oauth" />
	<add key="Umbraco.Cms.Integrations.Crm.Hubspot.TokenEndpoint" value="[hubspot token endpoint]" />
	<add key="Umbraco.Cms.Integrations.Crm.Hubspot.Scopes" value="[scopes]" />
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

The authorization mode is toggled by the `UseUmbracoAuthorization` flag, which by default is set to `true` meaning that previous versions are not impacted.

Authorization specific methods are exposed by the [`IHubspotAuthorizationService`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Crm.Hubspot.Core/Services/IHubspotAuthorizationService.cs) and implemented by two services:

- [UmbracoAuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Crm.Hubspot.Core/Services/UmbracoAuthorizationService.cs)
- [AuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Crm.Hubspot.Core/Services/AuthorizationService.cs)

The used service is provided using the `AuthorizationImplementationFactory` method, depending on the type of authorization selected.

If you are selecting your own authorization flow that uses the `AuthorizationService`, the redirect URL will be this one: `/umbraco/api/hubspotauthorization/oauth`, from [`HubspotAuthorizationController`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Crm.Hubspot.Core/Controllers/HubspotAuthorizationController.cs). Make sure to set to correct URL in the settings of the website and in the configuration of your _Hubspot_ app.

The authorization controller uses the `window.postMessage` interface for cross-window communications when redirecting from the Hubspot authorization server.

## Backoffice usage

To use the form picker, a new Data Type should be created based on the HubSpot Form Picker property editor.

The settings will be checked and a message presented indicating whether authentication is in place.

If OAuth is being used for authentication the _Connect_ button will be enabled. When clicked, you will be prompted by the HubSpot authorization window.

The retrieved access token will be saved into the database and used for future requests.

The _Revoke_ action will remove the access token from the database and the authorization process will need to be repeated.

If a private access token is used a message will be displayed notifying that the access token is being used.

## Front-end rendering

A strongly typed model will be generated by the property value converter. An HTML helper is available, to render the form on the front end.

Ensure your template has a reference to the following using statement:

```csharp
@using Umbraco.Cms.Integrations.Crm.Hubspot.Core.Helpers;
```

Assuming a property based on the created Data Type with the `hubSpotForm` has been created, render the form using:

```csharp
@Html.RenderHubspotForm(Model.HubspotForm)
```

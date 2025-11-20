---
description: >-
  Details an integration available for Semrush, built and maintained by Umbraco
  HQ.
---

# Semrush

This integration provides a keywords search tool powered by [Semrush](https://www.semrush.com/).

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Cms.Integrations.SEO.Semrush)
* [Source code](https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.SEO.Semrush)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.cms.integrations.seo.semrush)

## Minimum version requirements

To ensure compatibility, check the **Dependencies** tab on NuGet for the required Umbraco CMS version. For example, see [Umbraco.Cms.Integrations.SEO.Semrush](https://www.nuget.org/packages/Umbraco.Cms.Integrations.SEO.Semrush#dependencies-body-tab).

## How To Use

Once the package is installed, the integration is made available in the Umbraco backoffice as a Content App.

The Content App is available for all types of content items as well as for all user groups.

A keyword search can be initiated using a content field as a starting point, or by entering a custom phrase. The results can be filtered for different metrics across markets.

Administrators are provided with additional features for managing the connectivity with their organization's account with Semrush.

For more detail on the integration, its purpose, and how2 it was built, see the [accompanying blog post](https://umbraco.com/blog/integrating-umbraco-cms-with-semrush/).

### Self Hosted OAuth Configuration

The easiest way to configure the integration is to make use of an application Umbraco has pre-configured with Semrush. With this in place, the authorization flow will go through a proxy website Umbraco maintains before redirecting back to your Umbraco backoffice.

From version 1.2.0, we introduced an alternate approach that requires a little more setup. It removes the need for relying on any services from Umbraco when using the integration.

To use this you need to setup your own app with Semrush and use an extended configuration like this:

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "Integrations": {
      "SEO": {
        "Semrush": {
          "Settings": {
            "BaseUrl": "https://oauth.semrush.com/",
            "UseUmbracoAuthorization": true/false
          },
          "OAuthSettings": {
              "Ref": "[your ref number]",
              "ClientId": "[your client id]",
              "ClientSecret": "[your client secret]",
              "RedirectUri": "https://[your website base URL]/umbraco/api/semrushauthorization/oauth",
              "TokenEndpoint": "https://oauth.semrush.com/oauth2/access_token",
              "Scopes": "user.id,domains.info,url.info,positiontracking.info"
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
  <add key="Umbraco.Cms.Integrations.SEO.Semrush.BaseUrl" value="https://oauth.semrush.com/" />
  <add key="Umbraco.Cms.Integrations.SEO.Semrush.UseUmbracoAuthorization" value="true/false" />
  <add key="Umbraco.Cms.Integrations.SEO.Semrush.ClientId" value="[your client id]" />
	<add key="Umbraco.Cms.Integrations.SEO.Semrush.ClientSecret" value="[your client secret]" />
	<add key="Umbraco.Cms.Integrations.SEO.Semrush.RedirectUri" value="https://[your website base URL]/umbraco/api/semrushauthorization/oauth" />
	<add key="Umbraco.Cms.Integrations.SEO.Semrush.TokenEndpoint" value="https://oauth.semrush.com/oauth2/access_token" />
	<add key="Umbraco.Cms.Integrations.SEO.Semrush.Scopes" value="user.id,domains.info,url.info,positiontracking.info" />
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

The authorization mode is toggled by the `UseUmbracoAuthorization` flag, which by default is set to `true` meaning that previous versions are not impacted.

Authorization specific methods are exposed by the [`ISemrushAuthorizationService`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.SEO.Semrush/Services/ISemrushAuthorizationService.cs) and implemented by two services:

- [UmbracoAuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.SEO.Semrush/Services/UmbracoAuthorizationService.cs)
- [AuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.SEO.Semrush/Services/AuthorizationService.cs)

The used service is provided using the `AuthorizationImplementationFactory` method, depending on the type of authorization selected.

If you are selecting your own authorization flow that uses the `AuthorizationService`, the redirect URL will be this one: `/umbraco/api/semrushauthorization/oauth`, from [`SemrushAuthorizationController`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.SEO.Semrush/Controllers/SemrushAuthorizationController.cs). Make sure to set to correct URL in the settings of the website and in the configuration of your _Semrush_ app.

The authorization controller uses the `window.postMessage` interface for cross-window communications when redirecting from the semrush authorization server.

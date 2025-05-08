---
description: >-
  Details an integration available for Google Search Console, built and
  maintained by Umbraco HQ.
---

# Google Search Console

This integration provides an extension for Umbraco CMS. It provides details on indexed URLs managed in Google Search Console.

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.URLInspectionTool)
* [Source code](https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.UrlInspectionTool)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.cms.integrations.seo.googlesearchconsole.urlinspectiontool)

## Minimum version requirements

To ensure compatibility, check the **Dependencies** tab on NuGet for the required Umbraco CMS version. For example, see [Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.URLInspectionTool](https://www.nuget.org/packages/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.URLInspectionTool#dependencies-body-tab).

## Authentication

The package uses the OAuth2 security protocol for authentication. After the authorization process completes successfully, the access token and the refresh token will be saved into the Umbraco database.

All requests to the Google Search Console API will include the access token in the authorization header.

### Self Hosted OAuth Configuration

The easiest way to configure the integration is to make use of an application Umbraco has pre-configured with Google. With this in place, the authorization flow will go through a proxy website Umbraco maintains before redirecting back to your Umbraco backoffice.

From version 1.1.0, we introduced an alternate approach that requires a little more setup. It removes the need for relying on any services from Umbraco when using the integration.

To use this you need to setup your own app with Google and use an extended configuration like this:

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "Integrations": {
      "SEO": {
        "GoogleSearchConsole": {
          "Settings": {
            ...
            "UseUmbracoAuthorization": true/false
          },
          "OAuthSettings": {
              "ClientId": "[your client id]",
              "ClientSecret": "[your client secret]",
              "RedirectUri": "https://[your website base URL]/umbraco/api/googlesearchconsoleauthorization/oauth",
              "TokenEndpoint": "[google token endpoint]",
              "Scopes": "https://www.googleapis.com/auth/webmasters https://www.googleapis.com/auth/webmasters.readonly"
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
  <add key="Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.UseUmbracoAuthorization" value="true/false" />
  <add key="Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.ClientId" value="[your client id]" />
	<add key="Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.ClientSecret" value="[your client secret]" />
	<add key="Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.RedirectUri" value="https://[your website base URL]/umbraco/api/googlesearchconsoleauthorization/oauth" />
	<add key="Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.TokenEndpoint" value="[google token endpoint]" />
	<add key="Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.Scopes" value="https://www.googleapis.com/auth/webmasters https://www.googleapis.com/auth/webmasters.readonly" />
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

The authorization mode is toggled by the `UseUmbracoAuthorization` flag, which by default is set to `true` meaning that previous versions are not impacted.

Authorization specific methods are exposed by the [`IGoogleAuthorizationService`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.UrlInspectionTool/Services/IGoogleAuthorizationService.cs) and implemented by two services:

- [UmbracoAuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.UrlInspectionTool/Services/UmbracoAuthorizationService.cs)
- [AuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.UrlInspectionTool/Services/AuthorizationService.cs)

The used service is provided using the `AuthorizationImplementationFactory` method, depending on the type of authorization selected.

If you are selecting your own authorization flow that uses the `AuthorizationService`, the redirect URL will be this one: `/umbraco/api/Googleauthorization/oauth`, from [`GoogleAuthorizationController`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.SEO.GoogleSearchConsole.UrlInspectionTool/Controllers/GoogleSearchConsoleAuthorizationController.cs). Make sure to set to correct URL in the settings of the website and in the configuration of your _Google_ app.

The authorization controller uses the `window.postMessage` interface for cross-window communications when redirecting from the Google Search Console authorization server.

## Working With the URL Inspection Tool

The URL Inspection Tool is accessible from each content node via the **URL Inspection** content app.

If you haven't connected your Google account yet, you can authorize your Umbraco application by using the _Connect_ button. This will prompt the Google authorization window and at the end of the process, you will receive the access token and the refresh token.

You can also choose to remove access to Google Search Console API by triggering the _Revoke_ action. This will remove the access token and the refresh token from the database.

Before you can retrieve data from the Search Console API you need to register the domain of your Umbraco website. This is done at the [Google Search Console](https://search.google.com/search-console).

After Google has verified your ownership, the _URL Inspection_ tool will provide the proper results. Otherwise, a "permission denied" error will be shown.

## The URL Inspection Tool API

The URL Inspection Tool API expects three parameters, two mandatory:

* InspectionUrl - a fully-qualified URL to inspect. It must be under the property specified in "siteUrl".
* SiteUrl - the URL of the property as defined in the Search Console.
* LanguageCode - optional; the default value is "en-US".

More information can be found [in the official Google Developers documentation](https://developers.google.com/webmaster-tools/v1/urlInspection.index/inspect).

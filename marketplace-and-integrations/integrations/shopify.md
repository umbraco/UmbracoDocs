---
description: >-
  Details an integration available for Shopify, built and maintained by Umbraco
  HQ.
---

# Shopify

This integration provides a product picker and a value converter that creates a strongly typed model for rendering. Products can be retrieved from a [Shopify](https://www.shopify.com/) store or through custom apps developed by [Shopify Partners](https://www.shopify.com/partners).

## Package Links

* [NuGet install](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Commerce.Shopify)
* [Source code](https://github.com/umbraco/Umbraco.Cms.Integrations/tree/main/src/Umbraco.Cms.Integrations.Commerce.Shopify)
* [Umbraco marketplace listing](https://marketplace.umbraco.com/package/umbraco.cms.integrations.commerce.shopify)

## Minimum version requirements

To ensure compatibility, check the **Dependencies** tab on NuGet for the required Umbraco CMS version. For example, see [Umbraco.Cms.Integrations.Commerce.Shopify](https://www.nuget.org/packages/Umbraco.Cms.Integrations.Commerce.Shopify#dependencies-body-tab).

## Authentication

The package supports two modes of authentication:

* API Access Token
* OAuth

### API Access Token

Follow these steps to retrieve an API Access token:

1. Log into the admin interface of your shop by accessing `https://{shop}.myshopify.com/admin`.
2. Go to **Apps > Develop apps**.
3. Create a new App for the shop.
4. Enable the App Development feature if it is currently disabled.
5. Define the scopes for the Admin API: _read\_products_.
6. Select the option to **Install App**.

Once the app is installed the Admin API access token will be visible **only once** in the _API credentials_ tab.

Use the access token and add it to your website's configuration file alongside settings for the API version and the name of the shop:

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "Integrations": {
      "Commerce": {
        "Shopify": {
          "Settings": {
            "ApiVersion": "2022-01",
            "Shop": "[your shop's name]",
            "AccessToken": "[your access token]",
            "CacheLevel": "Snapshot"
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
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.ApiVersion" value="2022-01" />
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.AccessToken" value="[your access token]" />
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.Shop" value="[your shop's name]" />
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.CacheLevel" value="Snapshot" />
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

Shopify releases a new API version every 3 months at the beginning of the quarter. The latest stable version used for this integration is [2022-01](https://shopify.dev/api/usage/versioning).

### OAuth

If you prefer not to use an API token, an authentication flow using OAuth is also available.

To use this, ensure you do not have an API key in your configuration file.

### Self Hosted OAuth Configuration

The easiest way to configure the integration is to make use of an application Umbraco has pre-configured with Shopify. With this in place, the authorization flow will go through a proxy website Umbraco maintains before redirecting back to your Umbraco backoffice.

From version 1.1.0, we introduced an alternate approach that requires a little more setup. It removes the need for relying on any services from Umbraco when using the integration.

To use this you need to setup your own app with Shopify and use an extended configuration like this:

{% tabs %}
{% tab title="Versions 9 and above" %}
{% code title="appsettings.json" %}
```json
"Umbraco": {
  "CMS": {
    "Integrations": {
      "Commerce": {
        "Shopify": {
          "Settings": {
            ...
            "UseUmbracoAuthorization": true/false
          },
          "OAuthSettings": {
              "ClientId": "[your client id]",
              "ClientSecret": "[your client secret]",
              "RedirectUri": "https://[your website base URL]/umbraco/api/shopifyauthorization/oauth",
              "TokenEndpoint": "https://[your shop].myshopify.com/admin/oauth/access_token",
              "Scopes": "read_products"
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
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.UseUmbracoAuthorization" value="true/false" />
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.ClientId" value="[your client id]" />
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.ClientSecret" value="[your client secret]" />
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.RedirectUri" value="https://[your website base URL]/umbraco/api/shopifyauthorization/oauth" />
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.TokenEndpoint" value="https://[your shop].myshopify.com/admin/oauth/access_token" />
  <add key="Umbraco.Cms.Integrations.Commerce.Shopify.Scopes" value="read_products" />
</appSettings>
```
{% endcode %}
{% endtab %}
{% endtabs %}

The authorization mode is toggled by the `UseUmbracoAuthorization` flag, which by default is set to `true` meaning that previous versions of the integration are not impacted.

Authorization specific methods are exposed by the [`IShopifyAuthorizationService`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Commerce.Shopify/Services/IShopifyAuthorizationService.cs) and implemented by two services:

- [UmbracoAuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Commerce.Shopify/Services/UmbracoAuthorizationService.cs)
- [AuthorizationService](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Commerce.Shopify/Services/AuthorizationService.cs)

The used service is provided using the `AuthorizationImplementationFactory` method, depending on the type of authorization selected.

If you are selecting your own authorization flow that uses the `AuthorizationService`, the redirect URL will be this one: `/umbraco/api/shopifyauthorization/oauth`, from [`ShopifyAuthorizationController`](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Commerce.Shopify/Controllers/ShopifyAuthorizationController.cs). Please make sure to set to correct URL in the settings of the website and in the configuration of your Shopify app.

The authorization controller uses the `window.postMessage` interface for cross-window communications when redirecting from the Shopify authorization server.

### CacheLevel

Added in version 1.3.0 of the integration.

The property cache level is set to `Snapshot` by default. This means that sites utilizing this integration can hit rate limits on the Shopify Admin API. More information on rate limits can be found in the Shopify Development Documentation under [Shopify Rate Limits](https://shopify.dev/docs/api/usage/rate-limits). The default value `Snapshot` has been retained for backward compatibility.

The values available are:

- `Snapshot` (default)
- `Unknown`
- `Element`
- `Elements`
- `None`

The values correlate to the values available for property caching. More information on property caching is available in the [Property Cache Level](https://docs.umbraco.com/umbraco-cms/10.latest/extending/property-editors/property-value-converters#propertycachelevel-getpropertycachelevel-ipublishedpropertytype-propertytype) article.


## Backoffice usage

To use the products picker, a new Data Type should be created based on the Shopify Products Picker property editor.

The settings in `Web.config` will be checked and a message presented indicating whether authentication is in place.

If OAuth is being used for authentication, then the _Connect_ button will be enabled. When clicked, the user will be prompted with the Shopify authorization window.

The retrieved access token will be saved into the database and used for future requests.

The _Revoke_ action will remove the access token from the database and the authorization process will need to be repeated.

## Front-end rendering

A [strongly typed model](https://github.com/umbraco/Umbraco.Cms.Integrations/blob/main/src/Umbraco.Cms.Integrations.Commerce.Shopify/Models/ViewModels/ProductViewModel.cs) will be generated by the property value converter. An HTML helper is available, to render the products on the front end.

Ensure your template has a reference to the following using statement:

```csharp
@using Umbraco.Cms.Integrations.Commerce.Shopify.Helpers;
```

Assuming a property based on the created Data Type with the alias `shopifyProductPicker` has been created, render the form using:

```csharp
@Html.RenderShopifyProductsList(Model.ShopifyProductPicker)
```

You can use the default rendering view and style using the existing CSS classes, or use it as inspiration for your views. The path to your custom view will be then passed as a parameter to the HTML helper method.


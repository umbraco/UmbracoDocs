---
description: >-
  This document covers specific upgrade steps if a version requires them. Most
  versions do not require specific upgrade steps and you will be able to upgrade
  directly from your current version.
---

# Version Specific Upgrades

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Version Specific Upgrades

Use the information below to learn about any potential breaking changes and common pitfalls when upgrading your Umbraco CMS project.

If any specific steps are involved with upgrading to a specific version they will be listed below.

Use the [general upgrade guide](../) to complete the upgrade of your project.

### Breaking changes

<details>

<summary>Umbraco 14</summary>

Below you can find the list of breaking changes introduced in Umbraco 14 CMS.

* [**AngularJS removed: A new backoffice built with Web Components, Lit, and fueled by the Umbraco UI Library**](https://github.com/umbraco/Umbraco.CMS.Backoffice)

This is by far the most impactful update of Umbraco in years. We’ve fundamentally changed the way you extend Umbraco. If you are experienced in developing Web Components you can now use your preferred framework for this. If you are unsure how to proceed, you can implement it with Typescript and the Lit library like we’ve done. In this case, please start with this article on how to [customize the Backoffice](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/extending/customize-backoffice).

The new Backoffice (Bellissima) is entirely built on the Umbraco UI Library. This means that you might experience some of your components not being rendered on the page because the name has been changed. You should be able to find equivalents to what you were used to. For example, the `umb-button` is now called `uui-button`, and `umb-box` is now `uui-box`. When extending the Backoffice, we encourage you to use our [Umbraco UI Library](https://uui.umbraco.com/) to ensure the same look and feel in your extensions. The UI Library is Open Source and [hosted on GitHub](https://github.com/umbraco/Umbraco.UI), so feel free to contribute with new components or raise issues or discussions.&#x20;

* **Icons are based on Lucide.**

Umbraco 13 and earlier used various sets of icons ranging from custom SVGs to Font Awesome. This has all been converged into the [Lucide icon pack](https://lucide.dev/) with icon names mapped from Umbraco 13.

* #### Custom icons

To add custom icons to the Backoffice, you must add an extension type called “icons”, which can provide icons given a Name and a File. The file can reside anywhere on disk or in RCLs the only requirements being that it must be routable and it must be an SVG.

* #### User provided translations

Translations used in the UI (which are most of them) have been migrated from XML to JavaScript modules. This means that if you wish to override any of the built-in translation keys for the UI, you will now have to add an extension type called “localization”. It is still possible to add XML translations, but they can no longer be used in the Backoffice UI. However, you may still find usage for them in server-to-server scenarios. Umbraco also keeps its e-mail templates as XML translations. Package and extension developers working with localization will find many benefits from this change seeing that you can add logic to JavaScript modules making your localization files more dynamic and even making them able to react to input parameters.

You can read more about [localization on the Umbraco Documentation](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/extending/language-files).

* #### BackOffice controllers have been replaced with the Management API

Following the implementation of the new Backoffice (Bellissima), Umbraco has now internally upgraded Headless to a first-class citizen. This means that all controllers previously available under the `/umbraco/api` route have been removed and replaced with controllers in the Management API. You can read more about the Management API on [the Umbraco Documentation](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/reference/management-api) and you can check out the Swagger UI in your local Umbraco instance available under `/umbraco/swagger`.

* #### **A new way of writing authorized controllers**

If you have implemented API controllers in Umbraco before, we recommend you update or rewrite these. Please follow this approach \[article from Nikolai V2 is on its way], as you’ll then ensure the same cool documentation of your APIs. Also notice, that we’ve made a much better separation of concern between controllers and services so that there is no more business logic in controllers.&#x20;

* #### [Migration from Newtonsoft.Json to the System.Text.Json which removes Nested Content and Grid value converter and so on](https://github.com/umbraco/Umbraco-CMS/pull/15728)

Although this sounds simple, it’s one of the most breaking changes on the backend. Whereas Newtonsoft.Json was flexible and error-tolerant by default, System.Text.Json is very strict but more secure by default. You can therefore easily run into things that will not be serialized. You can [read more about the differences between Newtonsoft.Json and System.Text.Json here](https://learn.microsoft.com/en-us/dotnet/standard/serialization/system-text-json/migrate-from-newtonsoft?pivots=dotnet-9-0).

* #### Nested Content and Grid Layout have been removed

These two property editors have been deprecated in Umbraco for some time as you can read in our breaking change announcements for[Nested Content](https://github.com/umbraco/Announcements/issues/6) and [Grid Layout](https://github.com/umbraco/Announcements/issues/7). The recommended action is to use blocks instead - Block Grid for the grid layout and either Block Grid or Block List for Nested Content.

* #### [The legacy media picker has been removed](https://github.com/umbraco/Umbraco-CMS/pull/15835)

We have for some time [encouraged to not use the legacy Media Picker](https://github.com/umbraco/Announcements/issues/8), and now it’s fully removed. You should use the default Media Picker instead.

* #### Macros and Partial View Macros have been removed. Use partial views and/or blocks in the Rich Text Editor (RTE)

Depending on the usage of macros, you’ll be able to use either partial views or blocks in the RTE. They are not the same kind of functionality, but they cover all the identified use cases in a way more consistent and supportable way. &#x20;

* #### XPath has been removed

An alternative is using the Dynamic Roots in the Multinode Treepicker and for ContentXPath the alternative is [IContentLastChanceFinder](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/tutorials/custom-error-page).

* #### [The package manifest format has changed](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/extending/property-editors/package-manifest)

The `package.manifest` file is no longer supported and has been replaced with the `umbraco-package.json` file. The format is very similar and after building your Umbraco solution, you will have access to a JSON schema file, that you can reference and thereby have type-safety in the file. You can read more about the new format on [the Umbraco Documentation](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/extending/property-editors/package-manifest).

* #### Smidge is no longer a default dependency

[Smidge has been removed from the default installation](https://github.com/umbraco/Umbraco-CMS/pull/15788) along with the RuntimeMinification setting and related classes. Smidge used to bundle up Backoffice and package assets before, however, with the Bellissima, we have migrated entirely to ESModules. This means we can no longer predict how modules work in automated bundles.&#x20;

We recommend that you bundle up your Backoffice static assets for instance by a tool called Vite, which you can read more about on [the Umbraco Documentation](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/extending/customize-backoffice/development-flow/vite-package-setup). You can still use libraries like Smidge for frontend static assets by manually installing the package from NuGet.&#x20;

You can read the [Smidge documentation](https://github.com/Shazwazza/Smidge/wiki) on how to set up a similar setting to RuntimeMinification.\
For sites being upgraded from V13 or below, please remove [these lines](https://github.com/umbraco/Umbraco-CMS/blob/04ed514a21279ae82d95b34c55cb2ba96545eb39/src/Umbraco.Web.UI/Views/\_ViewImports.cshtml#L7-L8) from the `_ViewImports.cshtml` file.

* #### Base classes for Backoffice controllers have been removed

The `UmbracoAuthorizedApiController` and `UmbracoAuthorizedJsonController` classes have been removed. We recommend basing your Backoffice APIs on the `ManagementApiControllerBase` class from the `Umbraco.Cms.Api.Management` project.

Please read the [Creating a Custom API article](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/fundamentals/backoffice/create-your-own-api) for a comprehensive guide to writing APIs for the Management API.

* #### Removal of certain AppSettings

Some AppSettings have been removed or found a new place. In general, any UI-related app settings will now have to be configured as [extensions through the manifest system](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/extending/backoffice-setup/extension-types).

* #### RichTextEditor

The global configuration of TinyMCE has been removed in order to support more rich text editors in the future. Instead, a new extension type called “tinyMcePlugin” has been added. This extension type gives you access to each instance of TinyMCE allowing you to configure it exactly as you see fit. You can even make it dependent on more factors such as document type, user group, environment, and much more. You have access to the full array of contexts in the Backoffice.

* #### ShowDeprecatedPropertyEditors

There are no deprecated property editors in Bellissima and this configuration will no longer have an effect.

* #### HideBackOfficeLogo

This configuration will no longer have an effect. Instead, you can add a CSS file where you can modify the default CSS variables in the Backoffice. The Backoffice loads a CSS file which can be overwritten by placing a similar file in your project at `/umbraco/backoffice/css/user-defined.css` with the following content:

```css
:root {
  --umb-header-logo-display: none;
}
```

* #### IconsPath

This configuration will no longer have an effect. Instead, you should add icons through the “icons” extension type.

* #### AllowedMediaHosts

This configuration will no longer have an effect.

* #### Notifications

Notifications have changed their behavior to an extent. You can still implement notifications such as `ContentSavingNotification` to react to changes for related systems or add messages to be shown in the Backoffice. You can no longer modify the models being transferred through the API.&#x20;

If you wish to modify the Backoffice UI, you should register extensions through the manifest system that hook on to the desired areas of the Backoffice UI. If you used to modify the models because you needed more data on the models, we now recommend that you build your own API controller to achieve this. You can read more about [building custom API controllers on the Umbraco Documentation](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/reference/custom-swagger-api) and even learn how to register your controllers in the Swagger UI.

* #### Property editors have been split in two

The new Backoffice and the Management API ushers in a shift in responsibility. Traditionally, a lot of UI responsibility has been misplaced on the server.

For example, it is hardly a server concern how many rows a text area should span by default.

To this end, property editors have been split into two, individually reusable parts; the server implementation and the client implementation.

As a consequence, a property editor must now define both which client and server implementation to use. Details can be found in [this article](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/tutorials/creating-a-property-editor).

* #### Property value converters for package.manifest based property editors

The `package.manifest` file format is no longer known on the server side. It has been changed to be a purely client-side responsibility (and it has adopted a new format and a new name). If you have implemented a property value converter for a property editor defined in a `package.manifest` file, you will likely need to make a small change to the property value converter.&#x20;

The property value converter must implement `IsConverter()` to determine if it can handle a given property. In this implementation, it is quite common to use the EditorAlias of the passed in IPublishedPropertyType. However, in Umbraco 14 you should use the EditorUiAlias instead.

More details can be found in [this article](https://docs.umbraco.com/umbraco-cms/v/14.latest-rc/tutorials/creating-a-property-editor/custom-value-conversion-for-rendering).

* **UmbracoApiController breakage**

Due to the shift from `Newtonsoft.Json` to the `System.Text.Json`, the `UmbracoApiController` will yield camel-cased output in Umbraco 14, where it was pascal-cased in the previous versions.

Make sure to perform thorough testing of all usages of `UmbracoApiController`. As the class has now been marked as obsolete, we recommend these controllers to be based on the Controller class from ASP.NET Core moving forward.

* **Two-Factor Authentication requires a client registration**

The C# models for Two-Factor Authentication previously supported setting a custom AngularJS view to setup the QR code. This has been moved to the Backoffice client and requires a registration through the new extension type [`mfaProvider`](../../../../extending/property-editors/package-manifest):

```typescript
    {
      "type": "mfaLoginProvider",
      "alias": "my.2fa.provider",
      "name": "My 2fa Provider",
      "forProviderName": "UmbracoUserAppAuthenticator",
      "meta": {
        "label": "Authenticate with a 2FA code"
      }
    }
```

This will use Umbraco’s default configuration of the two-factor provider. The user scans a QR code using an app such as Google Authenticator or Authy by Twilio.

It is additionally possible to register your own configurator similar to Umbraco 13. You can achieve this by providing a custom JavaScript element through the `elementJs` property.

More details and code examples can be found in the [Two-Factor Authentication](../../../../reference/security/two-factor-authentication.md) article.

* **External Login Providers require a client registration**

The C# models for External Login Providers have changed and no longer hold configuration options for the “Sign in with XYZ” button. To show a button in the Backoffice to sign in with an external provider, you need to register this through the extension type called [`authProvider`](../../../../extending/property-editors/package-manifest.md) : &#x20;

```typescript
   {
      "type": "authProvider",
      "alias": "My.AuthProvider.Google",
      "name": "Google Auth Provider",
      "forProviderName": "Umbraco.Google",
      "meta": {
        "label": "Google",
        "defaultView": {
          "icon": "icon-google"
        },
        "linking": {
          "allowManualLinking": true
        }
      }
    }

```

This will use Umbraco’s default button to sign in with the provider. You can also choose to provide your own element to show in the login form. You can achieve this by adding the `elementJs` property.

Additionally, on the backend side, there is an additional helper available to do proper error handling. You can utilize this by using the options pattern to configure the provider.

More details and code examples can be found in the [External Login Providers](../../../../reference/security/external-login-providers.md) article.\

**In-depth and further breaking changes for Umbraco 14 can be found on the** [**CMS GitHub**](https://github.com/umbraco/Umbraco-CMS/pulls?q=is%3Apr+base%3Av14%2Fdev+label%3Acategory%2Fbreaking) **repository and on** [**Our Website**](https://our.umbraco.com/download/releases/1400)**.**

</details>

<details>

<summary>Umbraco 14 RC Versions</summary>

Below you can find the list of breaking changes introduced in Umbraco 14 RC release versions.

**RC 4**

* [Bellissima (frontend/backoffice) changes](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-rc4)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-rc4)

**RC 3**

* [Bellissima (frontend/backoffice) changes](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-rc3)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-rc3)

**RC 2**

* [Bellissima (frontend/backoffice) changes](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-rc2)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-rc2)

**RC 1**\
First RC release - 17th of April. Breaking changes since Beta 3:

* [Bellissima (frontend/backoffice) changes](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-rc1)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-rc1)

</details>

<details>

<summary>Umbraco 14 Beta Versions</summary>

Below you can find the list of breaking changes introduced in Umbraco 14 Beta release versions.

**Beta 3**

* [Bellissima (frontend/backoffice) changes](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-beta003)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-beta003)

**Beta 2**

There are a few breaking changes since **Beta 1**. Most of the changes concern property editors and getting them to work with migrations as well as new values.

* [Bellissima (frontend/backoffice) changes](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-beta002)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-beta002)

**Beta 1**\
Official release of Beta, 6th March 2023.

* [Bellissima (frontend/backoffice) changes](https://github.com/umbraco/Umbraco.CMS.Backoffice/releases/tag/v14.0.0-beta001)
* [Backend (CMS) changes](https://github.com/umbraco/Umbraco-CMS/releases/tag/release-14.0.0-beta001)

</details>

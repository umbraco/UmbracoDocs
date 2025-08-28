---
description: Get an overview of the things changed and fixed in each version of Umbraco Forms.
---

# Release notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific/) article.
{% endhint %}

## Release history

This section contains the release notes for Umbraco Forms 16 including all changes for this version.

### [16.1.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.1.0) (August 28th 2025)

#### Add support for subscription licensing using product key

In addition to the existing one-off license using the `umbracoForms.lic` file, support for configuring a subscription license using a product key is added. As [announced](https://github.com/umbraco/Announcements/issues/25), Forms 17 will only be available through a subscription-based license. To make the transition to this upcoming major easier, you can already purchase a new subscription (avoiding the one-off purchase) or convert your recently purchased one-off license into a subscription.

The 14-day trail license isn't generated anymore on install, but you can still fully test Forms on localhost. Configuring the license from the backoffice is also removed due to the direct integration with the legacy license infrastructure and to align the license management to the Licenses dashboard in the Settings section.

Read more about [the licensing model](./installation/the-licensing-model.md).

#### Only show reCAPTCHA v2 or v3 fields when settings are configured

Forms provides reCAPTCHA v2 and v3 fields out-of-the-box, but both were always shown to editors in the backoffice. These fields are now only shown when their respective settings are configured. This avoids editors adding a reCAPTCHA field that doesn't work due to missing configuration and/or mixing up the v2 and v3 versions.

If the settings aren't configured in `appsettings.json` or environment variables (and thus available through `IConfiguration`), the required field needs to be manually added. This can be the case when manually configuring the `Recaptcha2Settings` or `Recaptcha3Settings` object in code:

```csharp
builder.Services.Configure<Recaptcha3Settings>(options =>
{
    options.SiteKey = "...";
    options.PrivateKey = "...";
});

// Ensure the field is added and available
builder.FormsFields().Add<Recaptcha3>();
```

#### Allow using ViewEngine to resolve theme views

The default theme views are resolved using the [Partial Views file system](../umbraco-cms/extending/filesystemproviders/README.md#other-ifilesystems) (an abstraction over the `/Views/Partials` directory). This requires I/O lookups to determine whether specific theme views exist and manually specifying all files when using a [Razor Class Library](./developer/themes.md#shipping-themes-in-a-razor-class-library).

By enabling the [`UseViewEngineFormThemeResolver` setting](./developer/configuration/README.md#useviewengineformthemeresolver), theme vies are resolved using the `ICompositeViewEngine`, which will include compiled views (including those shipped in RCLs).

### [16.0.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (June 12th 2025)

* Compatibility with Umbraco 16.0.0

### [16.0.0-rc5](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (June 10th 2025)

* Compatibility with Umbraco 16.0.0-rc6
* Removed obsolete code

### [16.0.0-rc4](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (June 10th 2025)

* Compatibility with Umbraco 16.0.0-rc5

### [16.0.0-rc3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (June 3rd 2025)

* Compatibility with Umbraco 16.0.0-rc4
* Fix field/workflow settings not displaying in dialogs

### [16.0.0-rc2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 26th 2025)

* Compatibility with Umbraco 16.0.0-rc3
* Remove dependency on shop.umbraco.com (no trial license generation on install or retrieval of license in backoffice)
* Replace Excel export (using outdated EPPlus dependency) with CSV export using CsvHelper
* Add 'Save and preview' feature [#655](https://github.com/umbraco/Umbraco.Forms.Issues/issues/655)

### [16.0.0-rc1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.0.0) (May 15th 2025)

* Compatibility with Umbraco 16.0.0-rc2
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrading/version-specific/).

## Umbraco.Forms.Deploy

This Deploy add-on adds support for transferring, restoring, exporting and importing (including migrating between major versions) of Umbraco Forms data.

### 16.0.0 (June 12th 2025)

* Update Forms and Deploy dependencies to 16.0.0

### 16.0.0-rc5 (June 10th 2025)

* Update Forms and Deploy dependencies to 16.0.0-rc5

### 16.0.0-rc4 (June 10th 2025)

* Update Forms and Deploy dependencies to 16.0.0-rc4

### 16.0.0-rc3 (June 3rd 2025)

* Update Forms and Deploy dependencies to 16.0.0-rc3

### 16.0.0-rc2 (May 30th 2025)

* Update Forms and Deploy dependencies to 16.0.0-rc2
* Update client-side entity types to align with server-side (UDI entity types)

### 16.0.0-rc1 (May 20th 2025)

* Update Forms and Deploy dependencies to 16.0.0-rc1

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/12/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).

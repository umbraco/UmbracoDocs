---
description: Get an overview of the things changed and fixed in each version of Umbraco Forms.
---

# Release notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

## Release history

This section contains the release notes for Umbraco Forms 16 including all changes for this version.

### [16.4.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.4.1) (January 29th 2026)
* Ensure entries selection can be cleared correctly after delete [#1590](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1590)
* Ensure entries selection can be cleared completely [#1591](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1591)
* Add additional exports for NPM package [#1592](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1592)
* Fix bug where prevalue sources couldn't be saved and didn't show existing values [#1597](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1597)
* Path traversal and file enumeration vulnerability on Linux/macOS [GHSA-hm5p-82g6-m3xh](https://github.com/umbraco/Umbraco.Forms.Issues/security/advisories/GHSA-hm5p-82g6-m3xh)

### [16.4.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.4.0) (January 22nd 2026)
* All items detailed under release candidates for 16.4.0.

### [16.4.0-rc2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.4.0) (January 15th 2026)
* Add confirmation modal for entry bulk deletion [#1490](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1490)
* Fix prevalue source validation [#1549](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1549)
* Fix prevalue source dropdown rendering [#1550](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1550)
* Fix prevalue source disappearing properties [#1551](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1551)
* Add disabled state for unconfigured field types [#1557](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1557)
* Fix form picker multiple value conversion [#1562](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1562)
* Fix form picker multiple selection storage [#1563](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1563)
* Add disabled state to workflows [#1566](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1566)
* Fix workflow sorting [#1567](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1567)
* Allow sorting between workflow stages [#1568](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1568)
* Handle missing or deleted workflows [#1570](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1570)
* Workflow name field now longer [#1573](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1573)
* Fix Forms Theme Picker validation [#1577](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1577)
* Resolve migration of Form Picker and Theme Picker from v13 [#1578](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1578)

### [16.4.0-rc](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.4.0) (January 8th 2026)

#### reCAPTCHA Enterprise field type added

A new reCAPTCHA Enterprise field type has been added. It provides advanced bot protection using Google's reCAPTCHA Enterprise service.

#### Unconfigured reCAPTCHA fields now display as disabled

The reCAPTCHA v2, v3, and Enterprise field types now display as disabled in the form designer. This applies when their respective settings are not configured. It prevents editors from adding unconfigured reCAPTCHA fields that would not work on the frontend.

This change also ensures that field types remain registered. This prevents issues when transferring forms with Umbraco Deploy between environments where reCAPTCHA settings may not yet be configured.

![Disabled reCAPTCHA field type in form designer](images/disabled-fields.png)

* Umbraco CMS dependency updated to 16.4.0
* Add reCAPTCHA Enterprise field type [#1046](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1046)
* Preserving line-spacing in text-area input [#1369](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1369)
* Add `DefaultValue` property to `SettingAttribute` [#1411](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1411)
* Updated field and workflow settings handling when default values are defined [#1421](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1421)
* Load correct icons for all Forms tree items [#1457](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1457)
* Improve field alias logic and input event handling [#1459](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1459)
* Improve form reorder sorting experience [#1482](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1482)
* Fix folder creation for users with single start folder [#1546](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1546)
* Match delete icon to CMS delete icon [#1553](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1553)
* Redesigned Form designer to match CMS content type designer
* Fix redirect on entity creation and improve save flow
* Form Info view: improved references UI and layout
* Update entry filter UI and hide Entries tab for new forms
* Set `Cache-Control` headers of form uploads to `private`

### [16.3.1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.3.1) (December 17th 2025)
* Fix bug with NPM package exports not resolving correctly [#1556](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1556)

### [16.3.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.3.0) (December 11th 2025)
* All items detailed under release candidates for 16.3.0.

### [16.3.0-rc2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.3.0) (December 4th 2025)
* Refactored UX for sorting on form designer [#1458](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1458)
* Render uploaded files as semantically correct HTML [#1373](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1373)
* Filter out fields from email workflows when 'Include Sensitive Data' is set to false [#1402](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1402)
* Normalise the JavaScript `form` parameter to always be the native DOM element [#1477](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1477)
* Fix console error when using `Forms.PropertyEditorUi.TextWithFieldPicker` in custom FieldType or Workflow [#1547](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1547)

### [16.3.0-rc](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.3.0) (November 27th 2025)
* Umbraco CMS dependency updated to 16.3.0
* JavaScript now correctly finds the form config element when it is not adjacent
* Stop "Save and preview" modal from displaying an interstitial state
* Adds additional exports to `@umbraco-forms/backoffice` NPM package
* Razor email templates now format URLs as `UrlMode.Absolute` [#1414](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1414)
* File Upload field now includes `class` attribute [#1495](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1495)
* Fix `ScrollToFormScript` JavaScript not working correctly [#1486](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1486)
* Fix endless submit loop when reinitializing forms with `umbracoFormsReinitialize` [#1491](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1491)
* Resolve issues with missing translations in backoffice [#1492](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1492)

### [16.2.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.2.0) (October 30th 2025)
* All items detailed under release candidates for 16.2.0.

### [16.2.0-rc2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.2.0) (October 27th 2025)
* Improved redirects in UmbracoFormsController for handling IContentFinder and virtual pages [#1456](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1456)
* Refine fieldset caption rendering logic [#1466](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1466)
* Ensure configured stylesheets are loaded in TipTap rich text editor [#1441](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1441)
* Automatically set the `mandatory` field for new fields when field type has `MandatoryByDefault` [#1455](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1455)
* Add `autocomplete` attribute to Password FieldType [#1211](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1211)
* Configure `Umbraco:CMS:Global:Smtp:From` to take priority over `Umbraco:CMS:Content:Notifications:Email` in email workflows [#1417](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1417)

### [16.2.0-rc](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F16.2.0) (October 20th 2025)
* Hide caret from backoffice folders if there are no child items [#1446](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1446)
* Fix type in "Display Layout" property description [#1442](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1442)
* Remove Umbraco branding from default email template [#1433](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1433)
* Fix custom validation messages for "Mandatory" and "Validation" fields [#1416](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1416)
* Fix not being able to create a File upload field [#1409](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1409)
* Ensure record values aren't lost when Form fields are added or removed [#1385](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1385)
* Ensure reCAPTCHA error messages are localized [#1370](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1370)
* Enhance validation checks and field value retrieval when using Advanced Options rules [#1368](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1368)
* Add JavaScript event for post-load form injection [#1224](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1224)
* Evenly space conditions fields rather than size based on contents [#1448](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1448)

### [16.1.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F16.1.0) (August 28th 2025)

#### Add support for subscription licensing using product key

In addition to the existing one-off license using the `umbracoForms.lic` file, support for configuring a subscription license using a product key is added. As [announced](https://github.com/umbraco/Announcements/issues/25), Forms 17 will only be available through a subscription-based license. You can already purchase a new subscription (avoiding the one-off purchase) or convert your recently purchased one-off license into a subscription.

The 14-day trial license is no longer generated on install. You can still fully test Forms on `localhost`. The option to configure the license from the backoffice is removed. This is due to the direct integration with the legacy license infrastructure and to align the license management to the Licenses dashboard.

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
  * See full details of breaking changes under the [Version-specific Upgrade Guide](upgrading/version-specific.md).

## Umbraco.Forms.Deploy

This Deploy add-on adds support for transferring, restoring, exporting and importing (including migrating between major versions) of Umbraco Forms data.

### 16.0.1 (September 24th 2025)

* Fix `FolderConnector.GetRange()` using root string throwing `ArgumentException`

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

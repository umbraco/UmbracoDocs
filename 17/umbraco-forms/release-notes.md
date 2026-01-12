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

This section contains the release notes for Umbraco Forms 17 including all changes for this version.

### [17.1.0-rc](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F17.1.0) (January 8th 2026)
* Umbraco CMS dependency updated to 17.1.0
* Add reCAPTCHA Enterprise field type [#1046](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1046)
* Preserving line-spacing in text-area input [#1369](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1369)
* Add `DefaultValue` property to `SettingAttribute` [#1411](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1411)
* Fix folder creation for users with single start folder [#1546](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1546)
* Updated field and workflow settings handling when default values are defined [#1421](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1421)
* Load correct icons for all Forms tree items [#1457](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1457)
* Improve field alias logic and input event handling [#1459](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1459)
* Improve form reorder sorting experience [#1482](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1482)
* Match delete icon to CMS delete icon [#1553](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1553)
* Redesigned Form designer to match CMS content type designer
* Fix redirect on entity creation and improve save flow
* Form Info view: improved references UI and layout
* Update entry filter UI and hide Entries tab for new forms
* Set `Cache-Control` headers of form uploads to `private`

### [17.0.3](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F17.0.3) (December 17th 2025)
* Fix bug with NPM package exports not resolving correctly [#1556](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1556)

### [17.0.2](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F17.0.2) (December 11th 2025)
* Refactored UX for sorting on form designer [#1458](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1458)
* Render uploaded files as semantically correct HTML [#1373](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1373)
* Filter out fields from email workflows when 'Include Sensitive Data' is set to false [#1402](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1402)
* Normalise the JavaScript `form` parameter to always be the native DOM element [#1477](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1477)
* Fix console error when using `Forms.PropertyEditorUi.TextWithFieldPicker` in custom FieldType or Workflow [#1547](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1547)

### 17.0.1 (November 27th 2025)
* Fix issues with the 17.0.0 release where migrations would sometimes not complete successfully

### [17.0.0](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue%20state%3Aclosed%20label%3Arelease%2F17.0.0) (November 27th 2025)
* Update Forms dependencies to 17.0.0
* All items detailed under release candidates for 17.0.0.
* JavaScript now correctly finds the form config element when it is not adjacent

### 17.0.0-rc4 (November 25th 2025)
* Stop "Save and preview" modal from displaying an interstitial state
* Adds additional exports to `@umbraco-forms/backoffice` NPM package
* Razor email templates now format URLs as `UrlMode.Absolute` [#1414](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1414)
* File Upload field now includes `class` attribute [#1495](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1495)
* Fix `ScrollToFormScript` JavaScript not working correctly [#1486](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1486)
* Fix endless submit loop when reinitializing forms with `umbracoFormsReinitialize` [#1491](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1491)
* Resolve issues with missing translations in backoffice [#1492](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1492)

### 17.0.0-rc3 (November 20th 2025)

* Update dependencies to 17.0.0-rc3
* Fix issue where "Save and preview" modal would flash with no content
* Fix bug that showed "Empty due to Umbraco Forms in trial mode" for entries even with a valid license

### 17.0.0-rc2 (November 13th 2025)

* Update dependencies to 17.0.0-rc2

### 17.0.0-rc1 (October 30th 2025)

* Update dependencies to 17.0.0-rc1

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/12/umbraco-forms/release-notes.md) and [Umbraco Forms Package page](https://our.umbraco.com/packages/developer-tools/umbraco-forms/).

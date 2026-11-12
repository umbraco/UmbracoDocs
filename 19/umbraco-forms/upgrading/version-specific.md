---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Forms.
---

# Version Specific Upgrade Notes

This article provides specific upgrade documentation for migrating to Umbraco Forms version 19.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 19 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `19.0.0`. It runs on .NET 11.

### Umbraco CMS 19 and .NET 11

This change was introduced in version 19.0.0. It affects every site.

Upgrade your site to Umbraco CMS 19 and .NET 11 before you upgrade Forms. For the CMS steps, see the [Version Specific Upgrade Notes](https://docs.umbraco.com/umbraco-cms/get-started/upgrading-and-migrating/version-specific) article in the CMS documentation.

Forms now uses version 7 of `Microsoft.Data.SqlClient`, the version that CMS 19 uses. If a SQL Server data source connects with Microsoft Entra ID authentication, test that connection after you upgrade.

### Removed obsolete code

This change was introduced in version 19.0.0. It affects you if custom code calls, constructs, or inherits from the types listed in this section.

Code marked as "Scheduled for removal in Umbraco Forms 19" is removed. In version 18, the obsolete message on each member names its replacement.

The following types lose the constructors that took fewer dependencies. Use the remaining constructor, or resolve the type from dependency injection.

| Project | Types |
| --- | --- |
| `Umbraco.Forms.Core` | `EntryAcceptedDtoFactory`, `FormDtoFactory`, `FormRecordSearcher` |
| `Umbraco.Forms.Core.Providers` | `CsvDisplayValuesExport`, `CsvExport`, `CsvExportTypeBase`, `DataSource`, `NodePreValues`, `SaveAllUploadedFiles`, `SaveAllUploadedFilesBase`, `SaveAllUploadedFilesByEntry` |
| `Umbraco.Forms.Web` | `ProtectFormUploadRequestsMiddleware` |
| `Umbraco.Forms.Web` (Management API) | `CopyFormController`, `CopyFormWorkflowsController`, `CreateFormController`, `CreateFormFromDataSourceWizardController`, `ExportController`, `GetAllWorkflowTypesController`, `GetByKeyWorkflowTypeController`, `GetLinkableMemberPropertiesController`, `GetMemberFormSummariesController`, `ImportFormController`, `PostGenerateExportController`, `RetryWorkflowController`, `UpdateFormController`, `WorkflowTypeControllerBase` |
| `Umbraco.Forms.Web` (Management API, obsoleted in 18.3.0) | `CreateOrUpdateUserFormSecurityControllerBase`, `CreateOrUpdateUserGroupFormSecurityControllerBase`, `CreateUserFormSecurityController`, `CreateUserGroupFormSecurityController`, `GetByUserKeyFormSecurityController`, `GetForCurrentUserFormSecurityController`, `GetUserFormSecurityControllerBase`, `UpdateUserFormSecurityController`, `UpdateUserGroupFormSecurityController` |

The following methods are removed:

| Removed | Use instead |
| --- | --- |
| `IFormAnalyticsService.GetSourcesCountPerForm` and `GetUniqueMemberCount` without a time zone | The overloads that take a `string? timeZone` parameter |
| `CacheKeys.GetUniqueMembersCacheKey` without a time zone | The overload that takes a time zone |
| `GetFieldTypeControllerBase.ResolveRichTextPropertyEditorUiAlias()` | `ResolveRichTextPropertyEditorUiAliasAsync()` |
| `WorkflowTypeControllerBase.CreateWorkflowTypeWithSettings(WorkflowType)` | The overload that takes a `richTextPropertyEditorUiAlias` parameter |

The `RebuildRecordsIndexForSorting` and `RebuildRecordsIndexForSensitiveData` migration classes are removed. `RebuildRecordsIndex` is removed too, as described in the [Records index on Umbraco Search](#records-index-on-umbraco-search) section.

### Client-side validation without jQuery

This change was introduced in version 19.0.0. It affects you if your site validates forms with jQuery Validation. It also affects custom themes that load `umbracoforms-conditions.js`.

Forms supports one client-side validation library: [ASP.NET Client Validation](https://github.com/haacked/aspnet-client-validation). Support for jQuery Validation and jQuery Unobtrusive Validation is removed.

The `umbracoforms-conditions.js` and `umbracoforms-conditions.min.js` files are no longer shipped. The conditions logic is part of `umbracoforms.js`.

If the ASP.NET Client Validation library isn't loaded, Forms shows an error message on the form.

To upgrade:

* Remove the jQuery, jQuery Validate, and jQuery Unobtrusive Validation script references that you added for Forms.
* Render the Forms dependencies with `@Html.RenderUmbracoFormDependencies(Url)`, as described in the [Preparing your Frontend](../developer/prepping-frontend.md) article.
* Remove any reference to `umbracoforms-conditions.js` or `umbracoforms-conditions.min.js` from your custom themes.

For more information, see the [announcement](https://github.com/umbraco/Announcements/issues/33).

### Native date input for the Date field

This change was introduced in version 19.0.0. It affects you if a custom theme overrides the Date field views. It also affects you if you have conditions that compare a Date field with a date.

The Date field in the default theme renders a native HTML `<input type="date">`. Forms no longer ships the Pikaday date picker or the Moment.js library.

* The field renders one input. The hidden input with the `_1` ID suffix and the `datepickerfieldshadow` class is removed.
* The value is always in the `yyyy-MM-dd` format. The browser shows the date in the visitor's own format.
* The **Minimum date** and **Maximum date** settings render as `min` and `max` attributes, replacing `data-min-date` and `data-max-date`.
* The **Placeholder** setting has no effect in the default theme, because browsers don't show a placeholder in a date input.
* The default theme no longer uses the `DatePickerYearRange` and `DatePickerFormat` settings. They remain available for custom themes with their own date picker.
* When `DatePickerFormatForValidation` is set, the server-side validation still accepts dates in that format.

To upgrade:

* If a custom theme overrides `FieldType.DatePicker.cshtml` or `DatePicker.cshtml`, update it from the default theme's views.
* If a custom theme uses Pikaday or Moment.js from the Forms static assets, include your own copy of those libraries.
* Update conditions that compare a Date field with a date to use the `yyyy-MM-dd` format. For more information, see the [Conditions for Dates](../editor/creating-a-form/conditional-logic.md#conditions-for-dates) section.

For more information, see the [announcement](https://github.com/umbraco/Announcements/issues/34).

### Bootstrap 3 horizontal theme removed

This change was introduced in version 19.0.0. It affects you if a form uses the `bootstrap3-horizontal` theme, or if code references `BootstrapHorizontalTheme`.

Forms no longer ships the `bootstrap3-horizontal` theme. The `BootstrapHorizontalTheme` class, its views, and its stylesheet are removed. A form set to use the theme renders with the site's default theme.

To upgrade, check how those forms look with the default theme. To keep a Bootstrap layout, create a custom theme for the Bootstrap version your site uses. For more information, see the [Themes](../developer/themes.md) article.

For more information, see the [announcement](https://github.com/umbraco/Announcements/issues/35).

### Records index on Umbraco Search

This change was introduced in version 19.0.0. It affects you if custom code uses the records index types in `Umbraco.Forms.Examine`.

Umbraco CMS 19 indexes content through its search abstraction instead of directly through Examine. Forms now indexes records through that abstraction too. The index keeps its name, `UmbracoFormsRecordsIndex`.

Forms fills the index at startup when the index is empty. A migration no longer rebuilds it, so the `RebuildRecordsIndex` migration class is removed.

The following types are removed from `Umbraco.Forms.Examine`:

* `ConfigureUmbracoFormsIndexOptions`
* `IUmbracoFormsIndexingHandler`
* `IUmbracoFormsRecordIndex`
* `RecordStorageNotificationHandler`
* `RecordValueSetValidator`
* `UmbracoFormsRecordRecordIndex`

To index or remove a record from custom code, use `IFormRecordIndexingService`.

### Single-choice dropdown settings

This change was introduced in version 19.0.0. It affects you if a custom provider type has a setting with `View = "Umb.PropertyEditorUi.Dropdown"`. Provider types include field types, workflow types, and prevalue source types.

In Umbraco CMS 19, the `Umb.PropertyEditorUi.Dropdown` editor always allows more than one choice. Forms keeps only the first choice for a setting that uses it. For a single choice, set the setting's `View` to `Umb.PropertyEditorUi.Dropdown.Single`.

The setting value converter for `Umb.PropertyEditorUi.TinyMCE` is removed, because Umbraco CMS no longer has that editor. For a rich text setting, use `Forms.PropertyEditorUi.RichText`.

For more information, see the [Setting Types](../developer/extending/adding-a-type/setting-types.md) article.

### TypeScript types in the backoffice package

This change was introduced in version 19.0.0. It affects you if a backoffice extension creates Forms API models in TypeScript.

The `@umbraco-forms/backoffice` types are generated from the CMS 19 OpenAPI document. On models that have them, the `entityType` and `unique` properties are now `string` instead of `string | null`. Code that reads them is unaffected. Code that sets either property to `null` no longer compiles.

### Analytics on Umbraco Analytics UI

This change was introduced in version 19.0.0. It affects you if you extend the Forms analytics screens or call the analytics Management API endpoints.

The analytics screens draw their charts and tables with the Umbraco Analytics UI package, which other Umbraco products share. Forms depends on the `Umbraco.Analytics.UI` package. The `@umbraco-forms/backoffice` package has `@umbraco/analytics-ui` as a peer dependency, in place of `chart.js` and `chartjs-plugin-annotation`.

The following are removed from `@umbraco-forms/backoffice`:

* The `forms-chart`, `forms-prefab-chart`, `forms-analytics-table`, and `forms-prefab-table` elements, and their generators.
* `FormsChartBaseElement`, `FormsPrefabGeneratorControllerBase`, and the `FormsPrefab*` and `FormsChart*` types.
* The `forms-daterange-picker` element and its modal, `forms-analytics-groupby-controls`, and `forms-button-group`.
* `FormsDateRangeManagerContext`, `FORMS_DATERANGE_MANAGER_CONTEXT`, and `DATEPICKER_MODES`.

`FormsAnalyticsContext` keeps its context token. It now holds `range`, `compare`, and `groupBy` in the `@umbraco/analytics-ui` shapes, and queries with `query` and `queryWithCompare`.

A `formsAnalyticsWidget` manifest no longer has `meta.chartAlias` or `meta.aspect`, because the prefab charts they named are removed. A widget draws its own content, for example with the `uaui-*` elements.

The analytics Management API changes as follows:

* `retentionDays` is replaced by `retentionDaysSubmitted`, `retentionDaysApproved`, and `retentionDaysRejected`. These are numbers, where `0` means forever.
* `/analytics/submissions` takes one or more of `entries`, `workflowErrors`, `triggered`, and `uniqueMembers`, instead of exactly two metrics.
* `week` and `month` join `date` as time dimensions on `/analytics/submissions` and `/analytics/origins`. `/analytics/origins` rejects a dimension that isn't a time dimension.
* `/analytics/workflows` adds a row for runs of workflows no longer on the form, with an empty `workflowId` and `workflowName`.
* `ChartDataBuilder.BuildMultiMetricTimeSeriesChart` takes lists of metrics and series.

`AnalyticsQueryResult.UniqueMembers` is obsolete. Ask `/analytics/submissions` for `uniqueMembers` and read it from `totals` instead.

### Forms Delivery API OpenAPI document

This change was introduced in version 18.3.0. It affects you if you generate a client from the Forms Delivery API OpenAPI document.

The Forms Delivery API OpenAPI document (`/umbraco/openapi/forms-delivery.json`) has changed. A client generated from the new document no longer has an `ApiContentRouteModel` type. `IApiContentRouteModel` keeps its name and now has the route's properties, and `IApiContentStartItemModel` is a plain object. The API responses themselves are unchanged. Regenerate your client and update any code that used `ApiContentRouteModel`.

### Data Consent field in custom themes

This change was introduced in version 18.3.0. It affects you if a custom theme overrides `FieldType.DataConsent.cshtml`.

The Data Consent field has a new optional **Consent details** setting for formatted text shown under the checkbox. The **Accept Copy** setting is now labelled **Consent text**. Its `acceptCopy` alias is unchanged, so stored forms and code keep working.

A custom theme that overrides `FieldType.DataConsent.cshtml` doesn't show the consent details. Update the view to match the default theme. The default theme renders the details in an element with the ID `{field ID}_consentdetails`. It also adds that ID to the `aria-describedby` attribute of the checkbox. The updated view is in the 18.3.0 default theme files, linked from the [Themes](../developer/themes.md) article.

### Placeholder values in HTML settings

This change was introduced in version 18.3.0. It affects you if you use placeholders in settings that hold HTML.

Placeholder values are encoded more strictly in settings that HTML-encode them. These include **Consent details**, the Rich Text field's text, and the Razor email header, body, and footer. A value starting with a script URL scheme is prefixed with `unsafe:`. The placeholder delimiters `[`, `]`, `{`, and `}` in a value are encoded too.

### Content Security Policy nonce on Forms scripts

This change was introduced in version 18.3.0. It affects every site.

Forms script tags now carry a `nonce` attribute. Browsers ignore it on a page without a Content Security Policy. A nonce you already pass to the Forms script helpers is kept. To render no nonce, register an `ICspNonceService` that returns `null`.

External script and stylesheet URLs are now rendered as registered. Forms no longer adds its version to them.

For more information, see the [Content Security Policy nonce](../developer/rendering-scripts.md#content-security-policy-nonce) section of the Rendering Forms Scripts article.

### Date formats in workflows and exports

This change was introduced in version 18.2.0. It affects you if you upgrade from an earlier version 18 release. It also affects you if you upgrade to version 18 from version 17.5.0 or earlier.

A date value used to be written using whichever culture happened to be active. That was often not the culture the entry was submitted with. A month-first date such as `07/05/2027` could then be read back as the wrong day: 7 May instead of 5 July. Date values are now formatted for whoever reads them.

Every example in the table is the same submitted value: 5 July 2027 at 14:03, from an entry submitted in `en-GB` on a server running `en-US`.

| Destination | Before | From 18.2.0 |
| --- | --- | --- |
| Entries list and entry details | The stored, month-first string for a custom date field: `07/05/2027 14:03` | The culture the entry was submitted with: `05/07/2027 14:03` |
| CSV and Excel export | Month-first, whatever the entry's culture: `07/05/2027 14:03` | The culture the entry was submitted with: `05/07/2027 14:03` |
| Send Email, Send Email with Template, Slack | The server's culture when the workflow ran: `7/5/2027 2:03 PM` | The culture the entry was submitted with: `05/07/2027 14:03` |
| Post as XML, Send Form to URL | The server's culture when the workflow ran: `7/5/2027 2:03 PM` | ISO 8601: `2027-07-05T14:03:00` |
| Save as an XML file, Send XSLT Transformed Email | The server's culture when the workflow ran: `7/5/2027 2:03 PM` | ISO 8601: `2027-07-05T14:03:00` |
| Save as Umbraco Content Node | A formatted string, parsed back to a date: stored as 7 May 2027 | The date value itself, with no round trip: stored as 5 July 2027 |

{% hint style="warning" %}
Check any system that reads a date from one of these workflows. A receiving endpoint or an XSLT file that expects the old format needs updating. The `created` and `updated` elements in the record XML now also carry a `Z` suffix, marking them as UTC.
{% endhint %}

Two further points to be aware of:

* An export of a form with entries in more than one culture holds more than one date format in the same column.
* The Save as Umbraco Content Node workflow now stores a day-first date correctly. A date of `05/07/2027` from an `en-GB` entry is saved as 5 July, not 7 May.

See [issue #1773](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1773) for details.

### Upgrading to 18.2.0 from Forms 13, from 17.5.x or earlier, or from 18.0.x

This fix was introduced in version 18.2.1. It affects you if you upgrade to 18.2.0, or one of its release candidates, from Forms 17.5.x or earlier, or from any 18.0.x release. This includes upgrading directly from Forms 13.

{% hint style="warning" %}
A database migration in 18.2.0 reads a column before a later migration adds it. The upgrade fails at boot with `no such column: UFForms.Trashed` on SQLite, or `Invalid column name 'Trashed'` on SQL Server.
{% endhint %}

Upgrading from Forms 17.6.0 or from an 18.1.x release is not affected.

Upgrade to version 18.2.1 or later instead. If an upgrade to 18.2.0 or one of its release candidates has already failed, install 18.2.1 or later and start the site again. The upgrade continues from the step that failed.

### Upgrading directly from Forms 17.6.0

This affects you if you upgrade directly from Forms 17.6.0 to a version 18 release earlier than 18.2.0.

{% hint style="warning" %}
Version 18 releases before 18.2.0 do not recognize the migration state that Forms 17.6.0 ends on. The upgrade fails at boot with `The migration plan "UmbracoForms" does not support migrating from state "91f8163e-99b6-4e78-b4cb-573f8493fd3c"`.
{% endhint %}

Upgrade to version 18.2.0 or later instead.

### Upgrading directly from Forms 17.5.0

This fix was introduced in version 18.1.1. It affects you if you upgrade directly from Forms 17.5.0 to an earlier version 18 release.

{% hint style="warning" %}
Versions 18.0.0 to 18.1.0 do not recognize the migration state that Forms 17.5.0 ends on. The upgrade fails at boot with `The migration plan "UmbracoForms" does not support migrating from state "0625d467-f048-4b5b-aa38-3d42fbfa8cd3"`.
{% endhint %}

Upgrade to version 18.1.1 or later instead. See [issue #1782](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1782) for details.

### Upgrading directly from Forms 13.9.9

This fix was introduced in version 18.1.0. It affects you if you upgrade directly from Forms 13.9.9 to an earlier version 18 release.

{% hint style="warning" %}
Versions 18.0.0 to 18.0.6 do not recognize the migration state that the 13.9.9 security patch added. The upgrade fails at boot with `The migration plan "UmbracoForms" does not support migrating from state "6149738f-25bd-44ac-9c1d-d66bbe9d4e2b"`.
{% endhint %}

Upgrade to version 18.1.0 or later instead. See [issue #1772](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1772) for details.

### UTC date handling

This fix was introduced in version 17.3.0. It affects you if you upgrade to version 18 from version 17.0, 17.1, or 17.2.

Version 17.0.0 included a migration (`MigrateSystemDatesToUtc`) that converted existing system dates to UTC. The application code still wrote new records using `DateTime.Now`, which is local server time. This left inconsistent timestamps on form entries, workflow audit trails, and entity metadata. Version 17.3.0 corrected the code that writes those dates.

{% hint style="warning" %}
Data written between v17.0.0 and the fix may contain local server timestamps instead of UTC. Upgrading to version 18 does not correct that data. A SQL script is provided below to correct it. The script runs on SQL Server only.

Take a database backup before you run it. Then set the three variables at the top of the script:

* `@TimeZone`: your server's Windows time zone name.
* `@UpgradeDate`: the date you first upgraded to v17.0.0. Rows created before this date were already converted to UTC.
* `@FixDate`: the date you first deployed a version that includes the fix. That is v17.3.0 or newer, or any version 18 release. Rows created on or after this date are already UTC and must not be shifted again.

The script writes a marker to `umbracoKeyValue` when it completes. On a second run it reports the marker and exits without changing any rows.

The script also clears the affected days from the analytics summary tables. The background task rebuilds those days from the corrected entries on the next application start. Confirm the rebuild under **Settings** > **Health Check** > **Forms** > **Analytics Processing**.

The script excludes the `UFRecordDataDateTime` table, as those values represent user-entered dates that should not be shifted.

The original `MigrateSystemDatesToUtc` migration contained a duplicate conversion for `UFPrevalueSource`. The Created and Updated columns were converted twice. This has been fixed, but sites that ran v17.0 to v17.2 may have double-converted PrevalueSource dates that require manual correction.
{% endhint %}

{% file src="../.gitbook/assets/correct-utc-timestamps.sql" %}
Corrects historical data written with local server time instead of UTC. Set the time zone and both cutoff dates before running.
{% endfile %}

### Storage method for tracking rendered forms

This change was introduced in version 14. It affects you if you upgrade directly from version 13 to version 18.

In version 13, Forms tracked the forms rendered on a page using `TempData`. From version 14 onwards, the default value of the `TrackRenderedFormsStorageMethod` configuration option is `HttpContextItems`.

If your template renders form scripts using a custom snippet that reads the rendered form IDs from `TempData`, the snippet no longer finds them. As a result, the form scripts and any assets registered by custom field types stop rendering.

{% hint style="warning" %}
The scripts fail silently. Forms still submit, but conditional logic, field behaviors, and custom field type assets are missing from the page.
{% endhint %}

To resolve this, choose one of the following options:

* Update your snippet to read the rendered form IDs from `HttpContext.Items`.
* Use the `<umb-forms-render-scripts />` tag helper, which respects the configured storage method.
* Set `TrackRenderedFormsStorageMethod` back to `TempData` to keep the version 13 behavior.

For the updated snippets and the tag helper, see the [Rendering Forms Scripts](../developer/rendering-scripts.md) article. For the configuration option, see the [Configuration](../developer/configuration/README.md#trackrenderedformsstoragemethod) article.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/installation/version-specific.md).

---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Forms.
---

# Version Specific Upgrade Notes

This article provides specific upgrade documentation for migrating to Umbraco Forms version 17.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 17 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `17.0.0`. It runs on .NET 10.

### Date formats in workflows and exports

This change was introduced in version 17.6.0. It affects you if you upgrade from an earlier version 17 release.

A date value used to be written using whichever culture happened to be active. That was often not the culture the entry was submitted with. A month-first date such as `07/05/2027` could then be read back as the wrong day: 7 May instead of 5 July. Date values are now formatted for whoever reads them.

Every example in the table is the same submitted value: 5 July 2027 at 14:03, from an entry submitted in `en-GB` on a server running `en-US`.

| Destination | Before | From 17.6.0 |
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

### Upgrading directly from Forms 13.9.9

This fix was introduced in version 17.5.0. It affects you if you upgrade directly from Forms 13.9.9 to an earlier version 17 release.

{% hint style="warning" %}
Versions 17.0.0 to 17.4.8 do not recognize the migration state that the 13.9.9 security patch added. The upgrade fails at boot with `The migration plan "UmbracoForms" does not support migrating from state "6149738f-25bd-44ac-9c1d-d66bbe9d4e2b"`.
{% endhint %}

Upgrade to version 17.5.0 or later instead. See [issue #1772](https://github.com/umbraco/Umbraco.Forms.Issues/issues/1772) for details.

### Storage method for tracking rendered forms

This change was introduced in version 14. It affects you if you upgrade directly from version 13 to version 17.

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

### Forms API URL paths

This change was introduced in version 14. It affects you if you upgrade directly from version 13 to version 17.

The Forms API endpoints moved under a `delivery` path segment. Both the endpoint for requesting a form definition and the endpoint for submitting a form entry changed:

| Endpoint | Version 13 | Version 14 onwards |
| --- | --- | --- |
| Request a form definition | `GET /umbraco/forms/api/v1/definitions/{id}` | `GET /umbraco/forms/delivery/api/v1/definitions/{id}` |
| Submit a form entry | `POST /umbraco/forms/api/v1/entries/{id}` | `POST /umbraco/forms/delivery/api/v1/entries/{id}` |

{% hint style="warning" %}
Requests to the version 13 paths return a 404 status code. Client-side scripts that submit forms fail without a validation error, as the request never reaches the Forms API.
{% endhint %}

Update any code that calls these endpoints, including client-side scripts, server-to-server integrations, and generated API clients.

For the current endpoint definitions, see the [Headless/AJAX Forms](../developer/ajaxforms.md) article.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-forms/installation/version-specific.md).

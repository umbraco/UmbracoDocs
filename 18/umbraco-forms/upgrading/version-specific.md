---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Forms.
---

# Version Specific Upgrade Notes

This article provides specific upgrade documentation for migrating to Umbraco Forms version 18.

{% hint style="info" %}
If you are upgrading to a minor or patch version, you can find the details about the changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 18 of Umbraco Forms has a minimum dependency on Umbraco CMS core of `18.0.0`. It runs on .NET 10.

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

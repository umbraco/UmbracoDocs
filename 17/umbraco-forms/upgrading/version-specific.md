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

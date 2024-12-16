---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco UI
  Builder.
---

# Release Notes

In this section, we have summarized the changes to Umbraco UI Builder released in each version. Each version is presented with a link to the [UI Builder issue tracker](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}
If you are upgrading to a new major version, check the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.
{% endhint %}

## Release History

This section contains the release notes for Umbraco UI Builder 14 including all changes for this version.

#### [**14.0.1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.1) **(December 16th 2024)**

* Added previously validated license resolver, to validate a license if a validation process was already executed successfully in the past 7 days.
* Fixed an issue caused by `where` clauses for filter expression and deleted property.
* Allow entity properties to be searched based on pattern: `StartsWith` | `Contains` [#116](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/116)
* Switch entity create/edit header to label view for read-only collections [#111](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues/111)

#### [**14.0.0**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.0) **(November 11th 2024)**

* Release major version of `Umbraco.UIBuilder 14`

#### [**14.0.0-alpha1**](https://github.com/umbraco/Umbraco.UIBuilder.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F14.0.0) **(September 2nd 2024)**

* Product migrated to support the new Web Component-based Umbraco

You can read more about the new Backoffice [in the Umbraco CMS documentation](https://docs.umbraco.com/umbraco-cms/extending/customize-the-editing-experience).

## Legacy release notes

You can find the release notes for **Konstrukt** in the [Change log file on GitHub](changelog-archive/changelog.md).

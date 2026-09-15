---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco Workflow.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to major 13 of Umbraco Workflow.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 13 of Umbraco Workflow has a minimum dependency on Umbraco CMS core of `13.0.0`. It runs on .NET 8.

#### **Breaking changes**

Version 13 is primarily a dependency update, but does remove some properties previously marked obsolete. These are not typical extension or integration points, and are listed below for reference.

#### **Code**

* Removed the `Type` property from `ConfigModel`
* Removed the `Type` property from `UserGroupPermissionsPoco`
* Removed the `ScheduledDate` property from `HtmlEmailModel`. `ReleaseDate` or `ExpireDate` properties should be used instead.
* Removed the `ScheduledDate` property from `InstanceDetailViewModel`. `ReleaseDate` or `ExpireDate` properties should be used instead.
* Removed the `ScheduledDate` property from `WorkflowInstanceViewModel`. `ReleaseDate` or `ExpireDate` properties should be used instead.
* Removed the `ScheduledDate` property from `WorkflowTaskViewModel`. `ReleaseDate` or `ExpireDate` properties should be used instead.
* Removed the `SetDueDate()` method from `ContentReviewConfigPoco`. The implementation accepting the `ContentSettingsReviewModel` parameter should be used instead.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).&#x20;

---
description: >-
  Version specific documentation for upgrading to new major versions of Umbraco
  Workflow.
---

# Version Specific Upgrade Notes

This page covers specific upgrade documentation for when migrating to Umbraco Workflow version 14.

{% hint style="info" %}
If you are upgrading to a new minor or patch version, you can find information about the breaking changes in the [Release Notes](../release-notes.md) article.
{% endhint %}

## Version Specific Upgrade Notes History

Version 14 of Umbraco Workflow has a minimum dependency on Umbraco CMS core of `14.1.0`. It runs on .NET 8.

#### **Breaking changes**

Version 14 contains a number of breaking changes, primarily due to the new backoffice introduced in Umbraco 14. The details are listed here:

#### **Behaviour**

* A new management API has been introduced at `umbraco/workflow/management/api`

#### Dependencies

* Umbraco CMS dependency was updated to `14.1.0`

#### **Code**

Workflow 14 includes a non-trivial number of breaking code changes, primarily related to namespace changes. The majority of these related to removing the `Implement` namespace for services, and moving appropriate models to `Umbraco.Workflow.Core.ViewModels` or `Umbraco.Workflow.Core.Interfaces`.

* The serialization library has been changed from `Newtonsoft.Json` to `System.Text.Json`.
* Approval group identifiers changes from int to Guid.
* Workflow instance author identifier changes from int to Guid.
* Workflow task indentifiers for approving user, assigned user and actioning user change from int to Guid.
* Services return `Attempt<TResult>` or `Attempt<TResult, TStatus>`, in line with similar changes in the CMS.

## Legacy version specific upgrade notes

You can find the version specific upgrade notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/tree/umbraco-eol-versions).

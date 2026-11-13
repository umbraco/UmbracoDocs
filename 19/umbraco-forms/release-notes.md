---
description: >-
  Get an overview of the things changed and fixed in each version of Umbraco
  Forms.
---

# Release Notes

In this section, we have summarized the changes to Umbraco Forms released in each version. Each version is presented with a link to the [Forms issue tracker](https://github.com/umbraco/Umbraco.Forms.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the detail.

If there are any breaking changes or other issues to be aware of when upgrading they are also noted here.

{% hint style="info" %}

If you are upgrading to a new major version, you can find information about the breaking changes in the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.

{% endhint %}

## Release history

This section contains the release notes for Umbraco Forms 19 including all changes for this version.

### [19.0.0-rc1](https://github.com/umbraco/Umbraco.Forms.Issues/issues?q=is%3Aissue+label%3Arelease%2F19.0.0) (November 12th 2026)

{% hint style="warning" %}
This is a prerelease for testing. Don't use it on a production site.

Forms 19.0.0-rc1 needs Umbraco CMS `19.0.0-rc1`. It's published to NuGet and npm as a prerelease.

Sites that use Umbraco Deploy need Umbraco Forms Deploy `19.0.0-rc1`, released on November 13th 2026. For details, see the Umbraco.Forms.Deploy section of this article.
{% endhint %}

#### Umbraco CMS 19 support

Forms 19 runs on Umbraco CMS 19 and .NET 11.

#### Breaking changes

Forms 19 removes code and front-end features that were announced for removal:

* Client-side validation with jQuery Validation, in favor of ASP.NET Client Validation ([announcement](https://github.com/umbraco/Announcements/issues/33))
* The Pikaday date picker, replaced by the browser's native date input ([announcement](https://github.com/umbraco/Announcements/issues/34))
* The `bootstrap3-horizontal` theme ([announcement](https://github.com/umbraco/Announcements/issues/35))
* Code marked as "Scheduled for removal in Umbraco Forms 19"

Forms also follows changes in Umbraco CMS 19:

* The records index uses the CMS search abstraction instead of Examine directly
* Settings that offer a single choice from a dropdown use `Umb.PropertyEditorUi.Dropdown.Single`
* The `@umbraco-forms/backoffice` types are generated from the CMS 19 OpenAPI document

The analytics screens now draw their charts and tables with the shared Umbraco Analytics UI package. The chart, table and date range elements in `@umbraco-forms/backoffice` are removed, and some analytics Management API parameters change.

For the details and upgrade steps, see the [Version Specific Upgrade Notes](upgrading/version-specific.md) article.

#### Other

* Delivery API: Return a validation error (422), instead of a 500 status code, for a file upload with invalid Base64 content
* Recycle Bin: Keep folders that hold a user's or user group's start folder when emptying the recycle bin, instead of failing. A message says how many were kept. For details, see the [Recycle Bin](editor/managing-forms/recycle-bin.md#folders-kept-because-they-hold-a-start-folder) article
* Recycle Bin: Hide the recycle bin from users with start folders
* Security: Show missing and trashed start folders in the start folder picker
* Security: Refuse a missing start folder when saving a user's or user group's Forms security, instead of saving part of the change

## Umbraco.Forms.Deploy

### 19.0.0-rc1 (November 13th 2026)

{% hint style="warning" %}
Forms Deploy 19.0.0-rc1 needs Umbraco CMS, Umbraco Forms and Umbraco Deploy `19.0.0-rc1`.
{% endhint %}

#### Umbraco 19 support

Forms Deploy 19 runs on Umbraco CMS, Umbraco Forms and Umbraco Deploy 19, and .NET 11.

#### Permissions for deployed forms

A form that a deployment creates on the target environment now gets the Forms permissions configured there. The new `AllowFormSecurityDeploymentOperations` setting controls which permissions are applied:

* `FormsUserConfiguration` (default): the configured user group permissions, and the deploying user's own permissions. Deploy finds the deploying user on the target by email address, which needs the `ResolveUserInTargetEnvironment` setting.
* `FormsConfiguration`: the configured user group permissions only.
* `None`: no permissions.

User group permissions only apply when Forms manages security with user groups (`ManageSecurityWithUserGroups`). The permissions of forms that already exist on the target don't change. Permissions aren't transferred from the source environment.

For more information, see the [AllowFormSecurityDeploymentOperations](https://docs.umbraco.com/umbraco-deploy/getting-started/deploy-settings#allow-form-security-deployment-operations) section of the Deploy Settings article.

#### Other

* Forms: Update a form that's in the target's recycle bin, instead of inserting it again as a new form. The form gets the changes and stays in the recycle bin
* Forms: Deploy the member mapping settings of form fields. Until now, deploying a form left these settings out. Forms that use member mapping show as changed once after upgrading

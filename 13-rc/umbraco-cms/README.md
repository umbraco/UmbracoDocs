---
description: >-
  This is the documentation for the Umbraco 13 Release Candidate. The next major
  version of Umbraco.
---

# Umbraco 13 (RC) CMS Documentation

## Getting started with the Umbraco 13 RC

Below you will find the steps on how you can create a new Umbraco 13 RC project using the Command Line.

### prerequisite

* [.NET 8.0.0](https://dotnet.microsoft.com/en-us/download/dotnet/8.0) installed

#### Install using Command Line

1. Run `dotnet new -i Umbraco.Templates::13.0.0-rc4` in the command line to install the Umbraco 13 RC templates.
2. Run `dotnet new umbraco -n "MyProject"` to create a new project using Umbraco 13 RC.
3. Run `dotnet run --project "MyProject"` to start the newly created project.

## New and Updated articles

Below you will find a list of new and updated articles for the Umbraco 13 Release Candidate.

The list will be updated as more articles have been created and updated.

* FUNDAMENTALS:
  * BACKOFFICE:
    * [Blocks in Rich Text Editor](fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/rich-text-editor/rte-blocks.md)
    * [Login](fundamentals/backoffice/login.md)
  * DATA:
    * [Defining Content](fundamentals/data/defining-content/)
* [External Login Providers](reference/security/external-login-providers.md)
* [Two-factor Authentication](reference/security/two-factor-authentication.md)
* [Multinode Treepicker](fundamentals/backoffice/property-editors/built-in-umbraco-property-editors/multinode-treepicker.md)
* REFERENCE:
  * [Content Delivery API](reference/content-delivery-api/)
    * [Custom property editors support](reference/content-delivery-api/custom-property-editors-support.md)
    * [Extension API querying](reference/content-delivery-api/extension-api-for-querying.md)
    * [Media Delivery API](reference/content-delivery-api/media-delivery-api.md)
    * [Protected content in the Delivery API](reference/content-delivery-api/protected-content-in-the-delivery-api.md)
    * [Property expansion and limiting](reference/content-delivery-api/property-expansion-and-limiting.md)
    * [Output caching](reference/content-delivery-api/output-caching.md)
* TUTORIALS:
  * [Add Google Authentication (Users)](tutorials/add-google-authentication.md)

### Breaking Changes

Some breaking changes have been introduced in the Umbraco 13 Release Candidate, you can find the list of breaking changes in the [Version Specific Upgrades](fundamentals/setup/upgrading/version-specific/) article.

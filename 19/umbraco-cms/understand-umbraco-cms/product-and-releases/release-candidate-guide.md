---
description: >-
  Learn how to start testing a pre-release for the latest version of Umbraco
  CMS, and find information about new and updated documentation.
---

# Pre-Release Guide

The pre-release can be used to test your website and projects against the next major version of Umbraco CMS.

The first phase is a beta version, which is then followed by a Release Candidate.

This article contains all the resources needed for you to start testing.

* [How to Test the Pre-Release version](release-candidate-guide.md#test-the-pre-release-version)
* [New and Updated Documentation](release-candidate-guide.md#new-and-updated-documentation)

{% hint style="info" %}
This document will be updated and expanded as more and more documentation is added throughout the beta and release candidate phases.
{% endhint %}

## Test the Pre-Release version

Ensure you meet the prerequisites and move on to the installation steps outlined below.

### Prerequisites

* The latest [.NET SDK 11.0](https://dotnet.microsoft.com/en-us/download/dotnet/11.0).

### Install a Pre-Release Version

The [release candidate is available on NuGet](https://www.nuget.org/packages/Umbraco.Templates/19.0.0-rc1).

1. Install the Umbraco dotnet template for the release candidate.

```cmd
dotnet new install Umbraco.Templates@19.0.0-rc1
```

2. Create a new Umbraco project.

```cmd
dotnet new umbraco -n MyCustomUmbracoProject
```

3. Navigate to the newly created folder.

```cmd
cd MyCustomUmbracoProject
```

4. Build and run the project.

```cmd
dotnet build
dotnet run
```

This will boot the project and write the log to the console. The website is now running on your local machine and will be available on the ports written in the console.

{% hint style="info" %}
Alternatively, you can install and run the Umbraco project using your favorite IDE (Integrated Development Environment).
{% endhint %}

## New and updated documentation

Here is a list of all the new, updated, and removed articles in this version.

### New articles

* [Search](../../develop-with-umbraco/search/README.md): Introduces Umbraco Search, which replaces the built-in Examine integration.
* [Getting Started](../../develop-with-umbraco/search/getting-started.md): Query, filter, sort, and paginate search results with the `ISearcher` interface.
* [The Examine Search Provider](../../develop-with-umbraco/search/examine-search-provider.md): Configure Examine, the default search provider.
* [The Backoffice](../../develop-with-umbraco/search/backoffice.md): Work with search indexes in the **Search** section of the backoffice.
* [Extending Search](../../develop-with-umbraco/search/extending-search/README.md): Overview of the extension points for search.
* [Extending the Examine search provider](../../develop-with-umbraco/search/extending-search/examine-search-provider.md): Extension points specific to the Examine search provider.
* [Reindexing Content](../../develop-with-umbraco/search/extending-search/reindexing-content-programmatically.md): Trigger reindexing from code, and when to do it.
* [Using Other Sources](../../develop-with-umbraco/search/extending-search/data-from-other-sources.md): Index and search data that does not come from Umbraco.
* [Search Backoffice](../../develop-with-umbraco/search/extending-search/backoffice-extensions.md): Add detail boxes, entity actions, workspace views, and modals to the **Search** section.
* [Index Values: Property Editors](../../develop-with-umbraco/search/extending-search/index-values-for-property-editors.md): Provide or replace index values for property editors.
* [Gathering Data with Content Indexers](../../develop-with-umbraco/search/extending-search/gathering-data-with-content-indexers.md): Control what data is indexed with `IContentIndexer` implementations.
* [Indexing Notification Handling](../../develop-with-umbraco/search/extending-search/indexing-notification-handling.md): React to indexing through notifications.
* [Database Cache for Index Values](../../develop-with-umbraco/search/extending-search/database-cache-for-index-values.md): How index values are cached in the database, and what that means for your code.
* [Indexed Values of Built-in Property Editors](../../develop-with-umbraco/search/built-in-property-editors.md): The index value types for each built-in property editor.
* [System Fields in Content Indexes](../../develop-with-umbraco/search/system-fields.md): The system fields included in all content indexes.
* [Searching file content](../../develop-with-umbraco/search/searching-file-content/README.md): Include the content of uploaded files in search.
* [Adding file formats](../../develop-with-umbraco/search/searching-file-content/adding-file-formats.md): Extend the file-to-text indexing package with more file formats.
* [Reusable Content in Block Editors](../../model-your-content/property-editors/built-in-umbraco-property-editors/block-editor/reusable-content-in-block-editors.md): Reuse Library Elements as blocks in the Block List, Block Grid, Single Block, and Rich Text editors.

### Removed articles

The following Examine articles have been removed, because Umbraco Search replaces the built-in Examine integration. Use the [Search](../../develop-with-umbraco/search/README.md) documentation instead. For details, see the "Examine integration replaced by Umbraco Search" entry in the [Breaking Changes Overview](../../get-started/upgrading-and-migrating/version-specific.md#breaking-changes).

* Examine Management
* Examine Manager
* Custom Indexing
* PDF Indexes and Multisearchers
* Quick-Start
* Corrupt Indexes

### Removed settings

The following settings have been removed in Umbraco 19. For replacements, see the "Configuration changes" entry in the [Breaking Changes Overview](../../get-started/upgrading-and-migrating/version-specific.md#breaking-changes).

* `Umbraco:CMS:Indexing:ExplicitlyIndexEachNestedProperty`
* `Umbraco:CMS:Content:AllowEditInvariantFromNonDefault`
* `Umbraco:CMS:HelpPage`
* `AllowCreation` in the segment settings (`SegmentSettings`)
* `BackOfficeTokenCookieSettings`

### Updated articles

* [Breaking Changes Overview](../../get-started/upgrading-and-migrating/version-specific.md): Lists the breaking changes in Umbraco 19 and how to prepare for the upgrade.
* [Requirements](../../get-started/installation/requirements.md): Updated for .NET 11 and Node.js 24.13.
* [Searching with Examine](../../develop-with-umbraco/application-code/examine.md): Marked as obsolete, with a pointer to the new Search documentation.
* [Image Processing](../../develop-with-umbraco/application-code/backend-and-custom-logic/image-processing.md): Covers ImageSharp 4 as the default and how to switch to ImageSharp 2.
* [Security Settings](../../develop-with-umbraco/configuration/securitysettings.md): Documents the backoffice authentication cookie settings and the two-factor bypass settings for external logins.
* [Indexing Settings](../../develop-with-umbraco/configuration/indexingsettings.md): Adds the `IndexExternalBlockElements` setting.
* [Examine Settings](../../develop-with-umbraco/configuration/examinesettings.md): Settings moved to `Umbraco:CMS:Search:Examine`, with the new `ZeroDowntimeIndexing` setting.
* [Models Builder Settings](../../develop-with-umbraco/configuration/modelsbuildersettings.md): `ModelsMode` now defaults to `Nothing`.
* [Scheduled Publishing Settings](../../develop-with-umbraco/configuration/scheduledpublishingsettings.md): `AlignToClock` now defaults to `true`.
* [Fetch API](../../extend-your-project/backoffice-extensions/foundation/fetching-data/fetch-api.md): Authenticate requests with the backoffice cookie instead of an access token.
* [Access Policies](../../extend-your-project/tutorials/creating-a-backoffice-api/access-policies.md): Custom policies now include the backoffice authentication scheme.
* [User Entry Point](../../extend-your-project/backoffice-extensions/extending-overview/extension-types/user-entry-point.md): Describes what happens when a different user signs in after a timeout.
* [Entity Actions](../../extend-your-project/backoffice-extensions/extending-overview/extension-types/entity-actions.md): Adds grouping of entity actions with `entityActionGroup`.
* [Elements](../../model-your-content/content-types-and-structure/data/defining-content/elements.md): Covers referencing Elements as blocks in block editors.
* [Document Blueprints](../../model-your-content/content-types-and-structure/backoffice/document-blueprints.md): Document Blueprints are now managed in the Library section, with per-user access.
* [IPublishedContentQuery](../../develop-with-umbraco/templating-and-rendering/querying/ipublishedcontentquery.md): Updated for the removal of the Examine-based `Search` overloads.
* [Settings Dashboards](../../model-your-content/content-types-and-structure/backoffice/settings-dashboards.md): Removes the Examine Management dashboard, which is replaced by the Search entry under Settings.
* [Inversion of Control / Dependency injection](../../develop-with-umbraco/application-code/backend-and-custom-logic/using-ioc.md): Replaces the `ExamineManager` example with an `ISearcher` example.
* [Content Delivery API](../../develop-with-umbraco/headless-and-apis/content-delivery-api/README.md): Removes the steps for rebuilding the `DeliveryApiContentIndex` after enabling the API.
* [Extension API for querying](../../develop-with-umbraco/headless-and-apis/content-delivery-api/extension-api-for-querying.md): Custom query options now index data through `IContentIndexHandler`.
* [Protected content in the Delivery API](../../develop-with-umbraco/headless-and-apis/content-delivery-api/protected-content-in-the-delivery-api/README.md): Removes the note about rebuilding the index after changing member authentication.
* [Users](../../manage-and-publish-content/users-and-members/users/README.md): Adds the **Allow editing shared content** permission, and start nodes and access for Elements and Document Blueprints.
* [Content Settings](../../develop-with-umbraco/configuration/contentsettings.md): Removes the `AllowEditInvariantFromNonDefault` setting, which a user group permission replaces.
* [Imaging settings](../../develop-with-umbraco/configuration/imagingsettings.md): `Memory:Enabled` now defaults to `true`.
* [Custom Generated Client](../../extend-your-project/backoffice-extensions/foundation/fetching-data/custom-generated-client.md): Authenticate generated clients with the backoffice cookie, and how login redirects are handled.
* [Umbraco HTTP Client](../../extend-your-project/backoffice-extensions/foundation/fetching-data/http-client.md): Describes how the client handles login redirects.
* [Workspace Action Menu Items](../../extend-your-project/backoffice-extensions/extending-overview/extension-types/workspaces/workspace-action-menu-items.md): Adds action groups and `separatorBefore`.
* [Property Actions](../../extend-your-project/backoffice-extensions/property-editors/property-actions.md): Adds action groups.
* [Block List](../../model-your-content/property-editors/built-in-umbraco-property-editors/block-editor/block-list-editor.md) and [Block Grid](../../model-your-content/property-editors/built-in-umbraco-property-editors/block-editor/block-grid-editor.md): Cover reusing Library Elements as blocks.

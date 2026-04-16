---
description: Get an overview of the changes and fixes in each version of Umbraco Workflow.
---

# Release notes

In this section, we have summarized the changes to Umbraco Workflow that were released in each version. Each version is presented with a link to the [Workflow issue tracker](https://github.com/umbraco/Umbraco.Workflow.Issues/issues) showing a list of issues resolved in the release. We also link to the individual issues themselves from the details.

If there are any breaking changes or other issues to be aware of when upgrading, they are also noted here.

{% hint style="info" %}
Check the [Version Specific Upgrade Notes](upgrading/version-specific.md) article for breaking changes when upgrading to a new major version.
{% endhint %}

## Release History

This section contains the release notes for Umbraco Workflow 17, including all changes for this version.

### [17.2.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.0) (April 16 2026)

* All changes from 17.2.0 release candidates
* Replaced RazorLight with IRazorViewEngine and precompiled Razor views shipped in the StaticAssets library. Email templates are now standard partial views, making customization simpler and removing the third-party RazorLight dependency. [#129](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/129)
* Fixed email reminder period not being read from settings.
* Added option to create an empty alternate version instead of always cloning the current content.

### [17.2.0-rc](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.2.0-rc) (March 20 2026)

#### Content review configuration from the document workspace 

Content review settings can now be managed directly from the document workspace, without navigating to the dedicated Content Reviews settings area. When editing a content node, a new config panel shows the assigned review group, review period, and whether the configuration is explicit or inherited.

Editors can add, edit, or remove review configuration in-place, with changes taking effect immediately. Removing an explicit configuration causes the node to fall back to inherited settings from ancestor nodes or Document Type config.

#### Performance: cached approval groups and permissions

Approval group and permission data is now cached in memory using a decorator pattern over the existing repositories. These hot-paths in Workflow are read on every workflow initiation, task progression, dashboard load, and content tree decoration. 

The cache uses a ConcurrentDictionary for thread safety and prefix-based selective invalidation. A mutation (for example, adding a user to a group) only evicts the affected cache entries while keeping unrelated entries warm. Sites with many workflow-enabled nodes should see a noticeable reduction in database load.

#### Modular frontend architecture

The frontend has been refactored to eliminate cross-cutting imports between the core module and feature modules (documents, release sets, alternate versions). Previously, core had direct dependencies on feature modules to register workspace views, contexts, and config elements. 

Each feature module now registers its own manifests against extension point contracts defined in core, and config/history tabs render dynamically via <umb-extension-slot>. 

This means:
  * Import dependencies flow strictly one-way (feature → core)
  * Adding workflow support for a new entity type requires zero changes to core
  * Config and history tabs appear only when a module has registered relevant extensions for the current entity type

#### Accessibility improvements

* Date inputs, filter dropdowns, and day-range controls now have proper aria-label attributes, improving the experience for screen reader users.

#### Migration reliability

Fixes to improve the reliability of database migrations, particularly for sites upgrading from older versions with large datasets. 

The issues below were resolved as part of [#134](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/134).

* Batched inserts: The legacy v14 migration now processes bulk inserts in batches of 100 rows, preventing timeouts and memory pressure on large tables.
* Orphaned task approvals: History cleanup previously deleted tasks but not their associated approvals. The migration now cleans up orphaned approval records before migrating tasks. The cleanup process itself has been fixed to delete approvals alongside tasks going forward.
* Task ID remapping: After bulk insert reassigns identity values, task-to-approval foreign key relationships are now correctly preserved via an old-to-new ID mapping.
* Duplicate date shift: The UTC date migration was applying the timezone offset to ExpireDate twice and never migrating UpdateDate. Both columns are now migrated correctly.
* Scalar query fix: A permission count query was using ExecuteAsync instead of ExecuteScalarAsync, potentially causing incorrect permission revocation during migration.
* Entity type backfill: A new migration seeds EntityType and EntityKey on existing workflow instances where those columns were left null from a prior migration.
* Extensive logging: All migration steps now log at Information level with row counts and progress, making migration troubleshooting much easier.

#### Bug fixes

* Culture/segment variation in alternate versions: Properties that don't vary by culture or segment were incorrectly receiving culture/segment values from individual property records rather than from the version's own variation settings. Invariant properties no longer receive spurious culture/segment values. [#136](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/136)
* Missing node name in workspace detail: The node name could be null in the workspace detail modal when it wasn't populated from the tasks query. The scaffold now falls back to the already-fetched content slim record [#137](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/137)
* SignalR route registration: Hub routes are now registered via the `Endpoints` property of `UmbracoPipelineFilter` instead of `PostPipeline`, aligning with the correct Umbraco pipeline API.
* Translation typo: Fixed in an approval groups permission label. [#135](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/135)
* Missing content review configuration: The document-level configuration for content review was not displaying correctly in the document workspace. Content review configuration querying has been refactored and should deliver performance improvements. [#133](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/133)

#### UI improvements

* Approval groups table: Membership and permissions columns share a common base element, eliminating duplicated rendering logic. Column text no longer wraps unexpectedly.
* Instances table: Progress and requested-by columns styles updated to prevent layout shifts.
* Task list: Nested tasks with NOT_REQUIRED status no longer show a redundant status tag when their parent also has that status.

### [17.1.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.1) (March 2 2026)
* Fixes a bug where content scheduling via workflow approval could result in a key conflict exception, causing workflow initiation to fail [#132](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/132)
* Fixes Document Type filtering in Content Review configuration. A Document Type should be considered valid if it is not an Element, and has at least one property [#131](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/131)

### [17.1.0](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.1.0) (February 19 2026)
* Improves culture variation handling in email template generation
* Improves culture variation handling when scheduling release/expiry via workflow approval
* UI improvements for approval group workspace
* Adds missing email translations
* Introduces RazorLight for email template rendering. This fixes rendering issues when running in a hosted service in Production runtime mode.
* Fixes a bug where fallback email templates were not being detected and assigned (if the requested culture template did not exist)[#128] (https://github.com/umbraco/Umbraco.Workflow.Issues/issues/128)

### [17.0.2](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.2) (December 19, 2025)
* Fixes a bug where email templates were not compiled, resulting in emails failing to send [#124](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/124)
* Fixes async blocking code in email body generation
* Fixes a bug where changes to Document Type variance prevented updating properties on an alternate version

### [17.0.1](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.1) (December 11, 2025)
* Fixes a bug where removing document approval steps did not persist the changes [#122](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/122)
* Fixes a bug where the request-approval action was not displaying for new documents, where the new-document approval workflow had been configured [#121](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/121)
* Fixes a bug where adding an approval group would result in an error due a failing key-to-id map [#120](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/120)
* Fixes a bug where deleting content or document types did not complete correctly due to a missing scope [#119](https://github.com/umbraco/Umbraco.Workflow.Issues/issues/119)

### [17.0.0-rc](https://github.com/umbraco/Umbraco.Workflow.Issues/issues?q=is%3Aissue+is%3Aclosed+label%3Arelease%2F17.0.0-rc) (November 7, 2025)

* Compatibility with Umbraco 17-rc.
* Introduces granular permissions model.
* Updates all persistence operations to use scoped transactions.
* Moves Workflow settings from `/workflow` to `/settings`. This change allows users to access  `/workflow` without exposing low-level settings.
* Updates all DateTimes to UTC, in line with changes made in the CMS.

## Legacy release notes

You can find the release notes for versions out of support in the [Legacy documentation on GitHub](https://github.com/umbraco/UmbracoDocs/blob/umbraco-eol-versions/11/umbraco-workflow/release-notes.md)

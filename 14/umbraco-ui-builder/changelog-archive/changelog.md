---
description: Changelog for Konstrukt, the backoffice UI builder for Umbraco.
---

# Changelog

## v1.6.4

**Date:** 2023-02-22  
**Description:** Patch release with bug fixes

- Fixed issue where upload file property editor throws "the specified file type has been disallowed by the administrator" error  ([#49](https://github.com/outfielddigital/konstrukt/issues/49)).
- Added ngrok URLs to allow domains that don't need a license.

## v1.6.3

**Date:** 2023-01-16  
**Description:** Patch release with bug fixes

- Moved encrypted properties implementation to the base repository class so encryption is honored when performing save/load operation directly against the repository API ([#44](https://github.com/outfielddigital/konstrukt/issues/44)).
- Made `SecurityHelper` swappable so you can use something other than the default `DataProtectionProvider` implementation that comes out of the box (OOTB).
- Fixed issue with advanced filters that use the lambda `ParameterReplacer` due to the parameter being replaced in the function, but not in the Lambda parameters list ([#45](https://github.com/outfielddigital/konstrukt/issues/45)).
- Fixed date filters not working on mobile resolution devices ([#46](https://github.com/outfielddigital/konstrukt/issues/46)).

## v1.6.2

**Date:** 2022-12-01  
**Description:** Patch release with bug fixes

- Added marketplace updates.
- Update the Konstrukt type finder to use a non-obsolete constructor.
- Updated to use `IComposer` instead of `IUserComposer` as the latter has been removed in v11.
- Fixed parent ID not being passed to create dialog for associated entities.
- Removed settings section restriction on the licensing info endpoint as it would cause errors when the licensing banner is shown in other sections.

## v1.6.1

**Date:** 2022-10-11  
**Description:** Patch release with bug fixes

- Fixed issue when running on Azure where the DB provider name reverts to `System.Data.SqlClient` when it should be `Microsoft.Data.SqlClient`

## v1.6.0

**Date:** 2022-09-30  
**Description:** Minor release with additional features

- Added a Save action type to display actions as a sub-button in an entities Save button (similar to the "Save and Publish" button in the content section).

## v1.5.2

**Date:** 2022-09-09  
**Description:** Patch release with bug fixes

- Fixed bug in entity picker not correctly showing the `Add` button when it should ([#39](https://github.com/outfielddigital/konstrukt/issues/39)).
- Added some basic validation to config at startup to ensure a valid config model.

## v1.5.1

**Date:** 2022-08-22  
**Description:** Patch release with bug fixes

- Fixed searchable properties not being searched in a case-insensitive way for repositories that don't use Umbraco's NPoco extension methods ([#36](https://github.com/outfielddigital/konstrukt/issues/36)).
- Fixed regression in Konstrukt repository not correctly combining filters.
- Fixed exception due to `ServiceProvider` not getting passed to Data transfer object (DTO) mapper.

## v1.5.0

**Date:** 2022-08-18  
**Description:** Minor release with additional features and bug fixes

- Added ability to control collection visibility in the section tree at runtime.
- Added ability to control collection create, update, and delete permissions at runtime.
- Added ability to control list view field visibility at runtime.
- Added ability to control editor tab visibility at runtime.
- Added ability to control editor fieldset visibility at runtime.
- Added ability to control editor field visibility at runtime.
- Added ability to control whether an editor field is read-only or not at runtime.
- Added the ability to add custom dashboards to Konstrukt sections.
- Added child collections support to dashboard collections.
- Updated Konstrukt API to null check sections/collections first and throw exceptions if not found.
- Updated based repositories to automatically implement filtering for configurable options.
- Updated the summary dashboard to not display if there are no collections configured to show on it.
- Fixed bug where entity service would silently fail if it couldn't retrieve an entity. Now throws an exception.
- Fixed bug where content app factory would throw an exception when run in sections where the section entity was not `IUmbracoEntity`.

## v1.4.0

**Date:** 2022-07-12  
**Description:** Minor release with additional features and bug fixes

- Added [`WithSection`](../areas/sections.md#extending-an-existing-section) / [`WithTree`](../areas/trees.md#extending-an-existing-tree) API to create more logical API groupings and to set context for some APIs.
- Added [`AddTree`](../areas/trees.md#adding-a-tree-to-an-existing-section) support to allow adding a tree to an existing section (currently only able to add 1 Konstrukt tree per section).
- Added [Tree Group](../areas/trees.md#adding-a-group-to-a-tree) support to allow grouping root-level tree folders/collections.
- Added [Tab Sidebar](../collections/editors.md#configuring-a-sidebar-to-a-tab) support to allow showing metadata on the right-hand side of the editor.
- Added file upload support to the actions dialog
- Added a basic [Comma-separated values (CSV) Import](../actions/inbuilt-actions.md#konstruktimportentityaction) action
- Added [`HideLabel`](../collections/editors.md#hiding-the-label-of-a-field) support to editor fields to explicitly hide the label.
- Added explicit Insert / Update methods to IKonstruktRepository. Internally we use these now instead of the Save method as the Save method isn't reliably able to determine if an entity is new.
- Added better support for transient / scoped repository dependencies (example: better support for EF Core DB contexts which are by default registered as scoped)
- Obsoleted root-level APIs for `AddSection`, `AddDashboard` and `AddVirtualSubTree` which have now moved to sub-configurations of the [`WithSection`](../areas/sections.md#extending-an-existing-section) or [`WithTree`](../areas/trees.md#extending-an-existing-tree) APIs.
- Fixed bug with DataViews resolving the wrong filter when using groups and the data view has the same name as a view in a different group. We now prefix the data view alias with the group name to ensure uniqueness across groups.
- Fixed bug in child collections creating dialog thinking it was always editing an existing entity and so wrongfully trying to load an entity from the DB due to the fact the entity ID passed through to the dialog "0" when it should be "-1".

## v1.3.0

**Date:** 2022-07-06  
**Description:** Minor release with additional features and bug fixes

- Added [Virtual Sub Trees](../advanced/virtual-sub-trees.md) support
- Fixed save/delete notification events being passed the wrong model
- Fixed bug where connection strings with no provider cause an error

## v1.2.0

**Date:** 2022-06-20  
**Description:** Minor release with some breaking changes / additional features

- Added `DeletedProperty` support where the column type is an `int`, and the value is a unix timestamp
- Fixed bug with encrypted properties not handling `null` values
- **[Breaking]** - Updated minimum Umbraco dependency to v10
- **[Breaking]** - Updated UI assets to be a (RCL) Razor Compiled Library. **Be sure to clean your solution to remove old files**.

## v1.1.1

**Date:** 2022-06-08  
**Description:** Minor patch release with non-breaking changes

- Added client-side required / regex validation support
- Added support for nullable types when mapping property filters
- Added support for passing notification messages back from action results
- Fixed SQL escaping issue when using table names with schema prefix
- Fixed a bug in range property filters when a value is `null`
- Fixed a bug where save operations would show a success notification even if the save operation failed
- Fixed a bug in Data Attribute validation where `IServiceProvider` wasn't being passed through
- Fixed `null` error when searching returns no items
- Fixed deleted property filter condition not working
- Fixed bug where encrypted properties would throw an exception if the value was `null`

## v1.1.0

**Date:** 2022-05-03
**Description:** Minor release with some breaking changes / additional features

- Added field views support for custom field markup in list views
- Added new consistent actions API
- Added row actions support
- Added filterable properties support
- Fixed entity picker value converter not working
- Fixed JS error when editing content due to bad null checking in the Konstrukt `redirectId` interceptor
- Deprecated List View Layout support
- **[Breaking]** - Obsoleted bulk actions and menu items in favour of new actions API
- **[Breaking]** - Moved actions, data views and cards configuration out of list views onto collections API

## v1.0.2

**Date:** 2022-04-11  
**Description:** Minor patch release with non-breaking changes

- Fixed OrderBy not handling name field correctly
- Updated license warning to only display if the number of "editable" collections is exceeded
- Fixed custom connection strings not working by implementing a DB factory pattern
- Introduced `IKonstruktNodeUdiResolver` to allow content apps to resolve a different node UDI than the current page
- Fixed error being thrown by menu actions because the current section wasn't being passed through to the menu

## v1.0.1

**Date:** 2022-01-27  
**Description:** Minor patch release with non-breaking changes

- Fixed bug where section/tree registration can sometimes occur twice resulting in an error.
- Removed licensing header when using a single collection.
- Fixed bug with `ORDER BY 1` causing SQL exceptions

## v1.0.0

**Date:** 2022-01-20  
**Description:** Major new release  

- Initial release

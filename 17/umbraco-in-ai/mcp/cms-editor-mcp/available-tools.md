---
description: List of tools that are available in the Editor MCP
---

# Available Tools

This document lists all available tools grouped by collection. Each collection represents a functional area of the Editor MCP Server.

The names shown in parentheses, for example, `(content)` or `(media)` refer to the **Tool Collection names**, which are used for configuration via environment variables: `UMBRACO_INCLUDE_TOOL_COLLECTIONS` or `UMBRACO_EXCLUDE_TOOL_COLLECTIONS`.

## Table of Contents

- [Content (`content`)](#content-content)
- [Publishing (`publishing`)](#publishing-publishing)
- [Version History (`versioning`)](#version-history-versioning)
- [Media (`media`)](#media-media)
- [Media Management (`media-management`)](#media-management-media-management)
- [Blueprints (`blueprint`)](#blueprints-blueprint)
- [Languages (`language`)](#languages-language)
- [Translation (`translation`)](#translation-translation)
- [Dictionary (`dictionary`)](#dictionary-dictionary)
- [Tags (`tag`)](#tags-tag)
- [Content Health (`content-health`)](#content-health-content-health)
- [Site Structure (`site-structure`)](#site-structure-site-structure)
- [Bulk Operations (`bulk-operations`)](#bulk-operations-bulk-operations)
- [Members (`member`)](#members-member)
- [Member Groups (`member-group`)](#member-groups-member-group)
- [Member Reporting (`member-reporting`)](#member-reporting-member-reporting)
- [Scheduling (`scheduling`)](#scheduling-scheduling)
- [Redirects (`redirect`)](#redirects-redirect)
- [Content Relationships (`relationships`)](#content-relationships-relationships)
- [Public Access (`public-access`)](#public-access-public-access)
- [Content Notifications (`notifications`)](#content-notifications-notifications)
- [Recycle Bin (`recycle-bin`)](#recycle-bin-recycle-bin)
- [Account (`account`)](#account-account)

## Content (`content`)

Search, browse, and manage content pages.

- `search-content` — Search for content pages by name or text. Returns a list of matching pages with their names and IDs. Use `get-page` with an ID from the results to retrieve full page content.
- `get-page` — Get the full details of a content page including all its fields and values. Non-block properties are returned as-is. Block-based properties (BlockList, BlockGrid, Rich Text) are summarized with a block count — use `inspect-blocks` to see their full structure.
- `list-children` — List content pages in the site tree. Shows child pages under a parent, or root-level pages if no parent is specified.
- `list-document-types` — List available Document Types that can be used to create new pages. Returns the ID, alias, and name of each type. Returns up to 50 by default — use `nextCursor` from the response to fetch more.
- `get-document-type` — Get the full schema for a Document Type, including the list of editable properties (alias, name, description). Use before `edit-page` or `save-and-publish` to discover which property aliases can be set.
- `inspect-blocks` — Inspect the block structure of a content page. Shows each block's type, unique key, and property values. Use this before `edit-block` to understand how content is structured.
- `report-page-references` — List all items that reference a content page — for example, other pages with content pickers, rich-text links, or multi-node-tree-picker values pointing at it. Use before `delete-page` to understand the impact.
- `list-page-templates` — List the templates a page can use. Returns the current template, the Document Type's default template, and every allowed template with `isDefault`/`isCurrent` flags. Use before `set-page-template`.
- `get-property-value-template` — Get the expected JSON value shape for a non-block structured property editor — for example, `Umbraco.MediaPicker3`, `Umbraco.MultiNodeTreePicker`, `Umbraco.ImageCropper`, or `Umbraco.DateTime`. Use before `edit-page`, `create-page`, `bulk-set-property`, or when composing inner-block values for `edit-block` and the `add-*-block` tools. Omit the editor alias to list every available editor.
- `create-page` — Create a new content page as a draft. The page will not be published automatically. Call `list-document-types` first to find a valid Document Type ID.
- `duplicate-page` — Duplicate a content page (and optionally all its descendants) to a new location. The copy is created as a draft named `Original Name (N)`. Returns the new page ID for follow-up edits.
- `add-blocklist-block` — Add a new block to a BlockList property on a page. Use `inspect-blocks` first to find the property alias and a sample content type key. For non-string values inside the block, call `get-property-value-template` first to discover the expected JSON shape. Changes are saved as a draft, not published.
- `add-blockgrid-block` — Add a new block to a BlockGrid property on a page. Supports `rowSpan`/`columnSpan` and inserting into a named area on a parent block. Use `inspect-blocks` first to find the property alias and a sample content type key. Changes are saved as a draft, not published.
- `add-rte-block` — Add a new block inside a Rich Text property on a page. Inserts the `umb-rte-block` tag in the markup and adds the matching content/settings entries. Use `inspect-blocks` first to find the property alias and a sample content type key. Changes are saved as a draft, not published.
- `edit-page` — Update specific fields on a content page. Changes are saved but not published. Call `get-page` first to discover valid property aliases.
- `edit-block` — Update properties within a specific block (BlockList, BlockGrid, or Rich Text block). Use `inspect-blocks` first to find the property alias and content key.
- `sort-children` — Reorder child pages under a parent (or at the content root) by specifying their new sort-order values. Use `list-children` to discover the current order first.
- `set-page-template` — Switch the template (rendering layout) of a page. Pass a `templateId` from the Document Type's allowed templates, or `null` to clear back to the default. Changes are saved but not published — the live page keeps the old template until you publish.
- `restore-page` — Restore a content page from the recycle bin. Optionally specify a parent page ID, otherwise it restores to the content root.
- `delete-page` — Move a content page to the recycle bin. The page can be restored later if needed.
- `delete-block` — Remove a single block from a BlockList, BlockGrid, or Rich Text property on a page. Supply the page ID, property alias, and block content key — use `inspect-blocks` first to find these. The change is saved as a draft, not published.

## Publishing (`publishing`)

Publish and unpublish content pages. Depends on the `content` collection.

- `publish-page` — Publish a content page to make it live on the website. Optionally publish all child pages too.
- `unpublish-page` — Unpublish a content page, removing it from the live website. The page will still exist as a draft.
- `save-and-publish` — Save property changes and publish a content page in one atomic operation — mirrors the **Save and publish** button in the Umbraco backoffice. Optionally publish descendants. Call `get-page` or `get-document-type` first to discover valid property aliases.

## Version History (`versioning`)

View version history, change history, and rollback to previous versions. Depends on the `content` collection.

- `list-versions` — List the version history of a content page. Shows when each version was saved and by whom. Use this to find a version ID before rolling back.
- `get-page-change-history` — List the audit log (the **History** entry on the Info tab) for a content page — who did what to this page and when. Shows saves, publishes, take-downs, rollbacks, moves, and similar actions.
- `rollback-page` — Rollback a content page to a previous version. This replaces the current draft with the selected version. The published version is not affected until you publish again.

## Media (`media`)

Browse, search, and view media items.

- `search-media` — Search for media items by name. Returns matching items with names, types, and URLs.
- `list-media-children` — List items and folders in the media library under a parent, or root-level items if no parent is specified.
- `get-media` — Get the full details of a media item including URLs, dimensions, and properties.
- `list-media-types` — List media types allowed in a folder (or at the root). Use this before `upload-media` to find the correct media type.
- `get-media-type` — Get the full schema for a media type, including the list of editable properties. Use before `edit-media` to discover which aliases can be set — for example, `altText` on an Image.
- `get-media-change-history` — List the audit log (the **History** entry on the Info tab) for a media item — who did what to this file and when.
- `report-media-references` — List all items that reference a media item — for example, pages with image or media pickers pointing at it. Use before `delete-media` or `move-media` to understand the impact.

## Media Management (`media-management`)

Upload, organize, delete, and restore media items.

- `upload-media` — Upload a file from a local path to the media library. Optionally specify a target folder and media-type name (defaults to `Image`).
- `create-media-folder` — Create a new folder in the media library. The returned ID can be used as `parentId` in `upload-media` or `list-media-children`.
- `move-media` — Move a media item or folder to a different folder in the media library.
- `delete-media` — Move a media item to the recycle bin. The item can be restored later if needed.
- `restore-media` — Restore a media item from the recycle bin.
- `bulk-move-media` — Move multiple media items or folders to a different folder (max 10). Lists each item name and destination for confirmation before moving.
- `edit-media` — Update properties on a media item — commonly used to set alt text (for example, `altText` on the default Image media type) or rename an item. Call `get-media-type` first to discover valid property aliases.
- `sort-media-children` — Reorder child media items under a folder (or at the media root) by specifying their new sort-order values. Use `list-media-children` to discover the current order first.

## Blueprints (`blueprint`)

List, view, and create page blueprints.

- `list-blueprints` — List available page blueprints (templates with pre-filled content).
- `get-blueprint` — Get the full details of a page blueprint including its pre-filled property values.
- `create-blueprint` — Save an existing page as a reusable blueprint. The blueprint preserves the page's Document Type and property values.

## Languages (`language`)

Manage languages configured on the Umbraco site.

- `list-languages` — List all languages configured on the Umbraco site. Shows the ISO code, name, and whether each language is the default or mandatory.
- `get-language` — Get details of a language by its ISO code. Shows default/mandatory status and fallback language.
- `create-language` — Add a new language to the Umbraco site.
- `update-language` — Update a language's settings (default, mandatory, fallback).
- `delete-language` — Remove a language from the site. Content variants in this language will become inaccessible.

## Translation (`translation`)

Create and manage language variants for content pages.

- `create-variant` — Create a new language variant for a content page. Call `list-languages` to find available cultures. Optionally provide property values for the new variant.
- `copy-variant` — Copy all content from one language variant to another as a starting point for translation. Overwrites the target variant's content. Creates the target variant if it does not exist.
- `list-untranslated` — Find content pages that are missing a specific language variant. Use `parentId` to scope to a subtree on larger sites. Use `copy-variant` to seed translations for found pages.

## Dictionary (`dictionary`)

Manage translation dictionary entries for UI labels and static text.

- `list-dictionary` — Browse the dictionary tree. Shows root entries or children of a parent. Each item shows which languages have translations.
- `search-dictionary` — Search for dictionary items by key name.
- `get-dictionary` — Get a dictionary item with all its translations across languages.
- `create-dictionary` — Create a new dictionary item with translations. Dictionary keys typically use dot-notation (for example, `Header.Title`, `Buttons.ReadMore`).
- `update-dictionary` — Update translations for a dictionary item.
- `move-dictionary` — Move a dictionary item to a different parent in the dictionary tree, or to the root.

## Tags (`tag`)

Browse tags in use across the site.

- `list-tags` — List tags in use across the site. Optionally filter by tag group. Shows how many content items use each tag.

## Content Health (`content-health`)

Content quality auditing and SEO analysis.

- `audit-page-seo` — Audit a page's SEO health. Returns title, meta description, headings, images with alt-text status, and word count. Includes flags for quick scanning and raw data for detailed analysis.
- `audit-page-content` — Retrieve a page's body text alongside its meta description for alignment analysis. Use to identify where the meta description does not reflect the actual content.

## Site Structure (`site-structure`)

Site architecture analysis and structure reporting.

- `report-site-tree-summary` — Full site tree structure with page counts per level. Returns hierarchical data that maps to tree diagrams, sitemaps, and flowcharts. Use `maxDepth` to limit how deep to scan.
- `report-deep-pages` — Find pages buried more than N levels deep in the site tree. Deep pages are harder for users to find. Default threshold is 4 levels.

## Bulk Operations (`bulk-operations`)

Safe bulk content operations with confirmation and rollback support. All operations are limited to a maximum of 10 pages per call.

- `bulk-publish` — Publish multiple pages at once. Each result includes a previous-version ID for rollback.
- `bulk-unpublish` — Take multiple pages offline at once. Pages will remain as drafts.
- `bulk-schedule-publish` — Schedule multiple pages to publish at a future date. Provide the date in ISO 8601 format.
- `bulk-set-property` — Set the same property value on multiple pages at once. Call `get-page` first to verify the property alias exists.
- `bulk-move` — Move multiple pages to a new parent location. Restructuring the site tree is hard to undo — review carefully before confirming.
- `bulk-set-block-property` — Update properties on blocks of a specific type across multiple pages. Targets all blocks matching a given element type within the specified property. Use `inspect-blocks` first to find the content type key and property alias. Changes are saved but not published.

## Members (`member`)

Search, view, create, update, and delete members.

- `search-members` — Search for members by name or email address. Returns matching members with their approval and lockout status.
- `get-member` — Get the full profile of a member including their groups, properties, approval status, and login history.
- `list-member-types` — List available member types. Use this before `create-member` to find a valid member-type ID.
- `create-member` — Create a new member account. Call `list-member-types` to find a valid member-type ID and `list-member-groups` to find group IDs.
- `update-member` — Update a member's profile, credentials (username, password, 2FA toggle), approval status, groups, or custom properties. Password resets require an extra confirmation.
- `delete-member` — Permanently delete a member. This cannot be undone — there is no recycle bin for members.

## Member Groups (`member-group`)

Manage member groups for organizing members.

- `list-member-groups` — List all member groups. Use group names when creating or updating members to assign them to groups.
- `create-member-group` — Create a new member group. Groups are referenced by name when assigning members via `create-member` or `update-member`.
- `delete-member-group` — Delete a member group. Members in this group will lose the group assignment.

## Member Reporting (`member-reporting`)

Member analytics and reporting.

- `report-member-count` — Returns a breakdown of member counts by type and group. Analyses up to 500 members — results may be incomplete on larger sites.
- `report-members-by-group` — List members belonging to a specific group. Use `list-member-groups` to find valid group names.
- `report-member-activity` — Find members who have not logged in within a given number of days. Default threshold is 90 days. Members who have never logged in are always included. Analyses up to 500 members.

## Scheduling (`scheduling`)

View and manage scheduled content publishing.

- `get-publish-status` — View a page's current publish state including any scheduled publish or unpublish dates. Shows per-variant status for multilingual sites.
- `schedule-publish` — Schedule a page to publish at a future date. Provide the date in ISO 8601 format. Optionally specify a culture for variant-specific scheduling.
- `cancel-schedule` — Cancel a pending scheduled publish for a page. Use `get-publish-status` to verify the page has a pending schedule.

## Redirects (`redirect`)

View and manage URL redirects.

- `list-redirects` — List URL redirects configured on the site. Optionally filter by URL. Shows the original URL, destination, and whether the redirect was created automatically by Umbraco.
- `get-redirect` — View the full details of a URL redirect including when it was created and whether it was automatic.
- `get-redirect-status` — Check whether automatic URL redirect tracking is enabled on the site. When enabled, Umbraco automatically creates redirects when pages are moved or renamed.
- `delete-redirect` — Delete a URL redirect. Visitors following the original URL will get a 404 error.

## Content Relationships (`relationships`)

Inbound references, outbound links, and relationship mapping.

- `report-content-references` — Find which pages reference a given content page or media item. Useful before deleting or restructuring content to understand the impact.
- `report-outbound-links` — Show everything a page links to: internal content pages, media items, and external URLs. Extracts references from content pickers, media pickers, rich-text links, and block content. Use this to understand a page's dependencies before restructuring.

## Public Access (`public-access`)

Manage member-group-based access restrictions on content pages.

- `get-public-access` — Read the public access (member-group restriction) settings for a content page. Returns the member groups, members, login page, and error page configured via the **Public Access** entity action. If the page has no restrictions, returns `hasRestrictions: false`.
- `set-public-access` — Restrict a content page to members of specific groups (or specific members), redirecting unauthenticated visitors to a login page. Equivalent to the **Public Access** entity action in the Umbraco backoffice. Creates new rules on first call, updates them on subsequent calls.
- `remove-public-access` — Remove all public access restrictions from a content page, making it publicly viewable again.

## Content Notifications (`notifications`)

Manage per-user email notification subscriptions on content pages. The tools in this collection target the **current OAuth user's** notification subscriptions. They are only registered when the server runs in the hosted Cloudflare Worker. In stdio mode they are filtered out because the static API user has no real inbox.

- `get-content-notifications` — Get the current OAuth user's email notification subscriptions for a content page. Returns the full list of available actions (publish, unpublish, save, delete, and similar) with the user's subscribed/unsubscribed state for each.
- `set-content-notifications` — Replace the current OAuth user's email notification subscriptions for a content page. This is a full overwrite — any action ID not in the list will be unsubscribed.

## Recycle Bin (`recycle-bin`)

List the content or media recycle bin and permanently delete items or empty the bin (irreversible).

- `list-recycle-bin` — List items in the content or media recycle bin. Returns one level at a time — when a trashed item has `hasChildren: true` it is a trashed folder; pass its ID as `parentId` on a follow-up call to drill into its contents.
- `permanent-delete-recycle-bin-item` — Permanently delete a single item from the content or media recycle bin. Deleting a trashed folder deletes its entire subtree. This cannot be undone. Always asks for confirmation with an itemized preview before deleting.
- `empty-recycle-bin` — Empty the entire content or media recycle bin — permanently deletes every trashed item including the contents of any trashed folders. This cannot be undone. Always asks for two successive confirmations before executing.

## Account (`account`)

Identify the Umbraco backoffice user this MCP server is authenticated as.

- `get-current-user` — Identify which Umbraco backoffice user the MCP server is authenticated as. Returns the user's name, email, admin flag, and resolved user-group names. Use to confirm identity when permissions behave unexpectedly — for example, when an action fails or returns different data than expected — before assuming the API is broken.

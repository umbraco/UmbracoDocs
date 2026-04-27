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
- [Translation (`translation`)](#translation-translation)
- [Languages (`language`)](#languages-language)
- [Dictionary (`dictionary`)](#dictionary-dictionary)
- [Tags (`tag`)](#tags-tag)
- [Content Health (`content-health`)](#content-health-content-health)
- [Content Reporting (`content-reporting`)](#content-reporting-content-reporting)
- [Site Structure (`site-structure`)](#site-structure-site-structure)
- [Content Relationships (`relationships`)](#content-relationships-relationships)
- [Media Health (`media-health`)](#media-health-media-health)
- [Bulk Operations (`bulk-operations`)](#bulk-operations-bulk-operations)
- [Members (`member`)](#members-member)
- [Member Groups (`member-group`)](#member-groups-member-group)
- [Member Reporting (`member-reporting`)](#member-reporting-member-reporting)
- [Scheduling (`scheduling`)](#scheduling-scheduling)
- [Redirects (`redirect`)](#redirects-redirect)

## Content (`content`)

Search, browse, and manage content pages.

- `search-content` — Search for content pages by name or text. Returns a list of matching pages with their names and IDs. Use `get-page` with an ID from the results to retrieve full page content.
- `get-page` — Get the full details of a content page including all its fields and values. Block-based properties (BlockList, BlockGrid, Rich Text) are summarized with a block count. Use `inspect-blocks` to see their full structure.
- `list-children` — List content pages in the site tree. Shows child pages under a parent, or root-level pages if no parent is specified.
- `list-document-types` — List available Document Types that can be used to create new pages. Returns the ID, alias, and name of each type.
- `inspect-blocks` — Inspect the block structure of a content page. Shows each block's type, unique key, and property values. Use this before `edit-block` to understand how content is structured.
- `create-page` — Create a new content page as a draft. The page will not be published automatically. Call `list-document-types` first to find a valid Document Type ID.
- `edit-page` — Update specific fields on a content page. Changes are saved but not published. Call `get-page` first to discover valid property aliases.
- `edit-block` — Update properties within a specific block (BlockList, BlockGrid, or Rich Text block). Use `inspect-blocks` first to find the property alias and content key.
- `delete-page` — Move a content page to the recycle bin. The page can be restored later if needed.

## Publishing (`publishing`)

Publish and unpublish content pages. Depends on the `content` collection.

- `publish-page` — Publish a content page to make it live on the website. Optionally publish all child pages too.
- `unpublish-page` — Unpublish a content page, removing it from the live website. The page will still exist as a draft.

## Version History (`versioning`)

View version history and rollback to previous versions. Depends on the `content` collection.

- `list-versions` — List the version history of a content page. Shows when each version was saved and by whom.
- `rollback-page` — Rollback a content page to a previous version. This replaces the current draft with the selected version. The published version is not affected until you publish again.

## Media (`media`)

Browse, search, and view media items.

- `search-media` — Search for media items by name. Returns matching items with names, types, and URLs.
- `list-media-children` — List items and folders in the media library under a parent, or root-level items if no parent specified.
- `get-media` — Get the full details of a media item including URLs, dimensions, and properties.
- `list-media-types` — List media types allowed in a folder (or at root). Use this before `upload-media` to find the correct media type.

## Media Management (`media-management`)

Upload, organize, delete, and restore media items.

- `upload-media` — Upload a file from a local path to the media library. Optionally specify a target folder. Call `list-media-types` first to find a valid media type ID.
- `create-media-folder` — Create a new folder in the media library.
- `move-media` — Move a media item or folder to a different folder in the media library.
- `delete-media` — Move a media item to the recycle bin. The item can be restored later if needed.
- `restore-media` — Restore a media item from the recycle bin.

## Blueprints (`blueprint`)

List, view, and create page blueprints.

- `list-blueprints` — List available page blueprints (templates with pre-filled content).
- `get-blueprint` — Get the full details of a page blueprint including its pre-filled property values.
- `create-blueprint` — Save an existing page as a reusable blueprint. The blueprint preserves the page's Document Type and property values.

## Translation (`translation`)

Create and manage language variants for content pages.

- `create-variant` — Create a new language variant for a content page. Call `list-languages` to find available cultures.
- `copy-variant` — Copy all content from one language variant to another as a starting point for translation. Overwrites the target variant's content.
- `list-untranslated` — Find content pages that are missing a specific language variant. Use `copy-variant` to seed translations for found pages.

## Languages (`language`)

Manage languages configured on the Umbraco site.

- `list-languages` — List all languages configured on the Umbraco site. Shows the ISO code, name, and whether each language is the default or mandatory.
- `get-language` — Get details of a language by its ISO code. Shows default/mandatory status and fallback language.
- `create-language` — Add a new language to the Umbraco site.
- `update-language` — Update a language's settings (default, mandatory, fallback).
- `delete-language` — Remove a language from the site. Content variants in this language will become inaccessible.

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

- `audit-page-seo` — Audit a page's SEO health. Returns title, meta description, headings, images with alt text status, and word count.
- `audit-page-content` — Retrieve a page's body text alongside its meta description for alignment analysis. Use to identify where the meta description does not reflect the actual content.
- `report-empty-fields` — Find pages with blank or missing property values. Scans pages in a subtree and reports which fields are empty.
- `report-short-content` — Find pages with thin content below a word count threshold. Default threshold is 100 words.
- `report-media-missing-alt` — Find media images missing alt text. Important for accessibility and SEO.

## Content Reporting (`content-reporting`)

Content lifecycle, freshness, and translation reporting.

- `report-stale-content` — Find pages not updated within a given number of days. Default threshold is 180 days.
- `report-unpublished` — Find pages that are in draft state or have been unpublished.
- `report-recently-changed` — Find pages changed within a recent time period. Default is the last 7 days.
- `report-content-by-type` — Breakdown of content pages by Document Type. Shows how many pages use each type with example pages.
- `report-translation-coverage` — Translation coverage matrix showing which pages have which language variants.

## Site Structure (`site-structure`)

Site architecture analysis and structure reporting.

- `report-site-tree-summary` — Full site tree structure with page counts per level. Use `maxDepth` to limit how deep to scan.
- `report-deep-pages` — Find pages buried more than N levels deep in the site tree. Deep pages are harder for users to find.

## Content Relationships (`relationships`)

Inbound references, outbound links, and relationship mapping.

- `report-content-references` — Find which pages reference a given content page or media item. Useful before deleting or restructuring content to understand the impact.
- `report-orphan-pages` — Find pages with no inbound content references from other pages. These orphan pages may be unreachable or forgotten. Scans up to 100 pages per call.
- `report-outbound-links` — Show everything a page links to: internal content pages, media items, and external URLs. Use this to understand a page's dependencies before restructuring.

## Media Health (`media-health`)

Media library health and usage analysis.

- `report-large-media` — Find media files above a size threshold. Default is 1MB. Large files slow page loads and waste bandwidth.

## Bulk Operations (`bulk-operations`)

Safe bulk content operations with confirmation and rollback support. All operations are limited to a maximum of 10 pages per call.

- `bulk-publish` — Publish multiple pages at once. Each result includes a previous version ID for rollback.
- `bulk-unpublish` — Take multiple pages offline at once. Pages will remain as drafts.
- `bulk-schedule-publish` — Schedule multiple pages to publish at a future date.
- `bulk-set-property` — Set the same property value on multiple pages at once. Call `get-page` first to verify the property alias exists.
- `bulk-move` — Move multiple pages to a new parent location.
- `bulk-set-block-property` — Update properties on blocks of a specific type across multiple pages. Targets all blocks matching a given element type within the specified property. Use `inspect-blocks` first to find the content type key and property alias. Changes are saved but not published.

## Members (`member`)

Search, view, create, update, and delete members.

- `search-members` — Search for members by name or email address.
- `get-member` — Get the full profile of a member including their groups, properties, approval status, and login history.
- `list-member-types` — List available member types.
- `create-member` — Create a new member account.
- `update-member` — Update a member's profile, approval status, groups, or custom properties.
- `delete-member` — Permanently delete a member. This cannot be undone.

## Member Groups (`member-group`)

Manage member groups for organizing members.

- `list-member-groups` — List all member groups.
- `create-member-group` — Create a new member group.
- `delete-member-group` — Delete a member group. Members in this group will lose the group assignment.

## Member Reporting (`member-reporting`)

Member analytics and reporting.

- `report-member-count` — Returns a breakdown of member counts by type and group.
- `report-members-by-group` — List members belonging to a specific group.
- `report-member-activity` — Find members who have not logged in within a given number of days. Default threshold is 90 days.

## Scheduling (`scheduling`)

View and manage scheduled content publishing.

- `get-publish-status` — View a page's current publish state including any scheduled publish or unpublish dates.
- `list-scheduled-content` — Find pages with pending scheduled publish or unpublish dates.
- `schedule-publish` — Schedule a page to publish at a future date.
- `cancel-schedule` — Cancel a pending scheduled publish for a page.

## Redirects (`redirect`)

View and manage URL redirects.

- `list-redirects` — List URL redirects configured on the site. Optionally filter by URL.
- `get-redirect` — View the full details of a URL redirect including when it was created and whether it was automatic.
- `get-redirect-status` — Check whether automatic URL redirect tracking is enabled on the site.
- `delete-redirect` — Delete a URL redirect. Visitors following the original URL will get a 404 error.

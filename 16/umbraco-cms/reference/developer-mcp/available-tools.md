---
description: The tools that have been enabled in the Developer MCP
---

# Available tools

This document lists all available tools grouped according to the categories defined in the **Umbraco Open API definition**.  
Each section represents a functional area of the API, following the same grouping and naming conventions used within Umbraco’s backend services.  

The names shown in parentheses — for example, `(document)` or `(data-type)` — refer to the **Tool Collection names**, which are used for configuration via environment variables; UMBRACO_INCLUDE_TOOL_COLLECTIONS or UMBRACO_EXCLUDE_TOOL_COLLECTIONS.


## Table of Contents
- [Culture (`culture`)](#culture-culture)
- [Data Type (`data-type`)](#data-type-data-type)
- [Dictionary (`dictionary`)](#dictionary-dictionary)
- [Document (`document`)](#document-document)
- [Document Blueprint (`document-blueprint`)](#document-blueprint-document-blueprint)
- [Document Version (`document-version`)](#document-version-document-version)
- [Document Type (`document-type`)](#document-type-document-type)
- [Health (`health`)](#health-health)
- [Imaging (`imaging`)](#imaging-imaging)
- [Indexer (`indexer`)](#indexer-indexer)
- [Language (`language`)](#language-language)
- [Log Viewer (`log-viewer`)](#log-viewer-log-viewer)
- [Manifest (`manifest`)](#manifest-manifest)
- [Media (`media`)](#media-media)
- [Media Type (`media-type`)](#media-type-media-type)
- [Member (`member`)](#member-member)
- [Member Group (`member-group`)](#member-group-member-group)
- [Member Type (`member-type`)](#member-type-member-type)
- [Models Builder (`models-builder`)](#models-builder-models-builder)
- [Partial View (`partial-view`)](#partial-view-partial-view)
- [Property Type (`property-type`)](#property-type-property-type)
- [Redirect (`redirect`)](#redirect-redirect)
- [Relation (`relation`)](#relation-relation)
- [Relation Type (`relation-type`)](#relation-type-relation-type)
- [Script (`script`)](#script-script)
- [Searcher (`searcher`)](#searcher-searcher)
- [Server (`server`)](#server-server)
- [Static File (`static-file`)](#static-file-static-file)
- [Stylesheet (`stylesheet`)](#stylesheet-stylesheet)
- [Tag (`tag`)](#tag-tag)
- [Template (`template`)](#template-template)
- [Temporary File (`temporary-file`)](#temporary-file-temporary-file)
- [User (`user`)](#user-user)
- [User Data (`user-data`)](#user-data-user-data)
- [User Group (`user-group`)](#user-group-user-group)
- [Webhook (`webhook`)](#webhook-webhook)

---

## Culture (`culture`)
- `get-culture` — Get all cultures available to Umbraco

## Data Type (`data-type`)
- `get-data-type-search` — Search for data types
- `get-references-data-type` — Get references to a data type
- `is-used-data-type` — Check if a data type is in use
- `get-data-type` — Get a specific data type by ID
- `get-data-type-configuration` — Get data type configuration
- `get-property-editor-template` — Get property editor template
- `get-data-type-root` — Get root level data types
- `get-data-type-children` — Get child data types
- `get-data-type-ancestors` — Get ancestor data types
- `get-all-data-types` — Get all data types
- `delete-data-type` — Delete a data type
- `create-data-type` — Create a new data type
- `update-data-type` — Update an existing data type
- `copy-data-type` — Copy a data type
- `move-data-type` — Move a data type to a different location
- `find-data-type` — Find data types by criteria
- `create-data-type-folder` — Create a folder for organizing data types
- `delete-data-type-folder` — Delete a data type folder
- `get-data-type-folder` — Get information about a data type folder
- `update-data-type-folder` — Update a data type folder's details

## Dictionary (`dictionary`)
- `find-dictionary-item` — Search for dictionary items
- `create-dictionary-item` — Create a new dictionary item
- `get-dictionary-item` — Get a dictionary item by key
- `delete-dictionary-item` — Delete a dictionary item
- `update-dictionary-item` — Update a dictionary item
- `move-dictionary-item` — Move a dictionary item
- `get-dictionary-root` — Get root dictionary items
- `get-dictionary-children` — Get child dictionary items
- `get-dictionary-ancestors` — Get ancestor dictionary items

## Document (`document`)
- `get-document-by-id` — Get a document by ID
- `get-document-publish` — Get document publish status
- `get-document-configuration` — Get document configuration
- `copy-document` — Copy a document
- `create-document` — Create a new document
- `post-document-public-access` — Set document public access
- `delete-document` — Delete a document
- `delete-document-public-access` — Remove public access from a document
- `get-document-urls` — Get document URLs
- `get-document-domains` — Get document domains
- `get-document-audit-log` — Get document audit log
- `get-document-public-access` — Get document public access settings
- `move-document` — Move a document
- `move-to-recycle-bin` — Move document to recycle bin
- `get-document-notifications` — Get document notifications
- `publish-document` — Publish a document
- `publish-document-with-descendants` — Publish a document and its descendants
- `sort-document` — Sort document order
- `unpublish-document` — Unpublish a document
- `update-document` — Update a document
- `put-document-domains` — Update document domains
- `put-document-notifications` — Update document notifications
- `put-document-public-access` — Update document public access
- `delete-from-recycle-bin` — Delete document from recycle bin
- `empty-recycle-bin` — Empty the recycle bin
- `restore-document-from-recycle-bin` — Restore a document from the recycle bin
- `get-recycle-bin-root` — Get root items in recycle bin
- `get-recycle-bin-children` — Get child items in recycle bin
- `search-document` — Search for documents
- `validate-document` — Validate a document
- `get-collection-document-by-id` — Get document collection by ID
- `get-document-are-referenced` — Check if documents are referenced
- `get-document-by-id-referenced-by` — Get documents referencing this document
- `get-document-by-id-referenced-descendants` — Get referenced descendants of a document
- `get-recycle-bin-document-original-parent` — Get original parent of recycled document
- `get-recycle-bin-document-referenced-by` — Get documents referencing recycled document
- `get-document-root` — Get root documents
- `get-document-children` — Get child documents
- `get-document-ancestors` — Get document ancestors

## Document Blueprint (`document-blueprint`)
- `get-document-blueprint` — Get a document blueprint
- `create-document-blueprint` — Create a new document blueprint
- `update-document-blueprint` — Update a document blueprint
- `delete-document-blueprint` — Delete a document blueprint
- `move-document-blueprint` — Move a document blueprint
- `get-document-blueprint-by-id-array` — Get document blueprints by IDs
- `get-document-blueprint-scaffold` — Get scaffold for creating a blueprint
- `create-document-blueprint-from-document` — Create a blueprint from an existing document
- `get-document-blueprint-ancestors` — Get blueprint ancestors
- `get-document-blueprint-children` — Get blueprint children
- `get-document-blueprint-root` — Get root blueprints
- `create-document-blueprint-folder` — Create a blueprint folder
- `get-document-blueprint-folder` — Get blueprint folder information
- `update-document-blueprint-folder` — Update a blueprint folder
- `delete-document-blueprint-folder` — Delete a blueprint folder

## Document Version (`document-version`)
- `get-document-version` — Get document versions with pagination
- `get-document-version-by-id` — Get a specific document version by ID
- `update-document-version-prevent-cleanup` — Prevent or allow cleanup of a document version
- `create-document-version-rollback` — Roll back a document to a specific version

## Document Type (`document-type`)
- `get-document-type` — Get a document type
- `get-document-type-configuration` — Get document type configuration
- `get-document-type-blueprint` — Get document type blueprint
- `get-document-types-by-id-array` — Get document types by IDs
- `get-document-type-available-compositions` — Get available compositions
- `get-document-type-composition-references` — Get composition references
- `update-document-type` — Update a document type
- `copy-document-type` — Copy a document type
- `move-document-type` — Move a document type
- `create-document-type` — Create a new document type
- `delete-document-type` — Delete a document type
- `create-element-type` — Create an element type
- `get-icons` — Get available icons
- `get-document-type-allowed-children` — Get allowed child types
- `get-all-document-types` — Get all document types
- `create-document-type-folder` — Create a folder
- `delete-document-type-folder` — Delete a folder
- `get-document-type-folder` — Get folder info
- `update-document-type-folder` — Update folder details
- `get-document-type-root` — Get root document types
- `get-document-type-ancestors` — Get document type ancestors
- `get-document-type-children` — Get document type children

## Health (`health`)
- `get-health-check-groups` — Get all health check groups
- `get-health-check-group-by-name` — Get health check group by name
- `run-health-check-group` — Run health checks for a specific group
- `execute-health-check-action` — Execute a health check action

## Imaging (`imaging`)
- `get-imaging-resize-urls` — Generate image resize URLs with various processing options

## Indexer (`indexer`)
- `get-indexer` — Get all indexers
- `get-indexer-by-index-name` — Get indexer by index name
- `post-indexer-by-index-name-rebuild` — Rebuild an index by name

## Language (`language`)
- `get-language-items` — Get all languages
- `get-default-language` — Get default language
- `create-language` — Create a new language
- `update-language` — Update a language
- `delete-language` — Delete a language
- `get-language-by-iso-code` — Get language by ISO code

## Log Viewer (`log-viewer`)
- `get-log-viewer-saved-search-by-name` — Get saved search by name
- `get-log-viewer-level-count` — Get log level counts
- `post-log-viewer-saved-search` — Save a log search
- `delete-log-viewer-saved-search-by-name` — Delete saved search
- `get-log-viewer` — Get logs
- `get-log-viewer-level` — Get log levels
- `get-log-viewer-search` — Search logs
- `get-log-viewer-validate-logs` — Validate logs
- `get-log-viewer-message-template` — Get message template

## Manifest (`manifest`)
- `get-manifest-manifest` — Get all system manifests
- `get-manifest-manifest-private` — Get private manifests
- `get-manifest-manifest-public` — Get public manifests

## Media (`media`)
- `get-media-by-id` — Get media by ID
- `get-media-ancestors` — Get media ancestors
- `get-media-children` — Get media children
- `get-media-root` — Get root media items
- `create-media` — Create new media
- `create-media-multiple` — Create multiple media items
- `delete-media` — Delete media
- `update-media` — Update media
- `get-media-configuration` — Get media configuration
- `get-media-urls` — Get media URLs
- `validate-media` — Validate media
- `sort-media` — Sort media items
- `get-media-by-id-array` — Get media by IDs
- `move-media` — Move media
- `get-media-audit-log` — Get media audit log
- `get-media-recycle-bin-root` — Get recycle bin root
- `get-media-recycle-bin-children` — Get recycle bin children
- `empty-recycle-bin` — Empty recycle bin
- `restore-media-from-recycle-bin` — Restore from recycle bin
- `move-media-to-recycle-bin` — Move to recycle bin
- `delete-from-recycle-bin` — Delete from recycle bin
- `get-media-are-referenced` — Check if media items are referenced
- `get-media-by-id-referenced-by` — Get media items referencing this media
- `get-media-by-id-referenced-descendants` — Get referenced descendants of media
- `get-collection-media` — Get media collection
- `get-recycle-bin-media-referenced-by` — Get media items referencing recycled media
- `get-recycle-bin-media-original-parent` — Get original parent of recycled media

## Media Type (`media-type`)
- `get-media-type-folder` — Get folder information
- `create-media-type-folder` — Create a new folder
- `delete-media-type-folder` — Delete a folder
- `update-media-type-folder` — Update folder details
- `create-media-type` — Create a new media type
- `copy-media-type` — Copy a media type
- `get-media-type-available-compositions` — Get available compositions
- `update-media-type` — Update a media type
- `move-media-type` — Move a media type
- `delete-media-type` — Delete a media type
- `get-media-type-root` — Get root media types
- `get-media-type-children` — Get child media types
- `get-media-type-ancestors` — Get ancestor media types
- `get-media-type-folders` — Get media type folders
- `get-media-type-by-id` — Get media type by ID
- `get-media-type-by-ids` — Get media types by IDs
- `get-media-type-configuration` — Get media type configuration
- `get-allowed-media-type` — Get allowed media types
- `get-media-type-allowed-at-root` — Get types allowed at root
- `get-media-type-allowed-children` — Get allowed child types
- `get-media-type-composition-references` — Get composition references  

## Member (`member`)
- `get-member` — Get member by ID
- `create-member` — Create a new member
- `validate-member` — Validate member creation data
- `delete-member` — Delete a member
- `update-member` — Update a member
- `validate-member-update` — Validate member update data
- `get-member-are-referenced` — Check if members are referenced
- `get-member-by-id-referenced-by` — Get items referencing this member
- `get-member-by-id-referenced-descendants` — Get referenced descendants of member
- `find-member` — Find members  

## Member Group (`member-group`)
- `get-member-group` — Get member group  
- `get-member-group-by-id-array` — Get member groups by IDs  
- `create-member-group` — Create a new member group  
- `update-member-group` — Update a member group  
- `delete-member-group` — Delete a member group  
- `get-member-group-root` — Get root member groups  

## Member Type (`member-type`)
- `get-member-type-by-id` — Get member type by ID
- `create-member-type` — Create a new member type
- `get-member-types-by-id-array` — Get member types by IDs  
- `delete-member-type` — Delete a member type  
- `update-member-type` — Update a member type  
- `copy-member-type` — Copy a member type  
- `get-member-type-available-compositions` — Get available compositions  
- `get-member-type-composition-references` — Get composition references  
- `get-member-type-configuration` — Get member type configuration  
- `get-member-type-root` — Get root member types  

## Models Builder (`models-builder`)
- `get-models-builder-dashboard` — Get Models Builder dashboard information  
- `get-models-builder-status` — Get Models Builder status  
- `post-models-builder-build` — Trigger Models Builder code generation  

## Partial View (`partial-view`)
- `get-partial-view-by-path` — Get partial view by path  
- `get-partial-view-folder-by-path` — Get partial view folder by path  
- `get-partial-view-snippet-by-id` — Get partial view snippet by ID  
- `get-partial-view-snippet` — Get partial view snippet  
- `create-partial-view` — Create a new partial view  
- `create-partial-view-folder` — Create a partial view folder  
- `update-partial-view` — Update a partial view  
- `rename-partial-view` — Rename a partial view  
- `delete-partial-view` — Delete a partial view  
- `delete-partial-view-folder` — Delete a partial view folder  
- `get-partial-view-root` — Get root partial views  
- `get-partial-view-children` — Get child partial views  
- `get-partial-view-ancestors` — Get partial view ancestors  
- `get-partial-view-search` — Search partial views  

## Property Type (`property-type`)
- `get-property-type-is-used` — Check if a property type is in use  

## Redirect (`redirect`)
- `get-all-redirects` — Get all redirects  
- `get-redirect-by-id` — Get redirect by ID  
- `delete-redirect` — Delete a redirect  
- `get-redirect-status` — Get redirect status  
- `update-redirect-status` — Update redirect status  

## Relation (`relation`)
- `get-relation-by-relation-type-id` — Get relations by relation type ID  

## Relation Type (`relation-type`)
- `get-relation-type` — Get all relation types  
- `get-relation-type-by-id` — Get relation type by ID  

## Script (`script`)
- `get-script-by-path` — Get script by path  
- `get-script-folder-by-path` — Get script folder by path  
- `get-script-items` — Get script items  
- `create-script` — Create a new script  
- `create-script-folder` — Create a script folder  
- `update-script` — Update a script  
- `rename-script` — Rename a script  
- `delete-script` — Delete a script  
- `delete-script-folder` — Delete a script folder  
- `get-script-tree-root` — Get root script items  
- `get-script-tree-children` — Get child script items  
- `get-script-tree-ancestors` — Get script ancestors  

## Searcher (`searcher`)
- `get-searcher` — Get all searchers  
- `get-searcher-by-searcher-name-query` — Query a specific searcher by name  

## Server (`server`)
- `get-server-status` — Get server status
- `get-server-configuration` — Get server configuration
- `get-server-information` — Get server information
- `get-server-troubleshooting` — Get server troubleshooting data
- `get-server-upgrade-check` — Check for server upgrades  

## Static File (`static-file`)
- `get-static-files` — Get static files with filtering  
- `get-static-file-root` — Get root static files  
- `get-static-file-children` — Get child static files  
- `get-static-file-ancestors` — Get static file ancestors  

## Stylesheet (`stylesheet`)
- `get-stylesheet-by-path` — Get stylesheet by path  
- `get-stylesheet-folder-by-path` — Get stylesheet folder by path  
- `create-stylesheet` — Create a new stylesheet  
- `create-stylesheet-folder` — Create a stylesheet folder  
- `update-stylesheet` — Update a stylesheet  
- `rename-stylesheet` — Rename a stylesheet  
- `delete-stylesheet` — Delete a stylesheet  
- `delete-stylesheet-folder` — Delete a stylesheet folder  
- `get-stylesheet-root` — Get root stylesheets  
- `get-stylesheet-children` — Get child stylesheets  
- `get-stylesheet-ancestors` — Get stylesheet ancestors  
- `get-stylesheet-search` — Search stylesheets  

## Tag (`tag`)
- `get-tags` — Get all tags  

## Template (`template`)
- `get-template` — Get a template by ID
- `get-template-configuration` — Get template configuration
- `get-templates-by-id-array` — Get templates by IDs
- `create-template` — Create a new template
- `update-template` — Update a template by ID
- `delete-template` — Delete a template by ID
- `execute-template-query` — Execute template queries and return generated LINQ code
- `get-template-query-settings` — Get schema for template queries (document types, properties, operators)
- `get-template-ancestors` — Get ancestors of a template by ID
- `get-template-children` — Get child templates or template folders by parent ID
- `get-template-root` — Get root template items
- `get-template-search` — Search for templates by name  

## Temporary File (`temporary-file`)
- `create-temporary-file` — Create a temporary file  
- `get-temporary-file` — Get a temporary file  
- `delete-temporary-file` — Delete a temporary file  
- `get-temporary-file-configuration` — Get temporary file configuration  

## User (`user`)
- `get-user` — Get users with pagination  
- `get-user-by-id` — Get user by ID  
- `find-user` — Find users by search criteria  
- `get-item-user` — Get user item information  
- `get-user-current` — Get current authenticated user  
- `get-user-configuration` — Get user configuration  
- `get-user-current-configuration` — Get current user configuration  
- `get-user-current-login-providers` — Get current user login providers  
- `get-user-current-permissions` — Get current user permissions  
- `get-user-current-permissions-document` — Get current user document permissions  
- `get-user-current-permissions-media` — Get current user media permissions  
- `get-user-by-id-calculate-start-nodes` — Calculate start nodes for a user  
- `upload-user-avatar-by-id` — Upload avatar for a user  
- `upload-user-current-avatar` — Upload avatar for current user  
- `delete-user-avatar-by-id` — Delete user avatar  

## User Data (`user-data`)
- `create-user-data` — Create user data key-value pair  
- `update-user-data` — Update user data value  
- `get-user-data` — Get all user data for current user  
- `get-user-data-by-id` — Get user data by key  

## User Group (`user-group`)
- `get-user-group` — Get user group  
- `get-user-group-by-id-array` — Get user groups by IDs  
- `get-user-groups` — Get all user groups  
- `get-filter-user-group` — Filter user groups  
- `create-user-group` — Create a new user group  
- `update-user-group` — Update a user group  
- `delete-user-group` — Delete a user group  
- `delete-user-groups` — Delete multiple user groups  

## Webhook (`webhook`)
- `get-webhook-by-id` — Get webhook by ID  
- `get-webhook-by-id-array` — Get webhooks by IDs  
- `delete-webhook` — Delete a webhook  
- `update-webhook` — Update a webhook  
- `get-webhook-events` — Get webhook events  
- `get-all-webhook-logs` — Get all webhook logs  
- `create-webhook` — Create a new webhook  


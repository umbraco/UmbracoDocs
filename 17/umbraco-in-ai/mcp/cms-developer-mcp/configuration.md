---
description: Configuration options for the Developer MCP server
---

# Configuration Options

The Developer MCP Server uses the same configuration fields as any Umbraco MCP server built on the Base MCP SDK. For authentication, environment variables, CLI arguments, precedence rules, and all built-in fields, see the [SDK Configuration reference](../base-mcp/sdk/configuration.md).

For a complete reference of CLI flags, runtime modes (readonly and dry-run), introspection commands, and input sanitization, see the [CLI Reference](../base-mcp//sdk/cli.md).

This page lists the specific tool modes and slices that the Developer MCP ships with.

## Tool Filtering

The Developer MCP Server uses the SDK [tool filtering system](../base-mcp/sdk/tool-filtering.md) to control which tools are registered. Filtering is built around three concepts: **modes**, **collections**, and **slices**. See the SDK documentation for how these compose and the available configuration keys.

### Available Modes

The Developer MCP ships with the following modes:

| Mode               | Collections                                                       | Description                                        |
| ------------------ | ----------------------------------------------------------------- | -------------------------------------------------- |
| `content`          | `document`, `document-version`, `document-blueprint`, `tag`       | Content editing, versioning, blueprints, and tags. |
| `content-modeling` | `document-type`, `data-type`, `media-type`                        | Document and media type definitions.               |
| `front-end`        | `template`, `partial-view`, `stylesheet`, `script`, `static-file` | Templates, views, and assets.                      |
| `media`            | `media`, `imaging`, `temporary-file`                              | Media library and file uploads.                    |
| `search`           | `indexer`, `searcher`                                             | Examine indexes and search.                        |
| `users`            | `user`, `user-group`, `user-data`                                 | Back office user management.                       |
| `members`          | `member`, `member-type`, `member-group`                           | Front-end member management.                       |
| `health`           | `health`, `log-viewer`                                            | Health checks and diagnostics.                     |
| `translation`      | `culture`, `language`, `dictionary`                               | Localization and translations.                     |
| `system`           | `server`, `manifest`, `models-builder`                            | Server info and code generation.                   |
| `integrations`     | `webhook`, `redirect`, `relation`, `relation-type`                | External integrations.                             |

### Available Slices

The Developer MCP ships with the following slices:

| Slice           | Description                                                                              |
| --------------- | ---------------------------------------------------------------------------------------- |
| `create`        | Create entities.                                                                         |
| `read`          | Get single or batch items by ID.                                                         |
| `update`        | Update entities.                                                                         |
| `delete`        | Delete entities.                                                                         |
| `tree`          | Tree navigation (root, children, ancestors, siblings).                                   |
| `folders`       | Folder-specific operations.                                                              |
| `search`        | Search and filter operations.                                                            |
| `list`          | List all items.                                                                          |
| `references`    | Reference and dependency queries.                                                        |
| `publish`       | Publishing and unpublishing.                                                             |
| `move`          | Move operations.                                                                         |
| `copy`          | Copy operations.                                                                         |
| `sort`          | Sort and reorder operations.                                                             |
| `validate`      | Validation operations.                                                                   |
| `rename`        | Rename file-based entities.                                                              |
| `configuration` | Configuration retrieval.                                                                 |
| `audit`         | Audit trail access.                                                                      |
| `urls`          | URL and domain management.                                                               |
| `domains`       | Domain configuration.                                                                    |
| `permissions`   | User permission queries.                                                                 |
| `user-status`   | User account operations (enable, disable, unlock).                                       |
| `current-user`  | Current user context.                                                                    |
| `notifications` | Content notification settings.                                                           |
| `public-access` | Content protection rules.                                                                |
| `scaffolding`   | Content creation helpers.                                                                |
| `blueprints`    | Blueprint specialized operations.                                                        |
| `server-info`   | Server status and information.                                                           |
| `diagnostics`   | Health checks, log viewer, indexer operations.                                           |
| `templates`     | Template and snippet helpers.                                                            |
| `recycle-bin`   | Recycle bin operations (combine with `delete`, `move`, `read`, `references`, or `tree`). |

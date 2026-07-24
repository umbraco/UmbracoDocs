---
description: Configuration options for the Editor MCP server
---

# Configuration Options

The Editor MCP Server uses the same configuration fields as any Umbraco MCP server built on the Base MCP SDK. For environment variables, CLI arguments, precedence rules, and all built-in fields, see the [SDK Configuration reference](../base-mcp/sdk/configuration.md).

This page lists the specific tool modes and slices that the Editor MCP ships with.

## Tool Filtering

The Editor MCP Server uses the SDK [tool filtering system](../base-mcp/sdk/tool-filtering.md) to control which tools are registered. Filtering is built around three concepts: **modes**, **collections**, and **slices**. See the SDK documentation for how these compose and the available configuration keys.

### Available Modes

The Editor MCP ships with the following modes:

| Mode              | Collections                                      | Description                                          |
| ----------------- | ------------------------------------------------ | ---------------------------------------------------- |
| `content`         | `content`, `publishing`, `versioning`            | Content editing, publishing, and version history.    |
| `media`           | `media`, `media-management`                      | Browse, upload, and organize media.                  |
| `blueprints`      | `blueprint`                                      | Page blueprints and templates.                       |
| `translation`     | `language`, `translation`, `dictionary`           | Multi-language content and dictionary management.    |
| `tags`            | `tag`                                            | Tag browsing and filtering.                          |
| `content-health`  | `content-health`, `content-reporting`            | Content quality auditing and lifecycle reporting.    |
| `site-structure`  | `site-structure`                                 | Site architecture analysis.                          |
| `relationships`   | `relationships`                                  | Inbound references, outbound links, and relationship mapping. |
| `media-health`    | `media-health`                                   | Media library health analysis.                       |
| `bulk-operations` | `bulk-operations`                                | Batch content operations (max 10 pages per call).    |
| `members`         | `member`, `member-group`, `member-reporting`     | Member management and reporting.                     |
| `scheduling`      | `scheduling`                                     | Scheduled content publishing.                        |
| `redirects`       | `redirect`                                       | URL redirect management.                             |

### Available Slices

The Editor MCP ships with the following slices:

| Slice      | Description                                               |
| ---------- | --------------------------------------------------------- |
| `create`   | Create entities.                                          |
| `read`     | Get single items by ID, audit, and report tools.          |
| `update`   | Update entities.                                          |
| `delete`   | Delete entities.                                          |
| `list`     | List and browse operations.                               |
| `search`   | Search and filter operations.                             |
| `tree`     | Tree navigation (children, hierarchy).                    |
| `publish`  | Publishing, unpublishing, and scheduling.                 |
| `version`  | Version history and rollback operations.                  |
| `move`     | Move operations.                                          |

### Example Configurations

#### Content editing only

Enable content management, publishing, and version history:

```
UMBRACO_TOOL_MODES=content
```

#### Content and media

Enable content and media management together:

```
UMBRACO_TOOL_MODES=content,media
```

#### Read-only mode

Allow browsing and reporting without any write operations:

```
UMBRACO_READONLY=true
```

#### Content health auditing

Enable only reporting and auditing tools:

```
UMBRACO_TOOL_MODES=content-health,site-structure,media-health
```

#### Exclude destructive operations

Enable content management but block delete operations:

```
UMBRACO_TOOL_MODES=content,media
UMBRACO_EXCLUDE_SLICES=delete
```

#### Translation workflow

Enable translation tools alongside content browsing:

```
UMBRACO_TOOL_MODES=content,translation
```

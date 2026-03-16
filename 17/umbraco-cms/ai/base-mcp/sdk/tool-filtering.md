---
description: Tool filtering system for controlling which MCP tools are registered based on modes, slices, collections, and individual tool rules.
---

# Tool Filtering

The SDK provides a layered filtering system that controls which tools are registered when the MCP server starts. Filters compose together so you can express broad or fine-grained tool selection.

## Concepts

| Concept | Description |
|---|---|
| **Mode** | A named group of collections (for example, `content` includes `document`, `document-version`, `document-blueprint`, `tag`) |
| **Collection** | A set of related tools that maps to an OpenAPI group, with metadata and dependencies (for example, `data-type`) |
| **Slice** | A vertical operation category that cuts across collections (for example, `create`, `read`, `delete`). Collections group tools horizontally by domain; slices group them vertically by operation type |
| **Tool** | An individual MCP tool with a unique name |

## Read-Only Mode

When read-only mode is enabled (`UMBRACO_READONLY=true`), only tools with the `readOnlyHint` annotation are registered. This overrides all other filtering. Modes, slices, collections, and tool-level rules still apply. Any tool not marked as read-only is excluded regardless of other settings.

## How Filters Compose

Filtering applies in four layers, evaluated in order:

1. **ReadOnly mode** - when enabled, only tools with `readOnlyHint` annotation pass. Overrides all other layers.
2. **Tool-level** - explicit include/exclude by tool name. If includes are specified, only those tools pass.
3. **Slice-level** - include/exclude by operation type. If includes are specified, tools must have a matching slice.
4. **Collection-level** - include/exclude by collection name. Modes are expanded to collections before this layer.

{% hint style="info" %}
Tool-level includes take highest precedence. If `enabledTools` is specified, the tool must be in that list regardless of slice or collection settings.
{% endhint %}

## Modes

Modes provide a semantic shorthand for groups of collections. When you set `UMBRACO_TOOL_MODES=content`, the mode expander resolves it to the collections defined in your mode registry.

Your project includes a mode registry at `src/config/mode-registry.ts`. The [discover phase](../create-umbraco-mcp-server/development-workflow.md#collections-modes-and-slices) generates initial mode definitions based on your API groups. Customize these to match your use cases:

```typescript
import type { ToolModeDefinition } from "@umbraco-cms/mcp-server-sdk";

export const modeRegistry: ToolModeDefinition[] = [
  {
    name: "content",
    displayName: "Content",
    description: "Content editing, versioning, blueprints, and tags",
    collections: ["document", "document-version", "document-blueprint", "tag"],
  },
  {
    name: "media",
    displayName: "Media",
    description: "Media library and file uploads",
    collections: ["media", "imaging", "temporary-file"],
  },
];
```

Combine or split modes based on your target use cases. For example, a commerce package might define `commerce-admin` and `commerce-catalog` modes rather than a single `commerce` mode.

## Slices

The SDK defines a minimal set of base slice names: `create`, `read`, `update`, `delete`, and `list`. Extend these in your project's slice registry at `src/config/slice-registry.ts` with domain-specific slices:

```typescript
import { baseSliceNames } from "@umbraco-cms/mcp-server-sdk";

export const toolSliceNames = [
  ...baseSliceNames,
  'publish', 'recycle-bin', 'move', 'copy', 'sort',
  'search', 'tree', 'folders', 'references',
] as const;
```

Each tool declares which slices it belongs to via its `slices` property. A tool with an empty `slices` array is always included regardless of slice filtering.

## Runtime Configuration

Configure filtering at runtime using the environment variables and CLI flags listed in [Configuration](./configuration.md). All list values are comma-separated. For example:

```bash
UMBRACO_TOOL_MODES="content,media"
UMBRACO_INCLUDE_SLICES="read,tree,search"
UMBRACO_EXCLUDE_TOOLS="document-delete,media-delete"
```

By default, all collections, slices, and tools are included. Filtering only takes effect when you explicitly set include or exclude values.

---
description: Configuration options for the Developer MCP server
---

# Configuration Options

The Developer MCP Server can be configured in multiple ways to manage authentication, tool access, and security settings. These settings control how the server connects to Umbraco and how it operates within your development environment. Configuration can be applied using configuration keys, environment variables, or CLI arguments, depending on your workflow.

## Configuration Keys

### Authentication Configuration Keys

| Key | Description |
| --- | --- |
| `UMBRACO_CLIENT_ID` | The username of the Umbraco API user. |
| `UMBRACO_CLIENT_SECRET` | The client secret for the Umbraco API user. |
| `UMBRACO_BASE_URL` | The base URL of your Umbraco instance (for example, `https://localhost:44391`). |
| `NODE_TLS_REJECT_UNAUTHORIZED` | Set to `0` to disable TLS certificate validation when connecting to HTTP URLs or self-signed certificates. |

{% hint style="warning" %}
If you are connecting to the secure endpoint of Umbraco locally then always set the `NODE_TLS_REJECT_UNAUTHORIZED` to `0`.
{% endhint %}

### Tool Mode Configuration

| Key | Description |
| --- | --- |
| `UMBRACO_TOOL_MODES` | Specifies semantic tool modes to enable. Modes bundle related collections together for easier configuration. For example, `content`, `media`, or `translation`. |

### Tool and Tool Collection Configuration

| Key | Description |
| --- | --- |
| `UMBRACO_EXCLUDE_TOOLS` | Specifies tool names to exclude from the usable tools list. Useful when certain agents cannot handle a large number of tools. |
| `UMBRACO_INCLUDE_TOOLS` | Specifies tool names to include in the usable tools list. When defined, only these tools will be available. |
| `UMBRACO_INCLUDE_TOOL_COLLECTIONS` | Specifies collections by name to include. Only tools from these collections will be available. |
| `UMBRACO_EXCLUDE_TOOL_COLLECTIONS` | Specifies collections by name to exclude from the usable tools list. |

### Tool Slice Configuration

| Key | Description |
| --- | --- |
| `UMBRACO_INCLUDE_SLICES` | Specifies operation types to include. For example, `read,tree,search` for read-only browsing. |
| `UMBRACO_EXCLUDE_SLICES` | Specifies operation types to exclude. For example, `delete,recycle-bin` to prevent destructive operations. |

{% hint style="info" %}
Use these keys to fine-tune which tools or tool collections are exposed to your LLM. This improves performance and clarity in your conversations.
{% endhint %}

## Tool Modes

Tool modes provide a higher-level abstraction over collection filtering. Instead of specifying individual collections, you can use semantic modes that bundle related collections together.

### Why Use Modes?

- **Simpler configuration**: One mode name instead of listing multiple collections.
- **Semantic clarity**: Express intent ("I want content editing tools") rather than technical details.
- **Reduced errors**: No need to remember exact collection names.

### Base Modes

Base modes map directly to specific tool collections:

| Mode | Collections | Description |
| --- | --- | --- |
| `content` | document, document-version, document-blueprint, tag | Content editing, versioning, blueprints, and tags. |
| `content-modeling` | document-type, data-type, media-type | Document and media type definitions. |
| `front-end` | template, partial-view, stylesheet, script, static-file | Templates, views, and assets. |
| `media` | media, imaging, temporary-file | Media library and file uploads. |
| `search` | indexer, searcher | Examine indexes and search. |
| `users` | user, user-group, user-data | Back office user management. |
| `members` | member, member-type, member-group | Front-end member management. |
| `health` | health, log-viewer | Health checks and diagnostics. |
| `translation` | culture, language, dictionary | Localization and translations. |
| `system` | server, manifest, models-builder | Server info and code generation. |
| `integrations` | webhook, redirect, relation, relation-type | External integrations. |

### Mode Usage Examples

**Single mode:**

```bash
# Content publisher - document and media tools
UMBRACO_TOOL_MODES="content"
```

**Multiple modes:**

```bash
# Content editing with translation support
UMBRACO_TOOL_MODES="content,media,translation"
```

**Mode with exclusions:**

```bash
# Content mode but exclude version history
UMBRACO_TOOL_MODES="content"
UMBRACO_EXCLUDE_TOOL_COLLECTIONS="document-version"
```

**Mode with additional collections:**

```bash
# Front-end development plus webhooks
UMBRACO_TOOL_MODES="front-end"
UMBRACO_INCLUDE_TOOL_COLLECTIONS="webhook"
```

## Tool Slices

Tool slices provide fine-grained control over which tools are registered based on their **operation type**. Slices work alongside mode and collection filtering to enable precise tool selection.

### Why Use Slices?

- **Operation-based filtering**: Include only certain types of operations (for example, read-only browsing).
- **Safety controls**: Exclude destructive operations like `delete` or `recycle-bin`.
- **Task-specific toolsets**: Enable only the operations needed for a specific workflow.

### Available Slices

#### Core CRUD Operations

| Slice | Description |
| --- | --- |
| `create` | Create entities. |
| `read` | Get single or batch items by ID. |
| `update` | Update entities. |
| `delete` | Delete entities. |

#### Tree Navigation

| Slice | Description |
| --- | --- |
| `tree` | All tree navigation (root, children, ancestors, siblings). |
| `folders` | Folder-specific operations. |

#### Query Operations

| Slice | Description |
| --- | --- |
| `search` | Search and filter operations. |
| `list` | List all items. |
| `references` | Reference and dependency queries. |

#### Workflow Operations

| Slice | Description |
| --- | --- |
| `publish` | Publishing and unpublishing. |
| `move` | Move operations. |
| `copy` | Copy operations. |
| `sort` | Sort and reorder operations. |
| `validate` | Validation operations. |
| `rename` | Rename file-based entities. |

#### Information Operations

| Slice | Description |
| --- | --- |
| `configuration` | Configuration retrieval. |
| `audit` | Audit trail access. |
| `urls` | URL and domain management. |
| `domains` | Domain configuration. |
| `permissions` | User permission queries. |
| `user-status` | User account operations (enable, disable, unlock). |
| `current-user` | Current user context. |

#### Entity Management

| Slice | Description |
| --- | --- |
| `notifications` | Content notification settings. |
| `public-access` | Content protection rules. |
| `scaffolding` | Content creation helpers. |
| `blueprints` | Blueprint specialized operations. |

#### System Operations

| Slice | Description |
| --- | --- |
| `server-info` | Server status and information. |
| `diagnostics` | Health checks, log viewer, indexer operations. |
| `templates` | Template and snippet helpers. |

#### Composite Slices

Tools can have multiple slices assigned to allow fine-grained filtering. For example, to include folder creation but exclude folder deletion, you can combine slices.

**Folder operations:**

| Slices | Description |
| --- | --- |
| `create` + `folders` | Folder creation. |
| `read` + `folders` | Folder reading. |
| `update` + `folders` | Folder updating. |
| `delete` + `folders` | Folder deletion. |
| `list` + `folders` | List folders. |

**Recycle bin operations:**

| Slices | Description |
| --- | --- |
| `delete` + `recycle-bin` | Delete from or empty recycle bin. |
| `move` + `recycle-bin` | Move to or restore from recycle bin. |
| `read` + `recycle-bin` | Read recycle bin info (original parent). |
| `references` + `recycle-bin` | Get references for recycled items. |
| `tree` + `recycle-bin` | Navigate recycle bin (root, children, siblings). |


### Slice Usage Examples

**Read-only content browsing:**

```bash
UMBRACO_TOOL_MODES="content"
UMBRACO_INCLUDE_SLICES="read,tree,search"
```

**Content publishers (no system tools):**

```bash
UMBRACO_INCLUDE_SLICES="create,read,update,tree,search,publish"
```

**Admin operations only:**

```bash
UMBRACO_INCLUDE_SLICES="configuration,audit,user-status,diagnostics"
```

{% hint style="info" %}
When `UMBRACO_INCLUDE_SLICES` is set, only tools matching those slices are registered. When `UMBRACO_EXCLUDE_SLICES` is set, matching tools are excluded regardless of other settings.
{% endhint %}

## Filtering Precedence

The filtering system applies in the following order:

1. **Mode expansion**: Tool modes are expanded to their constituent collections.
2. **Collection merging**: Mode collections are merged with explicit `UMBRACO_INCLUDE_TOOL_COLLECTIONS`.
3. **Collection exclusion**: `UMBRACO_EXCLUDE_TOOL_COLLECTIONS` is applied.
4. **Dependency resolution**: Required collections are automatically included.
5. **User permissions**: Tools are filtered by Umbraco API user permissions.
6. **Slice filtering**: Tools are filtered by operation type (slices).
7. **Tool-level filtering**: Individual tools can be included or excluded.

### Default Behavior

- If no filtering is specified, all collections and tools are loaded.
- Collection dependencies are always resolved automatically.
- User permissions are always enforced.

### Include vs Exclude

- **Include mode**: Only specified collections/tools are loaded (via modes or explicit includes).
- **Exclude mode**: All collections/tools are loaded except those specified.
- Tool-level include/exclude can override collection-level decisions.
- Modes and explicit collection includes are merged (union).

## Working with Tool Collections

When configuring tools for the Developer MCP Server, you can fine-tune which tools and collections are available by using comma-separated values.

- **Comma-delimited configuration**

Tools and tool collections are specified using a comma-separated list.
For example:

```bash
UMBRACO_INCLUDE_TOOL_COLLECTIONS="document,document-type,data-type"
```

- **Combining tool configurations**

You can combine configuration options to include entire tool collections while excluding specific tools.
For example, you might enable the document and media collections, but exclude a single tool within them.

```bash
UMBRACO_INCLUDE_TOOL_COLLECTIONS="document,media"
UMBRACO_EXCLUDE_TOOLS="document-move,media-delete"
```

## Security Configuration Keys

| Key | Description |
| --- | --- |
| `UMBRACO_READONLY` | *(Optional, security feature)* <br> Enables readonly mode to prevent any modifications to your Umbraco CMS. When enabled, all create, update, delete, and publish tools are disabled while query and retrieval tools remain available. This is useful for safely exploring content or connecting to production environments. <br><br> Default: `false` <br><br> Example: <br> `UMBRACO_READONLY="true"` <br><br> CLI: `--umbraco-readonly` |
| `UMBRACO_ALLOWED_MEDIA_PATHS` | *(Optional, security feature)* <br> Defines a comma-separated list of absolute directory paths allowed for media uploads using the `filePath` source type. This prevents unauthorized file system access by restricting uploads to specific, trusted directories. <br><br> Required for: Local file path uploads <br> Default: If not configured, all `filePath` uploads are rejected with an error. <br><br> Example: <br> `UMBRACO_ALLOWED_MEDIA_PATHS="/tmp/uploads,/var/media,/home/user/assets"` |

{% hint style="info" %}
URL-based and base64 media uploads work without this configuration.
{% endhint %}

## Environment Configuration Options

The Umbraco Developer MCP Server supports configuration through multiple methods, allowing flexibility across different environments and workflows:

1. Environment variables defined in the MCP client configuration (for example, Claude Desktop, Visual Studio Code, Cursor).
2. A local `.env` file for development.
3. CLI arguments when running the MCP Server directly . 

Configuration precedence:

`CLI arguments` → `Environment variables` → `.env` file  

### Using a `.env` File (Recommended for Development)

For local development, create a `.env` file in your project root directory and set your connection details:

```bash
# Example .env configuration
UMBRACO_CLIENT_ID=your-api-user-id
UMBRACO_CLIENT_SECRET=your-api-secret
UMBRACO_BASE_URL=http://localhost:56472
UMBRACO_INCLUDE_TOOL_COLLECTIONS=document,media,document-type,data-type
```

{% hint style="info" %}
The `.env` file is included in `.gitignore` by default to prevent sensitive credentials from being committed to source control.
{% endhint %}

### Using CLI Arguments

You can also provide configuration values directly via CLI arguments, which override any `.env` or environment variable settings:

```bash
npx @umbraco-cms/mcp-dev@17.1 \
  --umbraco-client-id="your-id" \
  --umbraco-client-secret="your-secret" \
  --umbraco-base-url="http://localhost:56472" \
  --env="/path/to/custom/.env"
```

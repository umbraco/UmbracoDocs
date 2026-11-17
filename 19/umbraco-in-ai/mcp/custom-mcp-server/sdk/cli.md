---
description: >-
  Use any Umbraco MCP server as a CLI tool for direct invocation,
  debugging, and introspection.
---

# CLI Reference

The SDK includes a CLI wrapper that turns any Umbraco MCP server into a command-line tool. This is an alternative way to interact with the same server. Instead of connecting through an MCP client, you run the server directly. CLI flags let you list tools, call tools, inspect configuration, and control runtime behavior.

Both approaches use the same server and the same tools. Use the MCP connection when your AI host supports it. Use the CLI when you need direct invocation, scripting, or debugging.

## Claude Code Skills

Each Umbraco MCP server ships with its own Claude Code plugin that provides a skill. The skill guides the agent interactively through setup, configuration, filtering, and debugging. This is the recommended way to work with the CLI.

Check the documentation for your specific MCP server for plugin install instructions.

The sections below provide the full reference for all CLI options. You do not need to read them when using the skill.

{% hint style="info" %}
The CLI is designed to be consumed by AI agents, not operated directly by humans. You configure the CLI with environment variables and flags, then your AI agent connects and interacts with and understands about Umbraco through the exposed tools.
{% endhint %}

## Authentication

The CLI connects to Umbraco the same way as the MCP server, using an API user. Credentials (`UMBRACO_CLIENT_ID`, `UMBRACO_CLIENT_SECRET`, and `UMBRACO_BASE_URL`) must always be set as environment variables via a `.env`. They are never passed as CLI arguments.

All other options can be set using CLI flags. The AI agent passes these as needed. For the full list of configuration fields, see [Configuration](configuration.md).

## Starting the Server

The examples on this page use the Developer MCP Server (`@umbraco-cms/mcp-dev`) package. Replace the package name with your own MCP server package.

```bash
# With a .env file in the current directory (recommended):
npx @umbraco-cms/mcp-dev

# With a custom .env path:
npx @umbraco-cms/mcp-dev --env /path/to/.env
```

## Tool Filtering

The agent can control which tools are exposed to the LLM using modes, collections, slices, and individual tool names. All filters accept comma-separated values via CLI flags or environment variables.

```bash
# Read-only content browsing
UMBRACO_INCLUDE_SLICES=read,list,search \
UMBRACO_INCLUDE_TOOL_COLLECTIONS=content,media \
npx @umbraco-cms/mcp-dev

# Everything except delete operations
UMBRACO_EXCLUDE_SLICES=delete npx @umbraco-cms/mcp-dev

# Only specific tools
UMBRACO_INCLUDE_TOOLS=get-content-by-id,list-content npx @umbraco-cms/mcp-dev
```

For the full list of filter flags, available slices, and precedence rules, see [Tool Filtering](tool-filtering.md).

## Runtime Modes

### Readonly Mode

```bash
npx @umbraco-cms/mcp-dev --umbraco-readonly
# or: UMBRACO_READONLY=true
```

Mutation tools are removed from the server. The agent cannot see or call them. Only tools with `readOnlyHint: true` are registered. Use this mode when you want zero risk of data modification.

### Dry-Run Mode

```bash
npx @umbraco-cms/mcp-dev --umbraco-dry-run
# or: UMBRACO_DRY_RUN=true
```

Read-only tools execute normally and return real data. Mutation tools return a structured preview without calling the Umbraco API:

```json
{
  "dryRun": true,
  "toolName": "delete-example",
  "wouldExecute": true,
  "inputReceived": { "id": "550e8400-e29b-41d4-a716-446655440000" },
  "annotations": { "readOnlyHint": false, "destructiveHint": true }
}
```

Input validation still runs, so the LLM receives validation feedback. Use dry-run mode for safe exploration. The LLM can try mutation tools without risk.

### Readonly vs Dry-Run

| | Readonly | Dry-Run |
|---|---------|---------|
| LLM sees mutation tools | No | Yes |
| Mutation tools execute | N/A | No (preview only) |
| Read tools execute | Yes | Yes |
| Risk level | Zero | Minimal |

## Introspection Commands

These flags print output and exit immediately. They do not start the MCP server and do not require auth credentials or a running Umbraco instance.

Introspection respects all filtering configuration. If you set `UMBRACO_READONLY=true` or any filtering env var, the output shows only tools that pass those filters. This matches what the LLM sees at runtime.

| Flag | Description |
|------|-------------|
| `--list-tools` | Print ASCII table of all tools (name, collection, slices, annotations) |
| `--describe-tool <name>` | Print full JSON schema and metadata for a specific tool (exits 1 if not found or filtered out) |
| `--call <name>` | Call a tool by name, print the result as JSON, and exit |
| `--call-args <json>` | JSON arguments for `--call` (default: `{}`) |
| `--generate-context` | Output structured CONTEXT.md documenting all tools (pipe to file) |
| `--debug-config` | Print resolved configuration as JSON (values, sources, filter config) |

### `--list-tools` Output

```
Name             | Collection | Slices | RO | Destr | Description
-----------------+------------+--------+----+-------+---------------------------------------------
get-example      | example    | read   | Y  | N     | Gets an example item by ID.
list-examples    | example    | list   | Y  | N     | Lists all example items with pagination.
create-example   | example    | create | N  | N     | Creates a new example item.
delete-example   | example    | delete | N  | Y     | Deletes an example item by ID.
```

### `--describe-tool` Output

```json
{
  "name": "get-example",
  "collection": "example",
  "description": "Gets an example item by ID.",
  "slices": ["read"],
  "annotations": { "readOnlyHint": true },
  "inputSchema": {
    "type": "object",
    "properties": {
      "id": { "type": "string", "description": "The example item ID (UUID)" }
    },
    "required": ["id"]
  }
}
```

### Examples

```bash
# See all tools
npx @umbraco-cms/mcp-dev --list-tools

# See only what the LLM sees with filtering
UMBRACO_READONLY=true npx @umbraco-cms/mcp-dev --list-tools
UMBRACO_INCLUDE_SLICES=read,list npx @umbraco-cms/mcp-dev --list-tools

# Get schema for a specific tool
npx @umbraco-cms/mcp-dev --describe-tool get-content-by-id

# Call a tool directly and print the result
npx @umbraco-cms/mcp-dev --call get-content-by-id --call-args '{"id": "550e8400-e29b-41d4-a716-446655440000"}'

# Generate documentation
npx @umbraco-cms/mcp-dev --generate-context > CONTEXT.md

# Debug configuration — see resolved values and their sources
npx @umbraco-cms/mcp-dev --debug-config
UMBRACO_READONLY=true UMBRACO_INCLUDE_SLICES=read npx @umbraco-cms/mcp-dev --debug-config
```

### Debug Config Output

`--debug-config` prints JSON showing every config field with its resolved value and source (`cli`, `env`, or `none`). Credentials are masked. The `resolvedFilterConfig` section shows the final filter state applied to tools.

```json
{
  "envFile": { "source": "default" },
  "auth": {
    "baseUrl": { "value": "https://localhost:44391", "source": "env" },
    "clientId": { "value": "***", "source": "env" },
    "clientSecret": { "value": "***", "source": "env" }
  },
  "filtering": {
    "readonly": { "value": true, "source": "env" },
    "includeSlices": { "value": ["read", "list"], "source": "env" }
  },
  "resolvedFilterConfig": {
    "readOnly": true,
    "enabledSlices": ["read", "list"]
  }
}
```

## Other Options

| Flag | Env Var | Description |
|------|---------|-------------|
| `--umbraco-allowed-media-paths` | `UMBRACO_ALLOWED_MEDIA_PATHS` | Restrict media operations to these paths |
| `--disable-output-compatibility-mode` | `DISABLE_OUTPUT_COMPATIBILITY_MODE` | Use structured output instead of text |

## Input Sanitization

The SDK validates all string inputs before tool handlers run:

* Rejects control characters, path traversal (`../`), embedded query params, and percent-encoded strings
* Validates UUID format where expected
* Returns ProblemDetails (RFC 7807) with clear error messages

The LLM receives validation errors and can self-correct. No configuration is needed.

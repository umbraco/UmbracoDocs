---
description: Configuration options for the Automate Developer MCP server
---

# Configuration Options

The Automate Developer MCP Server uses the same configuration fields as any Umbraco MCP server built on the Base MCP SDK. For authentication, environment variables, CLI arguments, precedence rules, and all built-in fields, see the [SDK Configuration reference](../base-mcp/sdk/configuration.md).

For a complete reference of CLI flags, runtime modes (readonly and dry-run), introspection commands, and input sanitization, see the [CLI Reference](../base-mcp/sdk/cli.md).

This page lists the specific tool modes and slices that the Automate Developer MCP ships with. It also covers the connection and chaining fields it adds on top of the SDK defaults.

## Connection

| Variable | CLI Flag | Purpose |
| --- | --- | --- |
| `UMBRACO_CLIENT_ID` | `--umbraco-client-id` | OAuth2 client ID of the Umbraco API user |
| `UMBRACO_CLIENT_SECRET` | `--umbraco-client-secret` | OAuth2 client secret of the Umbraco API user |
| `UMBRACO_BASE_URL` | `--umbraco-base-url` | URL of the Umbraco instance running Umbraco Automate |
| `UMBRACO_EXPECTED_MAJOR` | `--umbraco-expected-major` | Overrides the Umbraco major version the server expects. See [Version Check](#version-check). |

On Umbraco Automate versions before 17.4, `get-automation-webhook-url` builds webhook URLs from `UMBRACO_BASE_URL`. If the public domain of the site differs from that URL, use the public domain instead.

{% hint style="warning" %}
Set the client secret as an environment variable, not as a CLI flag. CLI arguments can show up in process lists and shell history.
{% endhint %}

### Version Check

When the server starts, it compares the Umbraco major version of the connected instance with the version it targets. The Umbraco 17 line targets `17`.

If the versions do not match, the server logs a warning, and the first tool call returns the warning instead of running. Calling the tool again runs it.

Set `UMBRACO_EXPECTED_MAJOR` only when you deliberately connect to a different Umbraco major version. Otherwise, install the package that matches your site. See [Umbraco Automate Version Support](README.md#umbraco-automate-version-support).

## Tool Filtering

The Automate Developer MCP Server uses the SDK [tool filtering system](../base-mcp/sdk/tool-filtering.md) to control which tools are registered. Filtering is built around three concepts: **modes**, **collections**, and **slices**. See the SDK documentation for how these compose and the available configuration keys.

### Available Modes

The Automate Developer MCP ships with the following modes:

| Mode | Collections | Description |
| --- | --- | --- |
| `automate` | `approvals`, `automations`, `catalogue`, `connections`, `metrics`, `runs`, `version-history`, `workspaces` | All Automate collections. |
| `umbraco-server` | `umbraco-server` | Umbraco server information. |

Set `UMBRACO_TOOL_MODES` (or `--umbraco-tool-modes`) to one or more comma-separated mode names to enable all collections in those modes at once. See [Available Tools](available-tools.md) for the full list of collections and the tools within each.

To narrow the tools further, list the collections you need. For example, the following configuration registers the tools for building automations and reviewing runs, in read-only mode:

{% code title=".mcp.json" %}

```json
"env": {
  "UMBRACO_INCLUDE_TOOL_COLLECTIONS": "automations,catalogue,runs",
  "UMBRACO_READONLY": "true"
}
```

{% endcode %}

### Available Slices

The Automate Developer MCP ships with the following slices, used with `UMBRACO_INCLUDE_SLICES` / `UMBRACO_EXCLUDE_SLICES`:

| Slice | Description |
| --- | --- |
| `create` | Create entities. |
| `read` | Get single items and catalogue listings. |
| `update` | Update entities, including the trigger, steps, and connections of an automation. |
| `delete` | Delete entities, steps, and step connections. |
| `list` | List items. |
| `tree` | Ancestor lookups. |
| `publish` | Publish and unpublish automations. |
| `action` | Operations beyond create, read, update, and delete, such as triggering automations, controlling runs, approval decisions, connection tests, and rollbacks. |
| `export` | Export automations to a portable format. |
| `import` | Validate and import exported automations. |

For example, `UMBRACO_EXCLUDE_SLICES=delete` hides the tools that delete automations, steps, step connections, connections, workspaces, and workspace groups.

{% hint style="warning" %}
`terminate-run` stops a run permanently, and `rollback-version-history` overwrites the current state of an entity. Both belong to the `action` slice rather than `delete`.

To block every write operation, use `UMBRACO_READONLY=true` instead.
{% endhint %}

## CMS MCP Server Chaining

The Automate Developer MCP Server automatically chains to the [Umbraco CMS Developer MCP Server](../cms-developer-mcp/README.md). The Umbraco 17 line starts `@umbraco-cms/mcp-dev@17`, reusing the same `UMBRACO_CLIENT_ID`, `UMBRACO_CLIENT_SECRET`, and `UMBRACO_BASE_URL` credentials. All CMS tools are proxied with a `cms--` prefix (for example, `cms--get-document-by-id`, `cms--get-media-by-id`).

This means a single MCP connection gives your AI agent access to both Automate and CMS capabilities. It is useful when automations work with content, such as looking up the documents or Document Types that a trigger or step refers to.

Any mode, collection, and slice filter configuration set on the Automate MCP Server is passed through to the chained CMS server. Filtering therefore also narrows which `cms--` tools are registered.

| Variable | CLI Flag | Purpose |
| --- | --- | --- |
| `DISABLE_MCP_CHAINING` | `--disable-mcp-chaining` | Disable chaining to the CMS MCP Server. Only Automate tools are registered. |

{% hint style="info" %}
Disabling chaining is useful when you already run a separate CMS Developer MCP connection in your host.

It avoids registering duplicate `cms--` tools.
{% endhint %}

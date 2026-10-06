---
description: Configuration options for the Engage Developer MCP server
---

# Configuration Options

The Engage Developer MCP Server uses the same configuration fields as any Umbraco MCP server built on the Base MCP SDK. For authentication, environment variables, CLI arguments, precedence rules, and all built-in fields, see the [SDK Configuration reference](../base-mcp/sdk/configuration.md).

For a complete reference of CLI flags, runtime modes (readonly and dry-run), introspection commands, and input sanitization, see the [CLI Reference](../base-mcp/sdk/cli.md).

This page lists the specific tool modes and slices that the Engage Developer MCP ships with. It also covers the connection and chaining fields it adds on top of the SDK defaults.

## Connection

| Variable | CLI Flag | Purpose |
| --- | --- | --- |
| `UMBRACO_CLIENT_ID` | `--umbraco-client-id` | OAuth2 client ID of the Umbraco API user |
| `UMBRACO_CLIENT_SECRET` | `--umbraco-client-secret` | OAuth2 client secret of the Umbraco API user |
| `UMBRACO_BASE_URL` | `--umbraco-base-url` | URL of the Umbraco instance running Engage |

## Tool Filtering

The Engage Developer MCP Server uses the SDK [tool filtering system](../base-mcp/sdk/tool-filtering.md) to control which tools are registered. Filtering is built around three concepts: **modes**, **collections**, and **slices**. See the SDK documentation for how these compose and the available configuration keys.

### Available Modes

The Engage Developer MCP ships with the following modes:

| Mode | Collections | Description |
| --- | --- | --- |
| `ab-testing` | `ab-test`, `ab-test-project`, `ab-test-variant` | A/B tests, projects, and variants. |
| `analytics` | `analytics`, `reporting`, `statistics`, `search-terms`, `heatmaps` | Analytics queries, reporting, statistics, search terms, and heatmaps. |
| `personalization` | `persona`, `segments`, `applied-personalization`, `customer-journey` | Personas, segments, applied personalization, and customer journeys. |
| `campaigns` | `campaigns`, `campaign-group`, `goal`, `goals`, `annotations` | Campaigns, campaign groups, goals, and annotations. |
| `scoring` | `content-scoring`, `referral-scoring`, `referral-group` | Content and referral scoring. |
| `profiles` | `profile` | Visitor profiles. |
| `administration` | `configuration`, `main-switch`, `package`, `add-ons`, `cultures`, `content-types`, `document-type-permissions`, `user-group-permissions`, `data-cleanup`, `traffic-filter`, `suspicious-activity` | Configuration, permissions, data cleanup, main switch, package, and add-ons. |

Set `UMBRACO_TOOL_MODES` (or `--umbraco-tool-modes`) to one or more comma-separated mode names to enable all collections in those modes at once. See [Available Tools](available-tools.md) for the full list of collections and the tools within each.

### Available Slices

The Engage Developer MCP ships with the following slices, used with `UMBRACO_INCLUDE_SLICES` / `UMBRACO_EXCLUDE_SLICES`:

| Slice | Description |
| --- | --- |
| `create` | Create entities. |
| `read` | Get single items, or lists/searches of items. |
| `update` | Update entities. |
| `delete` | Delete entities. |
| `search` | Query and aggregate operations (analytics queries, reporting). |
| `other` | Catch-all for tools that do not map to any of the slices above. |

For example, `UMBRACO_INCLUDE_SLICES=read,search` registers only read and search tools, which is useful for a reporting-only or read-only integration.

## CMS MCP Server Chaining

The Engage Developer MCP Server automatically chains to the [Umbraco CMS Developer MCP Server](../cms-developer-mcp/README.md), reusing the same `UMBRACO_CLIENT_ID`, `UMBRACO_CLIENT_SECRET`, and `UMBRACO_BASE_URL` credentials. All CMS tools are proxied with a `cms:` prefix (for example, `cms:get-document`, `cms:get-media-by-id`).

This means a single MCP connection gives your AI agent access to both Engage and CMS capabilities. It is useful when personalization rules, A/B tests, or campaigns need to reference real documents, media, or content types.

Any mode, collection, and slice filter configuration set on the Engage MCP Server is passed through to the chained CMS server. Filtering therefore also narrows which `cms:` tools are registered.

| Variable | CLI Flag | Purpose |
| --- | --- | --- |
| `DISABLE_MCP_CHAINING` | `--disable-mcp-chaining` | Disable chaining to the CMS MCP Server. Only Engage tools are registered. |

{% hint style="info" %}
Disabling chaining is useful when you already run a separate CMS Developer MCP connection in your host.

It avoids registering duplicate `cms:` tools.
{% endhint %}

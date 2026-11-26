---
description: Server configuration for the MCP Server SDK, including environment variables, CLI flags, and custom fields.
---

# Configuration

The SDK loads configuration from environment variables, CLI flags, and `.env` files. The project template handles the wiring — this page covers the available settings and how to add your own.

For local development, the `.env` file in your project root is the most common way to configure your server. The [init phase](../create-umbraco-mcp-server/development-workflow.md#phase-2-init) populates this file for you.

## Precedence

Configuration values are resolved in this order:

**CLI arguments** > **Environment variables** > **.env file**

You can provide a custom `.env` file path using the `--env` CLI flag:

```bash
npx my-mcp-server --env="/path/to/custom/.env"
```

## Built In Configuration Fields

| Field | Env Var | CLI Flag | Type | Required |
|---|---|---|---|---|
| `clientId` | `UMBRACO_CLIENT_ID` | `--umbraco-client-id` | string | Yes |
| `clientSecret` | `UMBRACO_CLIENT_SECRET` | `--umbraco-client-secret` | string | Yes |
| `baseUrl` | `UMBRACO_BASE_URL` | `--umbraco-base-url` | string | Yes |
| `toolModes` | `UMBRACO_TOOL_MODES` | `--umbraco-tool-modes` | csv | No |
| `includeToolCollections` | `UMBRACO_INCLUDE_TOOL_COLLECTIONS` | `--umbraco-include-tool-collections` | csv | No |
| `excludeToolCollections` | `UMBRACO_EXCLUDE_TOOL_COLLECTIONS` | `--umbraco-exclude-tool-collections` | csv | No |
| `includeSlices` | `UMBRACO_INCLUDE_SLICES` | `--umbraco-include-slices` | csv | No |
| `excludeSlices` | `UMBRACO_EXCLUDE_SLICES` | `--umbraco-exclude-slices` | csv | No |
| `includeTools` | `UMBRACO_INCLUDE_TOOLS` | `--umbraco-include-tools` | csv | No |
| `excludeTools` | `UMBRACO_EXCLUDE_TOOLS` | `--umbraco-exclude-tools` | csv | No |
| `allowedMediaPaths` | `UMBRACO_ALLOWED_MEDIA_PATHS` | `--umbraco-allowed-media-paths` | csv-path | No |
| `readonly` | `UMBRACO_READONLY` | `--umbraco-readonly` | boolean | No |
| `disableOutputCompatibilityMode` | `DISABLE_OUTPUT_COMPATIBILITY_MODE` | `--disable-output-compatibility-mode` | boolean | No |

`allowedMediaPaths` restricts which filesystem paths media upload tools can write to. When set, any upload to a path outside this list is rejected.

`disableOutputCompatibilityMode` controls how tool results are returned to the MCP client. By default, the SDK returns both `structuredContent` and a JSON-stringified `content` fallback for maximum client compatibility. Setting this to `true` disables the compatibility fallback and returns `structuredContent` only, omitting the duplicated JSON in `content`. Use this when your MCP client supports `structuredContent` (for example, Claude Code and Claude Desktop).

See [Tool Filtering](./tool-filtering.md) for how modes, slices, collections, and read-only mode control which tools are registered.

### TLS Certificates

TLS certificate verification is on by default. The SDK doesn't change it.

For a local Umbraco with a self-signed certificate, set `NODE_TLS_REJECT_UNAUTHORIZED=0` in `.env`. Only use it when `UMBRACO_BASE_URL` is `localhost`, `127.0.0.1` or `[::1]`. Projects created with `create-umbraco-mcp-server` include this line in `.env`. The `init` and `discover` commands turn it on for a local base URL and comment it out for a remote one.

{% hint style="warning" %}
`NODE_TLS_REJECT_UNAUTHORIZED=0` turns off certificate verification for every HTTPS request the process makes. If it's set and `UMBRACO_BASE_URL` isn't local, the server writes an error to `stderr` and refuses to start. `npm run generate` fails in the same way, before it downloads the OpenAPI specification. For a remote site, remove the setting.
{% endhint %}

To keep verification on, trust the development certificate with `NODE_EXTRA_CA_CERTS=/path/to/dev-cert.pem`. Set it in the MCP client's server `env`, not in `.env`. Node.js reads it when the process starts, before the server loads `.env`.

See [TLS Certificates](../../connect-to-an-mcp-server/local-mcp-setup/tls-certificates.md) for why remote connections are refused and how to export the development certificate.

## Field Types

| Type | Description | Example |
|---|---|---|
| `string` | A single text value, used as-is | `https://localhost:44391` |
| `boolean` | A true/false flag. In CLI arguments, any truthy value enables it. In environment variables, set to `"true"` (case-insensitive) | `true` |
| `csv` | A comma-separated list of values. The SDK splits on commas and trims whitespace from each entry | `document,media,data-type` |
| `csv-path` | A comma-separated list of filesystem paths. Each path is resolved to an absolute path before use | `/tmp/uploads,/var/media` |

## Adding Custom Fields

If your MCP server needs additional configuration beyond the built-in fields, define them using `additionalFields`. Custom fields follow the same precedence and type system as the built-in fields.

```typescript
import {
  getServerConfig,
  type ConfigFieldDefinition,
} from "@umbraco-cms/mcp-server-sdk";

// Define your custom fields
const additionalFields: ConfigFieldDefinition[] = [
  {
    // Field name — used to access the value from the custom object
    name: "myApiKey",
    // Environment variable name
    envVar: "MY_API_KEY",
    // CLI flag (without -- prefix)
    cliFlag: "my-api-key",
    type: "string",
    required: true,
    // Masked in configuration logs
    isSecret: true,
  },
  {
    name: "enableFeature",
    envVar: "ENABLE_FEATURE",
    cliFlag: "enable-feature",
    type: "boolean",
  },
];

// Pass to getServerConfig — custom values are returned separately from the base config
const { config, custom } = getServerConfig(true, { additionalFields });

// Access your custom values
const myApiKey = custom.myApiKey as string;
const featureEnabled = custom.enableFeature as boolean;
```

You can then use these values in your tool handlers, collection setup, or anywhere else in your server. For example, you might use a custom API key to authenticate with a third-party service from within a tool.

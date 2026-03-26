---
description: Complete API reference for the @umbraco-cms/mcp-hosted package including exports, types, and interfaces.
---

# API Reference

## Environment Variables

### Secrets (via `wrangler secret put`)

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `UMBRACO_BASE_URL` | Single-site only | -- | Umbraco instance URL for browser redirects. Not needed for multi-site (each site defines `baseUrl` in code). |
| `UMBRACO_SERVER_URL` | No | Same as `UMBRACO_BASE_URL` | Server-side API URL override (for local dev with self-signed certs). |
| `UMBRACO_OAUTH_CLIENT_ID` | Single-site only | -- | OAuth client ID (must match Umbraco Composer registration). Not needed for multi-site (each site defines `oauthClientId` in code). |
| `UMBRACO_OAUTH_CLIENT_SECRET` | No | -- | OAuth client secret (only for confidential clients). Not needed for multi-site (each site defines `oauthClientSecret` in code). |
| `COOKIE_ENCRYPTION_KEY` | Yes | -- | Hex string, 32 bytes. Generate with `openssl rand -hex 32`. |

### Vars (via `wrangler.toml` `[vars]`)

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `UMBRACO_TOOL_MODES` | No | All modes | Comma-separated tool mode names (admin boundary). |
| `UMBRACO_INCLUDE_SLICES` | No | All slices | Comma-separated slice names to include. |
| `UMBRACO_EXCLUDE_SLICES` | No | None | Comma-separated slice names to exclude. |
| `UMBRACO_READONLY` | No | `"false"` | `"true"` excludes create/update/delete slices. |
| `UMBRACO_SITES` | No | -- | JSON-encoded `SiteConfig[]` for multi-site (alternative to code config). |

### Bindings (via `wrangler.toml`)

| Binding | Type | Required | Description |
|---------|------|----------|-------------|
| `OAUTH_KV` | KV Namespace | Yes | Encrypted token and state storage. |
| `MCP_AGENT` | Durable Object | Yes | Stateful MCP session (name must match `McpAgent.serve()` binding). |
| `OAUTH_PROVIDER` | -- | Auto | Injected by `@cloudflare/workers-oauth-provider` at runtime. |

See [Deployment](deployment.md) for setup instructions. See [Architecture - How Tiers Combine](architecture.md#how-tiers-combine) for how env vars interact with site and user config.

## Worker Entry Helpers

### getServerOptions(options)

Extracts `CreateServerOptions` from `HostedMcpServerOptions` for passing to `createPerRequestServer`.

```typescript
import { getServerOptions } from "@umbraco-cms/mcp-hosted";

const serverOptions = getServerOptions({
  name: "my-mcp",
  version: "1.0.0",
  collections: [myCollection],
  modeRegistry: allModes,
  allModeNames,
  allSliceNames,
});
```

### createDefaultHandler(options)

Creates the default route handler for non-MCP routes (authorize, callback, landing page). When `enableConsentToolSelection` is set, it auto-generates consent tool config from the mode registry. When `multiSite` is configured, it handles per-site routing.

```typescript
import { createDefaultHandler } from "@umbraco-cms/mcp-hosted";

export default new OAuthProvider({
  // ...
  defaultHandler: createDefaultHandler(options),
});
```

### buildConsentToolConfig(options)

Auto-generates a `ConsentToolConfig` from the mode registry and collections. Called internally by `createDefaultHandler` when `enableConsentToolSelection: true`. Also available for manual use.

```typescript
import { buildConsentToolConfig } from "@umbraco-cms/mcp-hosted";

const toolConfig = buildConsentToolConfig(options);
// Returns undefined if enableConsentToolSelection is false/unset
```

### HostedMcpServerOptions

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `name` | `string` | Yes | Server name displayed to MCP clients. |
| `version` | `string` | Yes | Server version. |
| `collections` | `ToolCollectionExport[]` | Yes | Tool collections to expose. |
| `modeRegistry` | `ToolModeDefinition[]` | Yes | Mode registry for tool filtering. |
| `allModeNames` | `readonly string[]` | Yes | All valid mode names. |
| `allSliceNames` | `readonly string[]` | Yes | All valid slice names. |
| `clientFactory` | `() => unknown` | No | Custom API client factory. |
| `authOptions` | `UmbracoAuthHandlerOptions` | No | OAuth handler options. |
| `enableConsentToolSelection` | `boolean` | No | Show tool mode selection on consent screen. |
| `multiSite` | `MultiSiteConfig` | No | Multi-site deployment configuration. |

### UmbracoAuthHandlerOptions

| Property | Type | Description |
|----------|------|-------------|
| `scopes` | `string[]` | Scopes to request from Umbraco (default: `["openid", "offline_access"]`). |
| `consentToolConfig` | `ConsentToolConfig` | Tool selection config for the consent screen. |
| `serverName` | `string` | Server name displayed on the consent screen header. |
| `customCss` | `string` | Custom CSS injected into the consent page. |
| `renderConsent` | `(options: ConsentScreenOptions) => string` | Override the entire consent screen rendering. |

## Server Factory

### createPerRequestServer(options, env, props)

Creates a fresh McpServer for each request with tools registered and API client configured. Applies three-tier configuration: env config (admin) is merged with user consent choices before tool filtering.

```typescript
import { createPerRequestServer, type CreateServerOptions } from "@umbraco-cms/mcp-hosted";

const server = await createPerRequestServer(serverOptions, env, authProps);
```

Use this inside the `McpAgent.init()` method to create a per-request server scoped to the authenticated user. See [Architecture - Per-Request Server Creation](architecture.md#per-request-server-creation) for the internal steps.

### mergeConsentChoices(envConfig, choices?)

Merges user consent choices into the admin-level config. Consent choices can only **narrow** the admin config, never expand it. See [Architecture - How Tiers Combine](architecture.md#how-tiers-combine) for the full cascade.

```typescript
import { mergeConsentChoices } from "@umbraco-cms/mcp-hosted";

const envConfig = loadWorkerConfig(env);
const effective = mergeConsentChoices(envConfig, props.consentChoices);
```

Rules:

- **Mode intersection**: If admin allows `[content, media]` and user selects `[content]`, the result is `[content]`.
- **No admin mode restriction** + user selects `[content]` results in `[content]`.
- **Read-only**: The user can enable read-only mode (adds `create`, `update`, `delete` to `excludeSlices`) but cannot disable it.

Called internally by `createPerRequestServer`. Exported for advanced use cases.

## Consent Screen

### ConsentScreenOptions

Full options for rendering the consent screen.

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| `clientName` | `string` | Yes | MCP client display name or `client_id`. |
| `umbracoBaseUrl` | `string` | Yes | Umbraco instance URL. |
| `scopes` | `string[]` | Yes | Requested OAuth scopes. |
| `redirectUri` | `string` | Yes | Registered redirect URI. |
| `actionUrl` | `string` | Yes | Form submission URL. |
| `state` | `string` | Yes | CSRF state parameter. |
| `toolConfig` | `ConsentToolConfig` | No | Tool selection config (mode checkboxes, read-only toggle). |
| `serverName` | `string` | No | Server name in the consent header. |
| `customCss` | `string` | No | Custom CSS to inject. |
| `sites` | `Array<{id, displayName, baseUrl}>` | No | Site info for multi-site display. |
| `renderConsent` | `(options) => string` | No | Complete rendering override. |

### renderConsentScreen(options) / consentResponse(options)

Renders the per-client consent screen HTML. When `toolConfig` is provided, includes mode checkboxes and an optional read-only toggle. When `renderConsent` is provided, delegates to it entirely. `consentResponse` wraps the HTML in a Response with security headers.

## Multi-Site

### SiteConfig

Configuration for a single Umbraco site in a multi-site deployment. See [Multi-Site Deployments](multi-site.md) for setup instructions.

```typescript
interface SiteConfig {
  id: string;              // URL path identifier (e.g., "prod")
  displayName: string;     // Human-readable name
  baseUrl: string;         // Umbraco instance URL
  serverUrl?: string;      // Server-side URL override (local dev)
  oauthClientId: string;   // OAuth client ID for this site
  oauthClientSecret?: string;
  toolModes?: string;      // Per-site mode overrides (comma-separated)
  includeSlices?: string;  // Per-site include slice overrides
  excludeSlices?: string;  // Per-site exclude slice overrides
  readOnly?: string;       // Per-site read-only override ("true")
}
```

### MultiSiteConfig

```typescript
interface MultiSiteConfig {
  sites: SiteConfig[];
  defaultSiteId?: string;
}
```

### `loadSiteConfig(site, baseConfig)`

Merges site-specific filter overrides into a base config from env vars. Site values replace base values where specified.

```typescript
import { loadSiteConfig, loadWorkerConfig } from "@umbraco-cms/mcp-hosted";

const baseConfig = loadWorkerConfig(env);
const siteConfig = loadSiteConfig(site, baseConfig);
```

## Types

### AuthProps

Properties returned after successful Umbraco authentication. Available as `this.props` in the McpAgent.

```typescript
interface AuthProps {
  umbracoTokenKey: string;       // KV key for stored Umbraco token
  userId: string;                // Umbraco user subject ID
  userName?: string;             // Umbraco user display name
  userEmail?: string;            // Umbraco user email
  consentChoices?: ConsentChoices; // User's consent screen selections
}
```

### HostedMcpEnv

The Cloudflare Worker environment interface. Use this to type the `env` parameter in your `worker.ts`.

```typescript
interface HostedMcpEnv {
  UMBRACO_BASE_URL: string;        // Umbraco instance URL
  UMBRACO_SERVER_URL?: string;     // Server-side URL override (local dev)
  UMBRACO_OAUTH_CLIENT_ID: string; // OAuth client ID
  UMBRACO_OAUTH_CLIENT_SECRET?: string;
  COOKIE_ENCRYPTION_KEY: string;   // Hex string, 32 bytes
  OAUTH_KV: KVNamespace;           // Token and state storage
  MCP_AGENT: DurableObjectNamespace;
  OAUTH_PROVIDER: OAuthProviderHelpers; // Injected at runtime
  UMBRACO_TOOL_MODES?: string;     // Tool mode filter
  UMBRACO_INCLUDE_SLICES?: string;
  UMBRACO_EXCLUDE_SLICES?: string;
  UMBRACO_READONLY?: string;
  UMBRACO_SITES?: string;          // JSON-encoded SiteConfig[]
}
```

## HTTP Client

### createUmbracoFetchClient(config)

Creates a fetch-based API client for the Workers runtime.

```typescript
import { createUmbracoFetchClient } from "@umbraco-cms/mcp-hosted";

const client = createUmbracoFetchClient({
  baseUrl: "https://my-umbraco.example.com",
  accessToken: "stored-access-token",
  refreshContext: {
    env,
    tokenKey: "token-kv-key",
    refreshToken: "stored-refresh-token",
  },
});
```

### `createFetchClientFromKV(env, tokenKey)`

Convenience function that creates a fetch client from stored KV tokens.

```typescript
const client = await createFetchClientFromKV(env, authProps.umbracoTokenKey);
// Returns null if token not found or expired
```

## Config

### loadWorkerConfig(env)

Loads tool filtering config from Worker env bindings.

```typescript
import { loadWorkerConfig } from "@umbraco-cms/mcp-hosted";

const config = loadWorkerConfig(env);
// Returns ServerConfigForCollections
```

## Auth Exports

### createAuthorizeHandler(env, options?)

Creates the authorize endpoint handler for the Umbraco OAuth flow. When `options.consentToolConfig` is provided, the consent screen includes tool mode checkboxes and an optional read-only toggle.

### createCallbackHandler(env)

Creates the callback endpoint handler for completing the Umbraco OAuth flow. Extracts `consentChoices` from KV state and includes them in the returned `AuthProps`.

### createLogoutCallbackHandler(env)

Creates the handler for the logout callback route. After Umbraco completes the logout, it redirects to this endpoint. The handler consumes the stored logout state from KV and redirects the user back to the authorize URL to start a fresh session.

### `getStoredUmbracoToken(kv, tokenKey)`

Retrieves a stored Umbraco token from KV.

### `refreshUmbracoToken(env, tokenKey, refreshToken)`

Refreshes an expired Umbraco token.

### renderConsentScreen(options) / consentResponse(options)

Renders the per-client consent screen HTML. See [Consent Screen](#consent-screen) for full options.

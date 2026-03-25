---
description: Common errors and fixes for the Hosted MCP server.
---

# Troubleshooting

## Error Reference

### "The specified `redirect_uri` is not valid" (OpenIdDict ID2043)

**Cause**: The callback URL sent by the Worker does not match any URI in the Umbraco Composer's `RedirectUris`.

**Fix**:

- For local dev, ensure `http://localhost:8787/callback` is in `RedirectUris`.
- For multi-site, ensure `/callback/:siteId` is registered (for example, `https://my-mcp.workers.dev/callback/prod`).
- For custom domains, ensure the custom domain callback is registered.
- The URL must match exactly. No trailing slashes. Correct protocol.

See [Umbraco Setup - Redirect URI Configuration](umbraco-setup.md#redirect-uri-configuration) for the full URI table.

### "Token exchange failed" / TLS Errors in Local Dev

**Cause**: The Worker runtime (`workerd`) cannot connect to HTTPS endpoints with self-signed certificates. This is common in local Umbraco development.

**Fix**: Two things are needed:

1. **Disable OpenIdDict's HTTPS requirement** in your Umbraco `Program.cs` (dev only). See [Umbraco Setup - Allow HTTP for Token Exchange](umbraco-setup.md#allow-http-for-token-exchange) for the code.

2. **Set `UMBRACO_SERVER_URL`** in `.dev.vars` to point at Umbraco's HTTP port. `UMBRACO_BASE_URL` (HTTPS) is used for browser redirects. `UMBRACO_SERVER_URL` (HTTP) is used for server-side token exchange.

See [Local Development Setup](local-dev-setup.md) for the full walkthrough.

### `invalid_client` on Token Exchange

**Cause**: The OAuth client ID in the Worker does not match the Umbraco Composer registration, or the client type is wrong.

**Fix**: Verify that `UMBRACO_OAUTH_CLIENT_ID` (in `.dev.vars` or Wrangler secrets) matches the `ClientId` in your `McpOAuthComposer.cs`. Check that the client is registered as `Public` (not `Confidential`). The hosted MCP server uses PKCE and does not require a client secret.

### "Umbraco token not found or expired"

**Cause**: The stored Umbraco token has expired from KV or was never stored. Tokens are stored with a TTL based on the token's `expires_in` value plus a 300-second buffer.

**Fix**: The user needs to re-authenticate. Disconnect and reconnect the MCP client to trigger a fresh OAuth flow.

See [Security - Token Refresh](security.md#token-refresh) for details.

### "Could not find McpAgent binding for MCP_OBJECT"

**Cause**: The `agents/mcp` library defaults to looking for a Durable Object binding named `MCP_OBJECT`. Your `wrangler.toml` uses a different name.

**Fix**: Pass the binding name to `McpAgent.serve()`:

```typescript
UmbracoMcpAgent.serve("/mcp", { binding: "MCP_AGENT" })
```

The binding name must match `wrangler.toml`:

```toml
[durable_objects]
bindings = [
  { name = "MCP_AGENT", class_name = "UmbracoMcpAgent" }
]
```

### "SQL is not enabled for this Durable Object class"

**Cause**: The `[[migrations]]` section in `wrangler.toml` uses `new_classes` instead of `new_sqlite_classes`.

**Fix**: Change to `new_sqlite_classes`:

```toml
[[migrations]]
tag = "v1"
new_sqlite_classes = ["UmbracoMcpAgent"]
```

The `agents` library requires SQLite-backed Durable Objects.

### "Unknown site: xxx"

**Cause**: A callback was received with a `siteId` that does not match any configured site in the `multiSite.sites` array.

**Fix**: Ensure the `id` fields in your `multiSite.sites` config match the site IDs used in your Umbraco Composer redirect URIs. For example, if the redirect URI is `/callback/prod`, the site config must have `id: "prod"`.

### "Missing code or state parameter in callback"

**Cause**: The OAuth callback from Umbraco did not include the expected `code` or `state` query parameters.

**Fix**: This usually indicates the Umbraco authorization was interrupted or the callback URL was accessed directly. Retry the OAuth flow from the beginning.

### TypeScript Errors for `agents/mcp` or `@cloudflare/workers-oauth-provider`

**Cause**: These are Wrangler virtual modules provided at build time, not npm packages. Your TypeScript editor cannot resolve them and shows errors. This is expected.

**Fix**: No action needed. The imports work when Wrangler builds and deploys. The `@umbraco-cms/mcp-hosted` package re-exports the types you need (such as `AuthProps` and `HostedMcpEnv`), so you do not need to import from the virtual modules directly.

### "Invalid or expired OAuth state parameter"

**Cause**: The state parameter in the callback does not match any stored state, or the 10-minute TTL has expired.

**Fix**: Retry the OAuth flow. State parameters are single-use and expire after 10 minutes. If this happens frequently, check for stale browser tabs or interrupted login flows.

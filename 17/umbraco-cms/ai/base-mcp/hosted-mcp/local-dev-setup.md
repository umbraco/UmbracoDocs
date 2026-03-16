---
description: Step-by-step guide to running the Hosted MCP server locally with wrangler dev and a local Umbraco instance.
---

# Local Development Setup

This guide walks you through running the hosted MCP server locally with `wrangler dev` and a local Umbraco instance.

{% hint style="info" %}
The [`create-umbraco-mcp-server`](../create-umbraco-mcp-server/README.md) CLI handles all of this setup automatically. Use this page as a reference for understanding the configuration or troubleshooting issues.
{% endhint %}

## Prerequisites

- Node.js 22+
- .NET 10 SDK (for the Umbraco instance)
- A local Umbraco 17+ instance with Management API enabled

## Step 1: Register the OAuth Client

Copy `McpOAuthComposer.cs` from the template into your Umbraco project. Update the namespace to match your project.

The Composer registers the Worker as an `authorization_code` OAuth client with redirect URIs for `localhost:8787` and `localhost:8788`. Umbraco auto-discovers it via `IComposer`. No changes to `Program.cs` are needed for the OAuth client registration.

See [Umbraco Setup](umbraco-setup.md) for the full Composer code.

## Step 2: Allow HTTP for Token Exchange

The Cloudflare Workers runtime (`workerd`) cannot connect to HTTPS endpoints with self-signed certificates. You need to allow HTTP in your local Umbraco's OpenIdDict configuration.

See [Umbraco Setup - Allow HTTP for Token Exchange](umbraco-setup.md#allow-http-for-token-exchange) for the `Program.cs` change.

## Step 3: Configure the Worker

### .dev.vars

Create a `.dev.vars` file in your Worker project root:

```
UMBRACO_BASE_URL=https://localhost:44391
UMBRACO_SERVER_URL=http://localhost:56472
UMBRACO_OAUTH_CLIENT_ID=umbraco-back-office-mcp
COOKIE_ENCRYPTION_KEY=0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef
```

| Variable | Purpose |
|----------|---------|
| `UMBRACO_BASE_URL` | HTTPS URL used for browser redirects. The user's browser handles the self-signed cert. |
| `UMBRACO_SERVER_URL` | HTTP URL used for server-side calls (token exchange, API requests). Avoids the self-signed cert problem. |
| `UMBRACO_OAUTH_CLIENT_ID` | Must match the `clientId` in the Composer. |
| `COOKIE_ENCRYPTION_KEY` | Any 64-char hex string for local dev. Generate properly for production: `openssl rand -hex 32`. |

{% hint style="info" %}
**Why two URLs?** `UMBRACO_BASE_URL` (HTTPS) is what the user's browser navigates to. The browser trusts the self-signed cert. `UMBRACO_SERVER_URL` (HTTP) is what `workerd` uses for server-side calls. `workerd` does not trust self-signed certs, so it uses the HTTP port instead.
{% endhint %}

### wrangler.toml

Ensure your `wrangler.toml` has the standard bindings:

```toml
name = "umbraco-cms-mcp"
main = "src/worker.ts"
compatibility_date = "2025-02-24"
compatibility_flags = ["nodejs_compat"]

[[kv_namespaces]]
binding = "OAUTH_KV"
id = "local-dev-placeholder"
preview_id = "local-dev-preview"

[durable_objects]
bindings = [
  { name = "MCP_AGENT", class_name = "UmbracoMcpAgent" }
]

[[migrations]]
tag = "v1"
new_sqlite_classes = ["UmbracoMcpAgent"]

[vars]
ENABLE_CONSENT_TOOL_SELECTION = "true"
ENABLE_INFO_ENDPOINT = "true"
```

The KV `id` and `preview_id` values do not matter for local dev. Wrangler creates a local SQLite-backed KV store in `.wrangler/`.

## Step 4: Run Both Services

Start both services in separate terminals:

```bash
# Terminal 1: Start Umbraco
dotnet run --project path/to/your/UmbracoProject

# Terminal 2: Start the Worker
npm run dev:worker
```

## Step 5: Test the Connection

1. Visit `http://localhost:8787`. You should see the landing page.
2. Visit `http://localhost:8787/info`. This shows the server configuration and tool collections.
3. Use the [MCP Inspector](https://inspector.tools.modelcontextprotocol.io/) in **Direct** mode with the URL `http://localhost:8787/`.
4. The Inspector triggers the OAuth flow: consent screen, then Umbraco login, then connected.

## Step 6: Cloudflare Tunnels (for Remote MCP Clients)

Remote MCP clients such as ChatGPT cannot reach `localhost`. Use `scripts/tunnels.sh` to start Cloudflare tunnels that expose both Umbraco and the Worker.

### Basic usage

This patches `.dev.vars` and prints manual Umbraco instructions:

```bash
./scripts/tunnels.sh
```

### With Umbraco auto-patching

This also sets `MCP_TUNNEL_URL` in `appsettings.local.json`:

```bash
UMBRACO_PROJECT_DIR=/path/to/UmbracoProject ./scripts/tunnels.sh
```

The script performs these steps:

1. Starts two `cloudflared` quick tunnels (Umbraco + Worker).
2. Patches `UMBRACO_BASE_URL` in `.dev.vars` to the Umbraco tunnel URL.
3. Optionally sets `MCP_TUNNEL_URL` in Umbraco's `appsettings.local.json`.

After starting, restart both Umbraco (to register the tunnel callback URI) and the Worker (to pick up the new `UMBRACO_BASE_URL`).

{% hint style="warning" %}
Quick tunnels generate a random domain name each time `tunnels.sh` runs. This means you must restart both Umbraco and the Worker every time you re-run the script, as the URLs will have changed. Quick tunnel domains also expire after a period of inactivity.

To avoid this, configure [named tunnels](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/get-started/) with stable domain names. Named tunnels keep the same URL across restarts, so you only need to configure Umbraco and the Worker once.
{% endhint %}

{% hint style="info" %}
This requires [`cloudflared`](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/) installed.
{% endhint %}

## Troubleshooting

### "This server only accepts HTTPS requests" (OpenIdDict ID2083)

**Cause**: The `DisableTransportSecurityRequirement` setting in Step 2 is not taking effect.

**Fix**: Check the following:

- `ASPNETCORE_ENVIRONMENT` is set to `Development` in your launch profile.
- The `Configure<OpenIddictServerAspNetCoreOptions>` call is before `builder.Build()`.
- You restarted the Umbraco instance after the change.

### "Token exchange failed" / TLS errors

**Cause**: `UMBRACO_SERVER_URL` is not set or points to the wrong port.

**Fix**: Check your `.dev.vars` and verify Umbraco is listening on the HTTP port (check `launchSettings.json`).

### "The specified `redirect_uri` is not valid" (OpenIdDict ID2043)

**Cause**: The callback URL does not match.

**Fix**: Ensure `http://localhost:8787/callback` is in the Composer's `RedirectUris`. The port must match. Wrangler defaults to 8787.

### "internal error; reference = ..."

**Cause**: This is a generic `workerd` error. It usually means a server-side fetch failed.

**Fix**: Check the following:

- Umbraco is running and reachable.
- `UMBRACO_SERVER_URL` points to the correct HTTP port.
- The HTTP transport security requirement is disabled (Step 2).

### Consent screen does not show tool collections

**Cause**: Tool selection is not enabled.

**Fix**: Set `ENABLE_CONSENT_TOOL_SELECTION = "true"` in `[vars]` in `wrangler.toml`, or pass `enableConsentToolSelection: true` in your worker.ts options.

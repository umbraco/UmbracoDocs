---
description: Guide for deploying the Hosted MCP server to Cloudflare Workers for production.
---

# Deployment

## Local Development

See [Local Development Setup](local-dev-setup.md) for the full guide to running the Worker locally with `wrangler dev`.

## Production Deployment

### 1. Create a KV namespace

```bash
wrangler kv namespace create OAUTH_KV
```

Copy the returned namespace ID into your `wrangler.toml`:

```toml
[[kv_namespaces]]
binding = "OAUTH_KV"
id = "abc123..."
```

### 2. Set secrets

```bash
# Umbraco instance URL
wrangler secret put UMBRACO_BASE_URL
# e.g., https://my-umbraco.example.com

# OAuth client ID (must match Umbraco OpenIdDict registration)
wrangler secret put UMBRACO_OAUTH_CLIENT_ID

# Cookie encryption key (generate with: openssl rand -hex 32)
wrangler secret put COOKIE_ENCRYPTION_KEY
```

{% hint style="info" %}
No client secret is needed. The OAuth client is registered as a **public** client with PKCE.
{% endhint %}

### 3. Deploy

```bash
wrangler deploy
```

### 4. Update Umbraco redirect URI

Ensure the production Worker URL is registered as a redirect URI in Umbraco's OpenIdDict configuration:

```
https://my-umbraco-mcp.<your-subdomain>.workers.dev/callback
```

## Environment-Specific Configuration

### Tool Filtering via Env Vars

Set non-secret configuration in `wrangler.toml`:

```toml
[vars]
UMBRACO_TOOL_MODES = "content,media"
UMBRACO_READONLY = "true"
```

Or per environment:

```toml
[env.staging.vars]
UMBRACO_TOOL_MODES = "content,media"
UMBRACO_READONLY = "true"

[env.production.vars]
UMBRACO_TOOL_MODES = "content,media,settings"
```

### Multiple Environments

```bash
# Deploy to staging
wrangler deploy --env staging

# Deploy to production
wrangler deploy --env production
```

## Consent Screen Customization

You can customize the consent screen with tool selection, branding, custom CSS, or a fully custom renderer.

See the [Customization](customization.md) guide for all options and examples.

## Multi-Site Deployment

A single Worker can serve multiple Umbraco instances. All sites share one MCP endpoint (`/`). Site selection happens during authorization via the consent screen.

See [Multi-Site Deployments](multi-site.md) for full setup instructions, route structure, and security details.

## Custom Domain

### 1. Add a custom domain in the Cloudflare dashboard

Navigate to Workers > your-worker > Settings > Domains & Routes.

### 2. Add the domain

```
mcp.example.com
```

### 3. Update Umbraco redirect URI

Register `https://mcp.example.com/callback` as an additional redirect URI. For multi-site, register `https://mcp.example.com/callback/:siteId` for each site as well.

## Monitoring

### View Logs

```bash
wrangler tail
```

### KV Token Inspection

Tokens are stored in KV with automatic TTL expiry. You can inspect stored tokens:

```bash
wrangler kv key list --namespace-id YOUR_KV_NAMESPACE_ID
```

## Known Limitations

- **Cold starts**: The first request to a Durable Object may have slightly higher latency.

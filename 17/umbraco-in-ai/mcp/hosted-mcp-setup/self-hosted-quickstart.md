---
description: Deploy the pre-built Editor MCP server to your own Cloudflare account, step by step.
---

# Self-Hosted Quick Start

This guide deploys Umbraco's pre-built Editor MCP server to your own Cloudflare account and connects it to your Umbraco site. It's the fastest path to a working self-hosted Editor MCP — no custom server code required.

## Prerequisites

* Node.js 22+
* A [Cloudflare account](https://dash.cloudflare.com/sign-up)
* The [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/install-and-update/), logged in (`npx wrangler login`)
* Admin access to your Umbraco project's source code (Umbraco 17.3+, for `SecuritySettings.GetUserAllowConcurrentLogins`)

## 1. Get the Source

Clone the Editor MCP repository and install its dependencies:

```bash
git clone https://github.com/umbraco/Umbraco-CMS-MCP-Editor.git
cd Umbraco-CMS-MCP-Editor
npm install
```

## 2. Create a KV Namespace

The Worker stores OAuth tokens in a Cloudflare KV namespace:

```bash
npx wrangler kv namespace create OAUTH_KV
```

Copy the returned namespace ID into `wrangler.toml`:

```toml
[[kv_namespaces]]
binding = "OAUTH_KV"
id = "YOUR_KV_NAMESPACE_ID"
```

{% hint style="warning" %}
Only replace `YOUR_KV_NAMESPACE_ID`. Leave `binding = "OAUTH_KV"` exactly as it is — the Worker code reads this KV namespace as `env.OAUTH_KV`, so renaming the binding breaks token storage.
{% endhint %}

## 3. Set Secrets

```bash
npx wrangler secret put UMBRACO_BASE_URL
# e.g. https://my-umbraco.example.com

npx wrangler secret put UMBRACO_OAUTH_CLIENT_ID
# Pick any value, e.g. umbraco-cms-editor-mcp-hosted — you'll reuse it in step 5

npx wrangler secret put COOKIE_ENCRYPTION_KEY
# Generate with: openssl rand -hex 32
```

{% hint style="info" %}
No client secret is needed. The OAuth client registered by `Umbraco.Mcp.HostedAuth` in step 5 is a **public** client using PKCE.
{% endhint %}

## 4. Deploy

```bash
npx wrangler deploy
```

Note the Worker's URL from the deploy output, for example `https://my-umbraco-mcp.<your-subdomain>.workers.dev`.

## 5. Wire It Into Umbraco

Install [`Umbraco.Mcp.HostedAuth`](https://www.nuget.org/packages/Umbraco.Mcp.HostedAuth) in your Umbraco project:

```bash
dotnet add package Umbraco.Mcp.HostedAuth
```

List the Worker under `HostedMcp:Clients` in `appsettings.json`:

```jsonc
{
  "HostedMcp": {
    "Clients": [
      {
        "ClientId": "umbraco-cms-editor-mcp-hosted", // must match step 3
        "Origins": [ "https://my-umbraco-mcp.<your-subdomain>.workers.dev" ]
      }
    ]
  }
}
```

Restart Umbraco. The package detects there's no `umbraco-cloud.json` file and resolves to **self-hosted mode** automatically. It registers the OAuth client on startup — no `Mode` setting needed unless you want to force it explicitly.

## 6. Verify the Connection

1. Visit your Worker's URL in a browser — you should see the landing page.
2. Connect an MCP client using that URL — see the [Setup Guides](README.md#setup-guides).
3. The client should trigger the OAuth flow: consent screen, then Umbraco login, then connected.

## Beyond the Quick Start

This guide covers the imperative `wrangler` path to a single environment. For a custom domain, multiple environments, tool filtering, or a repeatable Infrastructure as Code setup, see:

* [Deployment](../base-mcp/hosted-mcp/deployment/README.md) — custom domains, environment-specific config, monitoring.
* [Infrastructure as Code](../base-mcp/hosted-mcp/deployment/infrastructure-as-code.md) — provision with OpenTofu or Terraform.

These guides describe building a custom MCP server from the SDK, but the same Worker mechanics — KV, secrets, deployment — apply here too.

## Troubleshooting

See [Hosted MCP Troubleshooting](../base-mcp/hosted-mcp/troubleshooting.md) for common connection and deployment errors.

---
description: >-
  Step-by-step guide for manually configuring a Cloudflare Worker as a hosted
  MCP server for Umbraco.
---

# Manual Setup

{% hint style="info" %}
The [`create-umbraco-mcp-server`](../create-umbraco-mcp-server/README.md) CLI generates all of this for you. Use this page as a reference if you need to set up the Worker manually or understand what the generated code does.
{% endhint %}

## 1. Add the hosted package

```bash
npm install @umbraco-cms/mcp-hosted
```

## 2. Create a Worker entry point

The Worker entry point imports Wrangler virtual modules (`agents/mcp`, `@cloudflare/workers-oauth-provider`) and uses building blocks from this package.

```typescript
// src/worker.ts
import { McpAgent } from "agents/mcp";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import OAuthProvider from "@cloudflare/workers-oauth-provider";
import {
  createDefaultHandler,
  createWorkerExport,
  createPerRequestServer,
  getServerOptions,
  type HostedMcpEnv,
  type AuthProps,
} from "@umbraco-cms/mcp-hosted";
import myCollection from "./tools/my-collection/index.js";
import { allModes, allModeNames, allSliceNames } from "./config/index.js";

const options = {
  name: "my-umbraco-mcp",
  version: "1.0.0",
  collections: [myCollection],
  modeRegistry: allModes,
  allModeNames,
  allSliceNames,
};

const serverOptions = getServerOptions(options);

export class UmbracoMcpAgent extends McpAgent<HostedMcpEnv, unknown, AuthProps> {
  server: McpServer | undefined;
  async init() {
    this.server = await createPerRequestServer(serverOptions, this.env, this.props);
  }
}

const provider = new OAuthProvider({
  apiRoute: "/mcp",
  apiHandler: UmbracoMcpAgent.serve("/mcp", { binding: "MCP_AGENT" }),
  defaultHandler: createDefaultHandler(options),
  authorizeEndpoint: "/authorize",
  tokenEndpoint: "/token",
  clientRegistrationEndpoint: "/register",
});

export default createWorkerExport(provider, options);
```

## 3. Configure wrangler.toml

```toml
name = "my-umbraco-mcp"
main = "dist/worker.js"
compatibility_date = "2025-02-24"
compatibility_flags = ["nodejs_compat"]

[[kv_namespaces]]
binding = "OAUTH_KV"
id = "YOUR_KV_NAMESPACE_ID"

[durable_objects]
bindings = [
  { name = "MCP_AGENT", class_name = "UmbracoMcpAgent" }
]

[[migrations]]
tag = "v1"
new_sqlite_classes = ["UmbracoMcpAgent"]
```

{% hint style="warning" %}
Use `new_sqlite_classes` (not `new_classes`). The `agents` library requires SQLite-backed Durable Objects.
{% endhint %}

{% hint style="info" %}
The default Durable Object binding name expected by `agents/mcp` is `MCP_OBJECT`. If you use a different name (such as `MCP_AGENT`), pass `{ binding: "MCP_AGENT" }` to `.serve()`.
{% endhint %}

## 4. Set secrets

```bash
# Single-site only (multi-site defines these per site in code)
wrangler secret put UMBRACO_BASE_URL
wrangler secret put UMBRACO_OAUTH_CLIENT_ID

# Always required
wrangler secret put COOKIE_ENCRYPTION_KEY  # openssl rand -hex 32
```

## 5. Create a KV namespace

```bash
wrangler kv namespace create OAUTH_KV
# Update wrangler.toml with the returned namespace ID
```

## 6. Deploy

```bash
wrangler deploy
```

Your MCP server is now accessible at `https://my-umbraco-mcp.<your-subdomain>.workers.dev/`.

For troubleshooting, see the [Troubleshooting](troubleshooting.md) guide.

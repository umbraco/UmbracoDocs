---
description: Deploy Umbraco MCP servers to Cloudflare Workers for remote access over Streamable HTTP transport.
---

# Hosted MCP Server

The `@umbraco-cms/mcp-hosted` package enables AI assistants to access your Umbraco instance remotely via the Model Context Protocol (MCP) over Streamable HTTP transport. Users authenticate as backoffice users through OAuth. No API keys or API users are required.

## Local vs Hosted

**Local (stdio)** runs the MCP server on the developer's machine and communicates via stdin/stdout. This is suited to local development.

**Hosted (Cloudflare Workers)** runs the MCP server on the edge and communicates via HTTP. This enables team-wide access, remote AI assistants, and production deployments.

Both modes use the same tool collections. No code changes are required.

## Key Concepts

### Streamable HTTP

The MCP transport protocol used for hosted servers. Unlike stdio (stdin/stdout for local tools), Streamable HTTP sends MCP messages over standard HTTP requests. This enables remote access.

### Three-Tier Configuration

Tool availability is controlled by three layers. Each layer narrows the one above:

- **Admin** (env vars) sets the maximum boundary, managed by DevOps.
- **Operator** (worker.ts code) defines what is available, managed by the developer.
- **User** (consent screen) defines what they get, chosen at authorization time.

### Per-Request Server

Each MCP request creates a fresh `McpServer` instance. No state is shared between requests or clients.

## Prerequisites

- A [Cloudflare account](https://dash.cloudflare.com/sign-up)
- The [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/install-and-update/) (`npm install -g wrangler`)
- An Umbraco instance with Management API enabled
- An OAuth client registered in the Umbraco instance (see [Umbraco Setup](umbraco-setup.md))

## Getting Set Up

The [`create-umbraco-mcp-server`](../create-umbraco-mcp-server/README.md) CLI generates the Worker entry point, `wrangler.toml`, and deployment scripts for you. See the [Development Workflow](../create-umbraco-mcp-server/development-workflow.md) to get started.

For manual setup or to understand what the generated code does, see [Manual Setup](manual-setup.md).

## Routes

The Worker serves the following routes:

| Path | Purpose |
|------|---------|
| `/` | MCP endpoint (Streamable HTTP). Browser visits display the landing page. |
| `/authorize` | OAuth consent screen and redirect to Umbraco. |
| `/callback` | Token exchange after Umbraco login. |
| `/info` | Diagnostic JSON endpoint (requires `ENABLE_INFO_ENDPOINT=true`). |

When a browser visits `/` with no auth header, the Worker serves a landing page with server information. MCP clients send requests to `/` using POST or GET+SSE with authentication, and these are routed to the MCP protocol handler.

## Features

### Consent Screen with Tool Selection

Enable tool selection on the consent screen so users can choose which tool modes they want:

```typescript
const options = {
  name: "my-umbraco-mcp",
  version: "1.0.0",
  collections: [myCollection],
  modeRegistry: allModes,
  allModeNames,
  allSliceNames,
  enableConsentToolSelection: true, // Shows mode checkboxes + read-only toggle
};
```

See [Architecture - Three-Tier Configuration](architecture.md#three-tier-configuration) for how admin, operator, and user configurations interact.

### Multi-Site Support

A single Worker can serve multiple Umbraco instances. All sites share one MCP endpoint (`/`). Site selection happens during authorization via the consent screen's site picker.

See [Multi-Site Deployments](multi-site.md) for setup instructions, route structure, and security details.

## Documentation

### Getting Started

Read these articles in order:

1. [Umbraco Setup](umbraco-setup.md) - Register the Worker as an OAuth client (one-time).
2. [Deployment](deployment.md) - Deploy, set secrets, and verify the connection.
3. [Manual Setup](manual-setup.md) - Worker entry point, wrangler.toml, and secrets (reference).

### Guides

4. [Customization](customization.md) - Consent screen tool selection, branding, and custom rendering.
5. [Multi-Site Deployments](multi-site.md) - Serve multiple Umbraco instances from one Worker.

### Understanding the System

6. [Architecture](architecture.md) - Auth flow, three-tier configuration, component diagram.
7. [Security](security.md) - Token isolation, consent, CSRF protection, MCP spec compliance.

### Reference

8. [API Reference](api-reference.md) - All exports, types, and interfaces.
9. [Troubleshooting](troubleshooting.md) - Common errors and fixes.

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

- **Streamable HTTP** — the MCP transport used for hosted servers, sending messages over standard HTTP requests instead of stdio. See [Architecture](architecture.md).
- **Three-tier configuration** — admin (env vars), operator (`worker.ts` code), and user (consent screen) each narrow tool availability further. See [Architecture - Three-Tier Configuration](architecture.md#three-tier-configuration).
- **Per-request server** — each MCP request creates a fresh `McpServer` instance; no state is shared between requests or clients.

## Prerequisites

- A [Cloudflare account](https://dash.cloudflare.com/sign-up)
- The [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/install-and-update/) (`npm install -g wrangler`)
- An Umbraco 17+ instance with Management API enabled
- An OAuth client registered in the Umbraco instance (see [Umbraco Setup](deployment/umbraco-setup.md))

## Getting Set Up

**Deploying one of Umbraco's pre-built Editor or Developer MCP servers?** See the [Self-Hosted Quick Start](../../hosted-mcp-setup/self-hosted-quickstart.md) instead — it's a shorter, more direct path than what follows on this page.

**Building a custom MCP server on this SDK?** The [`create-umbraco-mcp-server`](../create-umbraco-mcp-server/README.md) CLI generates the Worker entry point, `wrangler.toml`, and deployment scripts for you. See the [Development Workflow](../create-umbraco-mcp-server/development-workflow.md) to get started, or [Manual Setup](deployment/manual-setup.md) to understand what the generated code does.

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

- **Consent screen with tool selection** — let users choose which tool modes they want at authorization time. See [Customization](customization.md).
- **Multi-site support** — serve multiple Umbraco instances from one Worker, with a site picker on the consent screen. See [Multi-Site Deployments](deployment/multi-site.md).
- **URL-based routing** — serve many Umbraco Cloud projects from one Worker via per-project URLs, no site picker. See [URL-Based Routing](deployment/url-based-routing.md).

## Documentation

### Getting Started

Read these articles in order:

1. [Umbraco Setup](deployment/umbraco-setup.md) - Register the Worker as an OAuth client (one-time).
2. [Deployment](deployment/README.md) - Deploy, set secrets, and verify the connection.
3. [Manual Setup](deployment/manual-setup.md) - Worker entry point, wrangler.toml, and secrets (reference).

### Guides

4. [Customization](customization.md) - Consent screen tool selection, branding, and custom rendering.
5. [Multi-Site Deployments](deployment/multi-site.md) - Serve multiple Umbraco instances from one Worker.
6. [URL-Based Routing](deployment/url-based-routing.md) - Serve many Umbraco Cloud projects from one Worker via per-project URLs.

### Understanding the System

7. [Architecture](architecture.md) - Auth flow, three-tier configuration, component diagram.
8. [Security](security.md) - Token isolation, consent, CSRF protection, MCP spec compliance.

### Reference

9. [API Reference](api-reference.md) - All exports, types, and interfaces.
10. [Troubleshooting](troubleshooting.md) - Common errors and fixes.
11. [Infrastructure as Code](deployment/infrastructure-as-code.md) - Provision Workers with OpenTofu or Terraform.

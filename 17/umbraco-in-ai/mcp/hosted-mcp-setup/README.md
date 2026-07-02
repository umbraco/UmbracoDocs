---
description: >-
  Prepare your Umbraco instance to connect to a hosted MCP Worker, including
  OAuth client registration and Umbraco Cloud-specific configuration.
---

# Hosted MCP Setup

A hosted MCP Worker is a Cloudflare Worker that runs an Umbraco MCP server on the edge. Before a Worker can talk to your Umbraco instance, the Umbraco project needs a few one-time changes. This section covers those Umbraco-side changes.

{% hint style="info" %}
The Worker side of the deployment (Cloudflare configuration, Wrangler, Worker entry point) lives in [Hosted MCP Server](../base-mcp/hosted-mcp/README.md). Use this section together with that one.
{% endhint %}

## What You Need

Every Umbraco instance that connects to a hosted MCP Worker needs:

1. **An OAuth client registration** so the Worker can authenticate as a backoffice user. See [OAuth Client Registration](oauth-composer.md).
2. **An external login short-circuit** if the project runs on Umbraco Cloud. The default login flow does not render Cloud SSO. See [External Login Short Circuit](external-login-short-circuit.md).
3. **URL-based routing** if you want one Worker to serve many Umbraco Cloud projects. See [URL-Based Routing](../base-mcp/hosted-mcp/url-based-routing.md).

## Self-Hosted vs Umbraco Cloud

| Step | Self-hosted | Umbraco Cloud |
|------|-------------|---------------|
| OAuth Client Registration | Required | Required |
| External Login Short Circuit | Not needed | Required |
| URL-Based Routing | Optional (multi-tenant) | Recommended |

## How It Connects to the Worker

```
┌─────────────────┐    OAuth     ┌──────────────────┐    Login    ┌────────────────────┐
│  Hosted Worker  │─────────────▶│ Umbraco instance │────────────▶│ Backoffice or SSO  │
│ (Cloudflare)    │              │ (your project)   │             │                    │
└─────────────────┘              └──────────────────┘             └────────────────────┘
        ▲                              │
        │                              │
        └────── access token ──────────┘
```

The Worker registers itself with Umbraco's OpenIddict as an `authorization_code` OAuth client. When an MCP client connects, the Worker redirects the user to Umbraco for login. The Worker exchanges the resulting code for an access token and uses the token on every Management API call.

## Articles in This Section

- [OAuth Client Registration](oauth-composer.md) — register the Worker as an OpenIddict client.
- [External Login Short Circuit](external-login-short-circuit.md) — Umbraco Cloud only. Routes cold-start MCP login through Cloud SSO.
- [URL-Based Routing](../base-mcp/hosted-mcp/url-based-routing.md) — serve multiple Umbraco projects from one Worker.

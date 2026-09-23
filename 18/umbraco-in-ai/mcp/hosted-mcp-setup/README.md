---
description: Set up and connect to hosted Umbraco MCP servers in your AI environment.
---

# Hosted MCP Setup

This section explains how to set up and connect to a hosted Umbraco MCP server from different AI environments. Unlike the [local MCP setup](../local-mcp-setup/), a hosted MCP server runs as a remote service that you connect to via a URL. Authentication is handled through an OAuth login flow using your Umbraco backoffice credentials.

Getting connected has three steps:

1. **Enable hosted MCP on your site** — a one-time setup step. Both paths install [`Umbraco.Mcp.HostedAuth`](https://github.com/umbraco/Umbraco.Mcp.HostedAuth), with a small configuration difference between them. See the [Umbraco Cloud Quick Start](cloud-quickstart.md) or [Self-Hosted Quick Start](self-hosted-quickstart.md), depending on how your site is hosted.
2. **Find your MCP URL** — see below.
3. **Connect your AI client** — see [Local Apps](local-apps.md) or [Web-Hosted Platforms](web-hosted-platforms.md), depending on where your AI client runs.

## Finding Your MCP URL

The URL you connect to depends on how your site is hosted.

### Umbraco Cloud

Every project on Umbraco Cloud is reachable through Umbraco's own shared hosted infrastructure, at a URL of this shape:

```
https://{product}.{mcp-type}.{major}.mcp.umbraco.ai/at/{alias}.{region}/mcp
```

* `{product}` — `cms` today.
* `{mcp-type}` — `editor` or `developer`.
* `{major}` — the Umbraco major version your site runs, `17` or `18`.
* `{alias}.{region}` — your Umbraco Cloud project's alias and region, the same pair that makes up your project's own domain (`{alias}.{region}.umbraco.io`).

| MCP server | Umbraco 17 | Umbraco 18 |
| ---------- | ---------- | ---------- |
| Editor     | `cms.editor.17.mcp.umbraco.ai`     | `cms.editor.18.mcp.umbraco.ai`     |
| Developer  | `cms.developer.17.mcp.umbraco.ai`  | `cms.developer.18.mcp.umbraco.ai`  |

For example, a project with alias `my-project` in region `euwest01`, running Umbraco 18, connects its Editor MCP client to:

```
https://cms.editor.18.mcp.umbraco.ai/at/my-project.euwest01/mcp
```

{% hint style="info" %}
See [URL-Based Routing](../base-mcp/hosted-mcp/deployment/url-based-routing.md) for the full mechanics behind this URL shape.
{% endhint %}

### Agency or Self-Hosted

A self-hosted deployment doesn't use the `{alias}.{region}` shape above — that's specific to Umbraco's own Cloud infrastructure. Your URL is your own Worker's domain, ending in `/mcp` (for example `https://mcp.example.com/mcp`). Your hosting provider will supply the exact URL, or see the [Self-Hosted Quick Start](self-hosted-quickstart.md) if you're setting it up yourself.

You need an Umbraco backoffice account too — you authenticate using your existing Umbraco credentials through an OAuth flow.

## Setup Guides

The guides fall into two groups, because hosted MCP support works differently depending on where your AI client runs:

* [Local Apps](local-apps.md) — Claude Code, Claude Desktop, Cursor, and GitHub Copilot run on your machine and connect out to your hosted MCP URL.
* [Web-Hosted Platforms](web-hosted-platforms.md) — ChatGPT and Claude.ai run in the browser and add the MCP server through their own settings.

## How Authentication Works

When you first connect, your MCP client will open a browser window for you to log in to Umbraco. After successful authentication, the MCP server operates with the permissions of your Umbraco user account. The tools available to you depend on your user role and permissions in Umbraco.

## Next Steps

Once connected, explore the tools available to you:

* [Available Tools](../cms-editor-mcp/available-tools.md) — complete reference of all Editor MCP tools.
* [Configuration Options](../cms-editor-mcp/configuration.md) — how to control which tools are enabled.

---
description: Set up hosted Umbraco MCP servers in your AI environment.
---

# Hosted MCP Setup

This section explains how to connect to a hosted Umbraco MCP server from different AI environments. Unlike the [local MCP setup](../local-mcp-setup/), a hosted MCP server runs as a remote service that you connect to via a URL. Authentication is handled through an OAuth login flow using your Umbraco backoffice credentials.

Getting connected has three steps:

1. **Enable hosted MCP on your site** — a one-time setup step, different for a self-hosted site versus Umbraco Cloud. See [Setting Up Hosted MCP for Your Site](site-setup.md).
2. **Find your MCP URL** — see below.
3. **Connect your AI client** — see the setup guides below.

## Two Ways to Connect

The setup guides fall into two groups, because hosted MCP support works differently depending on where your AI client runs:

* **Local apps that connect out** — [Claude Desktop](claude-desktop.md), [Claude Code](claude-code.md), [Cursor](cursor.md), and [GitHub Copilot](github-copilot.md) (via Visual Studio Code) run on your machine. You point them at your hosted MCP URL through a config file or CLI command.
* **Web-hosted platforms with their own settings UI** — [ChatGPT](chatgpt.md) and [Claude.ai](claude-ai.md) run in the browser and already act as a hosted service themselves. You add the MCP server through their own settings (ChatGPT calls this a plugin, Claude.ai a connector), not a local file.

{% hint style="info" %}
These settings UIs change often. The guides for ChatGPT and Claude.ai describe the concept and link to the vendor's current documentation. They don't promise an exact, unchanging menu path.
{% endhint %}

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

For example, a project with alias `my-project` in region `euwest01`, running Umbraco 17, connects its Editor MCP client to:

```
https://cms.editor.17.mcp.umbraco.ai/at/my-project.euwest01/mcp
```

Find your project's full MCP URL in the admin area of your Cloud project — you don't need to build it by hand.

{% hint style="info" %}
See [URL-Based Routing](../base-mcp/hosted-mcp/deployment/url-based-routing.md) for the full mechanics behind this URL shape.
{% endhint %}

### Agency or Self-Hosted

A self-hosted deployment doesn't use the `{alias}.{region}` shape above — that's specific to Umbraco's own Cloud infrastructure. Your URL is your own Worker's domain, ending in `/mcp` (for example `https://mcp.example.com/mcp`). Your hosting provider will supply the exact URL, or see [Setting Up Hosted MCP for Your Site](site-setup.md) if you're setting it up yourself.

You need an Umbraco backoffice account too — you authenticate using your existing Umbraco credentials through an OAuth flow.

## Setup Guides

### Local Apps

* [Claude Desktop](claude-desktop.md)
* [Claude Code](claude-code.md)
* [Cursor](cursor.md)
* [GitHub Copilot](github-copilot.md)

### Web-Hosted Platforms

* [ChatGPT](chatgpt.md)
* [Claude.ai](claude-ai.md)

{% hint style="info" %}
The examples below use the Editor MCP Server. The same connection method applies to any hosted Umbraco MCP server. Swap in the Developer MCP hostname from the table above if that's what you're connecting to.
{% endhint %}

## How Authentication Works

When you first connect, your MCP client will open a browser window for you to log in to Umbraco. After successful authentication, the MCP server operates with the permissions of your Umbraco user account. The tools available to you depend on your user role and permissions in Umbraco.

## Next Steps

Once connected, explore the tools available to you:

* [Available Tools](../cms-editor-mcp/available-tools.md) — complete reference of all Editor MCP tools.
* [Configuration Options](../cms-editor-mcp/configuration.md) — how to control which tools are enabled.

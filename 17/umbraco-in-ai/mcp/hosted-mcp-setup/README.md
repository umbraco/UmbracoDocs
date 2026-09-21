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

* **Local apps that connect out** — Claude Desktop, Claude Code, Cursor, and GitHub Copilot (via Visual Studio Code) run on your machine. You point them at your hosted MCP URL through a config file or CLI command.
* **Web-hosted platforms with their own connector UI** — ChatGPT and Claude.ai run in the browser and already act as a hosted service themselves. You add the MCP server as a connector through their own settings, not a local file.

{% hint style="info" %}
Connector UIs on web-hosted platforms change often. The guides for ChatGPT and Claude.ai describe the concept and link to the vendor's current documentation. They don't promise an exact, unchanging menu path.
{% endhint %}

## Finding Your MCP URL

Every hosted Umbraco MCP URL follows the same shape:

```
https://{product}.{mcp-type}.{major}.mcp.umbraco.ai/at/{alias}.{region}/
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
https://cms.editor.17.mcp.umbraco.ai/at/my-project.euwest01/
```

* **Umbraco Cloud**: Find your project's full MCP URL in the admin area of your Cloud project — you don't need to build it by hand.
* **Agency or self-hosted**: Your hosting provider will supply the URL for their own deployment.

{% hint style="info" %}
Hosting the MCP server yourself? Start with [Setting Up Hosted MCP for Your Site](site-setup.md). See [URL-Based Routing](../base-mcp/hosted-mcp/deployment/url-based-routing.md) for the full mechanics behind the `/at/{alias}.{region}/` URL shape used on Umbraco Cloud.
{% endhint %}

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

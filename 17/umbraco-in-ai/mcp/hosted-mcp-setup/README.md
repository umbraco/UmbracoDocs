---
description: Set up hosted Umbraco MCP servers in your AI environment.
---

# Hosted MCP Setup

This section explains how to connect to a hosted Umbraco MCP server from different AI environments. Unlike the [local MCP setup](../local-mcp-setup/), a hosted MCP server runs as a remote service that you connect to via a URL. Authentication is handled through an OAuth login flow using your Umbraco backoffice credentials.

## Before You Start

To connect to a hosted Umbraco MCP server, you need:

* **Your MCP URL** — provided by your hosting environment:
  * **Umbraco Cloud**: Find the URL in the admin area of your Cloud project.
  * **Agency or self-hosted**: Your hosting provider will supply the URL.

* **An Umbraco backoffice account** — you will authenticate using your existing Umbraco credentials through an OAuth flow.

## Setup Guides

Choose the guide for your AI environment:

* [Claude Desktop](claude-desktop.md)
* [ChatGPT](chatgpt.md)
* [Claude Code](claude-code.md)
* [Cursor](cursor.md)
* [GitHub Copilot](github-copilot.md)

{% hint style="info" %}
The examples below use the Editor MCP Server. The same connection method applies to any hosted Umbraco MCP server.
{% endhint %}

## How Authentication Works

When you first connect, your MCP client will open a browser window for you to log in to Umbraco. After successful authentication, the MCP server operates with the permissions of your Umbraco user account. The tools available to you depend on your user role and permissions in Umbraco.

## Next Steps

Once connected, explore the tools available to you:

* [Available Tools](../cms-editor-mcp/available-tools.md) — complete reference of all Editor MCP tools.
* [Configuration Options](../cms-editor-mcp/configuration.md) — how to control which tools are enabled.

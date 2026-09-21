---
description: Get started with the Umbraco CMS Editor Model Context Protocol (MCP).
---

# CMS Editor MCP Server

The Editor [MCP Server](../../concepts/model-context-protocol.md#mcp-servers) gives content editors and managers a natural, conversational way to work with Umbraco. It allows you to use AI assistants to manage content, media, translations, and more, without needing developer tools or technical setup.

{% hint style="info" %}
Think of it as giving your AI assistant a secure, structured way to help you manage your Umbraco site.
{% endhint %}

## How It Works

The Editor MCP works best hosted, in a Cloud-to-Cloud setup. Umbraco Cloud already runs the shared hosted infrastructure, so there's no server to deploy. It works equally well hosted and connected to a self-hosted or agency Umbraco instance. It can also run locally via stdio, the same way as the [Developer MCP Server](../cms-developer-mcp/). This documentation focuses on the hosted setup, since that's the path most editors use.

However you connect, the MCP Server talks directly to Umbraco through the Management API, authenticating as your own Umbraco backoffice user. The tools available to you are determined by your Umbraco user permissions. If you can do it in the backoffice, you can do it through the Editor MCP.

[MCP clients](../../concepts/model-context-protocol.md#mcp-clients) are implemented inside compatible [host applications](../../concepts/model-context-protocol.md#host-applications) such as Claude Desktop, Cursor, or ChatGPT. Learn more about [Model Context Protocol (MCP)](../../concepts/model-context-protocol.md).

{% hint style="info" %}
The Editor MCP Server acts as a bridge between your Umbraco instance and your AI assistant. Your permissions in Umbraco determine what actions the AI can perform on your behalf.
{% endhint %}

## Intended Audience

The Editor MCP Server is designed for content editors, content managers, and other non-developer roles working within Umbraco.

Unlike the [Developer MCP Server](../cms-developer-mcp/), the Editor MCP focuses on day-to-day editorial workflows rather than development tasks.

* **Content management**

  Create, edit, publish, and organize content pages through conversational commands. Work with block editors, manage drafts, and handle publishing workflows.

* **Media management**

  Upload, organize, and manage media files. Create folders, move items, and keep your media library tidy.

* **Translation and localization**

  Create language variants, copy content between languages, and track translation coverage across your site.

* **Content health and reporting**

  Audit your content for SEO issues, find stale or thin content, identify missing translations, and generate reports on site structure.

* **Content relationships**

  Understand how your content is connected. Find orphan pages, see what references a page before deleting it, and map outbound links.

* **Bulk operations**

  Publish, unpublish, move, or update properties across multiple pages at once. Every action requires confirmation before it executes.

* **Member management**

  Search, create, update, and organize members and member groups.

* [**And many more**](scenarios.md)

{% hint style="info" %}
The Editor MCP is built for safe, everyday use, and write operations are designed to be confirmed before they execute. Whether that confirmation happens depends on your AI host. Most hosts prompt for approval, and are getting better at recognizing destructive actions specifically. ChatGPT, for example, checks for tools that delete data and asks before running them. Check your host's own settings if you want to be sure every write is confirmed.
{% endhint %}

## Getting Started

Connecting to the Editor MCP has two parts. First, get your site set up for hosted MCP — a one-time step. Then connect your AI client to it.

* [Setting Up Hosted MCP for Your Site](../hosted-mcp-setup/site-setup.md) — covers both Umbraco Cloud (zero configuration) and self-hosted/agency sites. Self-hosting from scratch? See the [Self-Hosted Quick Start](../hosted-mcp-setup/self-hosted-quickstart.md) for the fastest path.
* [Hosted MCP Setup](../hosted-mcp-setup/README.md) — find your MCP URL and connect your AI client, whether it's a local app (Claude Desktop, Claude Code, Cursor, GitHub Copilot) or a web-hosted platform (ChatGPT, Claude.ai).

{% hint style="warning" %}
The tools available to you depend on your Umbraco user permissions. If your account does not have access to certain sections of the backoffice, those tools will not be available through the MCP.
{% endhint %}

### Choosing Your Tools

Your first step after setup should be deciding which tools you want to enable. All tools are grouped into collections for easier management and isolation. [Learn more about Tool Collections](available-tools.md).

Choosing the right tools improves how efficiently the AI communicates with Umbraco, making each conversation faster and more context-aware. Learn more about [Context Engineering](../../concepts/context-engineering.md).

## Working with the Editor MCP Server

Once your MCP Server is configured and connected, explore these guides to get the most out of your setup:

* [Available Tools](available-tools.md) - Complete reference of all available tools and collections.
* [Configuration Options](configuration.md) - How to control which tools are enabled using modes, slices, and collections.
* [Use Cases](scenarios.md) - Real-world examples and use cases for editorial workflows.

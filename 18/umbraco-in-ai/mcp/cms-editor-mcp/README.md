---
description: Get started with the Umbraco CMS Editor Model Context Protocol (MCP).
---

# CMS Editor MCP Server

The CMS Editor [MCP Server](../../concepts/model-context-protocol.md#mcp-servers) gives content editors and managers a natural, conversational way to work with Umbraco. It allows you to use AI assistants to manage content, media, translations, and more, without needing developer tools or technical setup.

{% hint style="info" %}
Think of it as giving your AI assistant a safe, structured way to help you manage your Umbraco site.
{% endhint %}

## How It Works

The CMS Editor MCP works best hosted, in a Cloud-to-Cloud setup. Umbraco Cloud already runs the shared hosted infrastructure, so there's no server to deploy. It works equally well hosted and connected to a self-hosted or agency Umbraco instance. It can also run locally via stdio, the same way as the [Developer MCP Server](../cms-developer-mcp/). This documentation focuses on the hosted setup, since that's how we expect most users to use it.

However you connect, the MCP Server talks directly to Umbraco through the Management API.

When hosted, it authenticates as your own Umbraco backoffice user through OAuth, and the tools available to you are determined by your own permissions.

If you can do it in the backoffice, you can do it through the CMS Editor MCP.

Running locally via stdio, it authenticates as a fixed Umbraco API user instead. Tool availability then depends on that user's permissions, not yours personally.

[MCP clients](../../concepts/model-context-protocol.md#mcp-clients) are implemented inside compatible [host applications](../../concepts/model-context-protocol.md#host-applications) such as Claude Desktop, GitHub Copilot, or ChatGPT. Learn more about [Model Context Protocol (MCP)](../../concepts/model-context-protocol.md).

{% hint style="info" %}
The Editor MCP Server acts as a bridge between your Umbraco instance and your AI assistant. When hosted, your own permissions in Umbraco determine what actions the AI can perform on your behalf. Running locally via stdio, it's the connected API user's permissions instead.
{% endhint %}

## Intended Audience

The Editor MCP Server is designed for content editors, content managers, and other non-developer roles working within Umbraco.

Unlike the [Developer MCP Server](../cms-developer-mcp/), the Editor MCP focuses on day-to-day editorial workflows rather than development tasks.

* **Content management**

  Create, edit, publish, and organize content pages through conversational commands. Work with block editors, manage drafts, and handle publishing workflows.

* **Library elements**

  Browse, create, edit, and publish reusable Library elements — the document-like content items shared across pages in Umbraco's Library section.

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
The Editor MCP is built for safe, everyday use, and write operations are designed to be confirmed before they execute. Whether that confirmation happens depends on your AI host. Most hosts prompt for approval, and are getting better at recognizing destructive actions specifically. ChatGPT, for example, checks for tools that delete data and asks before running them. Check your host's own settings if you want to be sure every change is confirmed.
{% endhint %}

## Getting Started

Connecting to the Editor MCP has two parts. First, get your site set up for hosted MCP — a one-time step. Then connect your AI client to it.

* [Umbraco Cloud Quick Start](../hosted-mcp-setup/cloud-quickstart.md) — zero configuration for Umbraco Cloud projects.
* [Self-Hosted Quick Start](../hosted-mcp-setup/self-hosted-quickstart.md) — deploying your own Worker for a self-hosted or agency site.
* [Hosted MCP Setup](../hosted-mcp-setup/README.md) — find your MCP URL and connect your AI client, whether it's a local app (Claude Desktop, Claude Code, Cursor, GitHub Copilot) or a web-hosted platform (ChatGPT, Claude.ai).

{% hint style="warning" %}
The tools available to you depend on your Umbraco user permissions. If your account does not have access to certain sections of the backoffice, those tools will not be available through the MCP.
{% endhint %}

### Tool Availability

There's no tool picker to configure when you connect. The tools you see are already scoped to your Umbraco user permissions, so a typical editor account only sees a small, relevant set. All tools are grouped into collections for reference. [Learn more about Tool Collections](available-tools.md).

Want to further restrict which tools are exposed — for example, blocking destructive operations across a whole team? That's a server-side setting an admin configures, not something you choose per connection. See [Configuration Options](configuration.md).

See [Configuration Options](configuration.md) and [Context Engineering](../../concepts/context-engineering.md) for why narrowing tools can still help.

## Working with the Editor MCP Server

Once your MCP Server is configured and connected, explore these guides to get the most out of your setup:

* [Available Tools](available-tools.md) - Complete reference of all available tools and collections.
* [Configuration Options](configuration.md) - How to control which tools are enabled using modes, slices, and collections.
* [Use Cases](scenarios.md) - Real-world examples and use cases for editorial workflows.

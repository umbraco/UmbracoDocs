---
description: Get started with the Umbraco CMS Editor Model Context Protocol (MCP).
---

# Editor Model Context Protocol (MCP) Server

The Editor [MCP Server](../../concepts/model-context-protocol.md#mcp-servers) gives content editors and managers a natural, conversational way to work with Umbraco. It allows you to use AI assistants to manage content, media, translations, and more, without needing developer tools or technical setup.

This MCP Server is a hosted service that connects your AI environment to your Umbraco instance. It works with MCP-compatible tools such as Claude Desktop, Cursor, GitHub Copilot, and others.

{% hint style="info" %}
Think of it as giving your AI assistant a secure, structured way to help you manage your Umbraco site.
{% endhint %}

## How It Works

The Editor MCP Server runs as a hosted service, not as a local application. You connect to it using a URL provided by your hosting provider. When you connect, you authenticate using your Umbraco backoffice credentials through an OAuth login flow.

[MCP clients](../../concepts/model-context-protocol.md#mcp-clients) are implemented inside compatible [host applications](../../concepts/model-context-protocol.md#host-applications) such as Claude Desktop, Cursor, or Windsurf. These clients connect to the server. When you interact with your chat-based environment, the client communicates with the MCP Server using the Model Context Protocol (MCP).

Learn more about [Model Context Protocol (MCP)](../../concepts/model-context-protocol.md).

The MCP Server talks directly to Umbraco through the Management API. The tools available to you are determined by your Umbraco user permissions. If you can do it in the backoffice, you can do it through the Editor MCP.

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
The Editor MCP is built for safe, everyday use. All write operations require confirmation before they execute. Destructive actions are flagged before you approve them.
{% endhint %}

## Getting Started

### Connecting to the Editor MCP

The Editor MCP Server is a hosted service. How you connect depends on where your Umbraco site is hosted.

#### Umbraco Cloud

If your site is hosted on Umbraco Cloud, you can find your Editor MCP URL in the admin area of your Cloud project. Use this URL when configuring your MCP client.

#### Agency or Self-Hosted

If your site is hosted by an agency or on your own infrastructure, your hosting provider will supply you with the Editor MCP URL.

### Authentication

When you connect for the first time, you will be taken through an OAuth login flow. You log in using your Umbraco backoffice credentials. The MCP Server then operates with the same permissions as your Umbraco user account.

{% hint style="warning" %}
The tools available to you depend on your Umbraco user permissions. If your account does not have access to certain sections of the backoffice, those tools will not be available through the MCP.
{% endhint %}

### Host Setup

Each MCP-compatible host application has its own setup process. Below you can find dedicated setup guides for the main environments:

* [Claude Desktop](../hosted-mcp-setup/claude-desktop.md)
* [Claude Code](../hosted-mcp-setup/claude-code.md)
* [GitHub Copilot](../hosted-mcp-setup/github-copilot.md)
* [Cursor](../hosted-mcp-setup/cursor.md)
* [ChatGPT](../hosted-mcp-setup/chatgpt.md)

The general pattern is the same across all hosts. You provide the Editor MCP URL in your host's MCP configuration:

```json
{
  "umbraco-editor-mcp": {
    "type": "url",
    "url": "https://your-editor-mcp-url.example.com/sse"
  }
}
```

Your hosting provider will supply the exact URL. Once configured, restart your host application. You will be prompted to authenticate via your Umbraco login.

### Choosing Your Tools

Your first step after setup should be deciding which tools you want to enable. All tools are grouped into collections for easier management and isolation. [Learn more about Tool Collections](available-tools.md).

Choosing the right tools improves how efficiently the AI communicates with Umbraco, making each conversation faster and more context-aware. Learn more about [Context Engineering](../../concepts/context-engineering.md).

## Working with the Editor MCP Server

Once your MCP Server is configured and connected, explore these guides to get the most out of your setup:

* [Available Tools](available-tools.md) - Complete reference of all available tools and collections.
* [Configuration Options](configuration.md) - How to control which tools are enabled using modes, slices, and collections.
* [Use Cases](scenarios.md) - Real-world examples and use cases for editorial workflows.
* [Best Practices](best-practice/) - Tips for effective MCP usage.

---
description: >-
  Choose the right Umbraco MCP server for your role and the Umbraco product
  you are working with.
---

# MCP Servers

Umbraco provides several MCP servers. Each one exposes a different set of tools through the [Model Context Protocol](../../concepts/model-context-protocol.md), scoped to a specific role or Umbraco product.

<table data-view="cards"><thead><tr><th></th><th></th><th data-hidden data-card-cover data-type="image">Cover image</th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><strong>CMS Developer MCP Server</strong></td><td>For Umbraco developers. Exposes the Umbraco Management API as MCP tools for content, schema, media, and workflow operations.</td><td></td><td><a href="cms-developer-mcp/README.md">README.md</a></td></tr><tr><td><strong>CMS Editor MCP Server</strong></td><td>For content editors and managers. Manage content, media, translations, and library elements through conversational AI.</td><td></td><td><a href="cms-editor-mcp/README.md">README.md</a></td></tr><tr><td><strong>Automate Developer MCP Server</strong></td><td>For developers using Umbraco Automate. Build, run, and monitor automations using AI. Beta.</td><td></td><td><a href="automate-developer-mcp/README.md">README.md</a></td></tr><tr><td><strong>Engage Developer MCP Server</strong></td><td>For developers using Umbraco Engage. Work with A/B tests, analytics, personas, segments, and campaigns using AI. Beta.</td><td></td><td><a href="engage-developer-mcp/README.md">README.md</a></td></tr><tr><td><strong>Forms Developer MCP Server</strong></td><td>For developers using Umbraco Forms. Build forms, manage submissions, and work with data sources using AI. Beta.</td><td></td><td><a href="forms-developer-mcp/README.md">README.md</a></td></tr></tbody></table>

## Choosing a Server

The right server depends on your role and which Umbraco product you are working with.

| Server | Intended for | Requires |
|---|---|---|
| CMS Developer MCP | Umbraco developers | Node.js 22+, API User |
| CMS Editor MCP | Content editors and managers | Hosted setup or Node.js 22+, API User |
| Automate Developer MCP | Developers using Umbraco Automate | Umbraco Automate, Node.js 22+, API User |
| Engage Developer MCP | Developers using Umbraco Engage | Umbraco Engage, Node.js 22+, API User |
| Forms Developer MCP | Developers using Umbraco Forms | Umbraco Forms, Node.js 22+, API User |

The Automate, Engage, and Forms servers automatically chain to the CMS Developer MCP Server. This gives your AI agent access to both product-specific and CMS tools in a single session.

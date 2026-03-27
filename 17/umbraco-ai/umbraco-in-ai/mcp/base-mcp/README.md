---
description: >-
  Build, host, and deploy custom MCP servers that expose Umbraco APIs to AI
  assistants.
---

# Base MCP

The Base MCP packages provide the foundation for building Model Context Protocol (MCP) servers that expose Umbraco APIs to AI assistants. The [Developer MCP Server](https://app.gitbook.com/s/q6oQQgn2w0ItzeFlq0Z4/#how-it-works) is built on these packages, and you can use them to build your own.

These packages are for Umbraco package developers, property editor authors, and anyone who needs to expose custom Umbraco APIs through MCP. If your package has its own Management API endpoints, you can create a dedicated MCP server. This lets AI assistants interact with those APIs directly.

## Packages

The Base MCP ecosystem consists of three packages:

### [MCP Server SDK](sdk/)

The core SDK (`@umbraco-cms/mcp-server-sdk`) provides infrastructure for building MCP servers. It includes tool authoring primitives, API helpers, a flexible filtering system, MCP chaining, and test utilities.

This package is installed automatically when you create a new project with the [Create Umbraco MCP Server](create-umbraco-mcp-server/) CLI. You do not need to install it separately.

### [Hosted MCP](hosted-mcp/)

The hosted package (`@umbraco-cms/mcp-hosted`) prepares your MCP server for deployment to Cloudflare Workers. It provides OAuth authentication, consent screen rendering, per-request server creation, and multi-site support. Users authenticate as backoffice users — no API keys required.

This package is also installed automatically when you create a new project with the [Create Umbraco MCP Server](create-umbraco-mcp-server/) CLI.

### [Create Umbraco MCP Server](create-umbraco-mcp-server/)

The CLI toolkit (`@umbraco-cms/create-umbraco-mcp-server`) is the fastest way to create an MCP server for Umbraco. It scaffolds a new project, discovers your API endpoints, and can build the entire MCP server for you — including tool collections, tests, and evaluations. Whether you need to expose a custom property editor API or a full add-on, this is where you start.

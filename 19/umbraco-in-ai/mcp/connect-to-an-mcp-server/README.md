---
description: >-
  Connect an AI client to an Umbraco MCP server, either as a hosted remote
  service or as a local process.
---

# Connect to an MCP Server

Umbraco MCP servers support two connection modes. Choose the one that matches how your MCP server is deployed.

<table data-view="cards"><thead><tr><th></th><th></th><th data-hidden data-card-cover data-type="image">Cover image</th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td><strong>Hosted MCP Setup</strong></td><td>Connect to a remote MCP server over HTTP. Authenticate with your Umbraco backoffice credentials through an OAuth login flow.</td><td></td><td><a href="hosted-mcp-setup/README.md">README.md</a></td></tr><tr><td><strong>Local MCP Setup</strong></td><td>Run an MCP server as a local Node.js process over stdio. Authenticate using a dedicated Umbraco API user.</td><td></td><td><a href="local-mcp-setup/README.md">README.md</a></td></tr></tbody></table>

## Hosted vs Local

With a hosted MCP server, the server runs as a remote service — either on Umbraco's shared Cloud infrastructure or on your own deployment. Your AI client connects to it over HTTP using a URL. Authentication is handled through an OAuth login using your existing Umbraco backoffice account.

With a local MCP server, the server runs as a Node.js process on your machine. Your AI client connects to it directly over stdio. Authentication uses a dedicated [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) created in Umbraco.

| | Hosted | Local |
|---|---|---|
| Transport | HTTP (SSE or Streaming) | stdio |
| Authentication | OAuth — your Umbraco user account | API User credentials |
| Tools available | Scoped to your Umbraco user permissions | Scoped to the API user's permissions |
| Works with web-hosted AI clients | Yes (ChatGPT, Claude.ai) | No |
| Requires Node.js locally | No | Yes (version 22+) |

Not all MCP servers support both modes. Check the documentation for the server you are using.

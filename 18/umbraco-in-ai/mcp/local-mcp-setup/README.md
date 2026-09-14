---
description: "Connect a local Umbraco MCP server to your AI development environment"
---

# Local MCP Setup

These guides show how to connect a local Umbraco MCP server to each host application. The examples use the [Developer MCP](../cms-developer-mcp/README.md) package (`@umbraco-cms/mcp-dev`). If you are using a different Umbraco MCP server, replace the package name in the configuration.

{% hint style="warning" %}
**Match the package version to your Umbraco site.** The examples in these guides use `@latest`, which installs the newest release of the MCP Server. This may be a later major version than the one your site runs.

If your site is on the current Long-Term Support (LTS) release, Umbraco 17, use the `@lts-17` tag instead, for example `@umbraco-cms/mcp-dev@lts-17`. A version mismatch causes the first tool request to fail.

See [Version Compatibility](../cms-developer-mcp/README.md#version-compatibility) for the full list of tags.
{% endhint %}

## Before You Start

- **Node.js 22+** is required. Check your version by running `node -v` in your terminal.
- **Umbraco API User** — You need to create an [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) in Umbraco before connecting. This user allows the MCP server to communicate securely with the Management API.

## Hosts

### [Claude Desktop](./claude-desktop.md)

Getting started with Claude Desktop.

### [Claude Code](./claude-code.md)

Getting started with Claude Code.

### [Cursor](./cursor.md)

Getting started with Cursor.

### [GitHub Copilot](./github-copilot.md)

Getting started with GitHub Copilot.

### [OpenAI Codex](./openai-codex.md)

Getting started with OpenAI Codex.

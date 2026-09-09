---
description: >-
  Use the Developer MCP Server's Claude Code plugin skills, or the server
  itself as a CLI tool, for a quick connection to Umbraco without additional
  setup.
---

# Skills & CLI

The Developer MCP Server ships a Claude Code plugin with skills for CLI operation and MCP client setup. The server can also be used as a CLI tool directly. This wraps the same MCP server and exposes the same tools, but runs them from the command line.

The MCP connection is more context-efficient because the host manages tool selection and conversation state. The skills and CLI below are a simpler alternative. Use them to get started quickly, debug your configuration, or have Claude Code walk you through setup.

## Installing the Plugin

```bash
/plugin marketplace add umbraco/Umbraco-CMS-MCP-Dev
/plugin install umb-cms-mcp@umb-cms-mcp-plugins
```

## `umb-cms-dev-cli`

Guide for running and debugging the Developer MCP Server via the CLI. It covers listing tools, calling tools directly, tool filtering, dry-run and readonly modes, and debugging your resolved configuration.

Use it with a query to interact with Umbraco directly from Claude Code:

```
/umb-cms-dev-cli tell me what properties the home document type has
/umb-cms-dev-cli list all published content under the homepage
/umb-cms-dev-cli show me the media library structure
```

For the full reference of CLI flags, runtime modes, introspection commands, and input sanitization, see the [CLI Reference](../base-mcp/sdk/cli.md).

## `umb-cms-mcp-setup`

Guide for installing and configuring the Developer MCP Server as a live MCP connection in an AI client, rather than running it standalone. Supported clients include Claude Desktop, Claude Code, Cursor, and GitHub Copilot.

Use it when you want Claude Code to walk you through connecting the server for the first time, or to troubleshoot an existing connection. It points to the same official setup guides as this documentation site:

* [Getting Started](README.md)
* [Local MCP Setup](../local-mcp-setup/README.md)
* [Configuration Options](configuration.md)

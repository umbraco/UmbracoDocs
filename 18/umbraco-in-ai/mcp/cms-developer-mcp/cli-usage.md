---
description: >-
  Use the Developer MCP Server as a CLI tool for a quick connection to
  Umbraco without additional setup.
---

# CLI Usage

The Developer MCP Server can also be used as a CLI tool. This wraps the same MCP server and exposes the same tools, but runs them directly from the command line. It is a quick way to connect to Umbraco without any host setup.

The MCP connection is more context-efficient because the host manages tool selection and conversation state. The CLI is a simpler alternative when you want to get started quickly or debug your configuration.

## Claude Code Plugin

If you are using Claude Code, install the Developer MCP plugin. The `/umb-cms-dev-cli` skill lets you run queries against Umbraco directly from Claude Code.

```bash
/plugin marketplace add umbraco/Umbraco-CMS-MCP-Dev
/plugin install umb-cms-mcp@umb-cms-mcp-plugins 
```

Once installed, use `/umb-cms-dev-cli` with a query to interact with Umbraco:

```
/umb-cms-dev-cli tell me what properties the home document type has
/umb-cms-dev-cli list all published content under the homepage
/umb-cms-dev-cli show me the media library structure
```

## CLI Reference

For the full reference of CLI flags, runtime modes (readonly and dry-run), introspection commands, and input sanitization, see the [CLI Reference](../base-mcp/sdk/cli.md).

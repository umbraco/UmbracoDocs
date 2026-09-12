---
description: >-
  Use the Engage Developer MCP Server's Claude Code plugin skills, or the
  server itself as a CLI tool, for a quick connection to Umbraco Engage
  without additional setup.
---

# Skills & CLI

The Engage Developer MCP Server ships a Claude Code plugin with skills for CLI operation, MCP client setup, and content-structure recipes. The server can also be used as a CLI tool directly. This wraps the same MCP server and exposes the same tools, including the chained `cms:` tools, but runs them from the command line.

The MCP connection is more context-efficient because the host manages tool selection and conversation state. The skills and CLI below are a simpler alternative. Use them to get started quickly, debug your configuration, or have Claude Code walk you through building an A/B test or personalization rule.

## Installing the Plugin

```bash
/plugin marketplace add umbraco/Umbraco-Engage-MCP-Dev
/plugin install umb-engage-mcp@umb-engage-mcp-plugins
```

## `umb-engage-dev-cli`

Guide for running and debugging the Engage Developer MCP Server via the CLI. It covers listing tools, calling tools directly, tool filtering, dry-run and readonly modes, and debugging your resolved configuration.

Use it with a query to interact with Umbraco Engage directly from Claude Code:

```
/umb-engage-dev-cli list all running A/B tests
/umb-engage-dev-cli show me the visitor segments configured on this site
/umb-engage-dev-cli what goals are set up for the homepage
```

For the full reference of CLI flags, runtime modes, introspection commands, and input sanitization, see the [CLI Reference](../base-mcp/sdk/cli.md).

## `umb-engage-mcp-setup`

Guide for installing and configuring the Engage Developer MCP Server as a live MCP connection in an AI client, rather than running it standalone. Supported clients include Claude Desktop, Claude Code, Cursor, and GitHub Copilot.

Use it when you want Claude Code to walk you through connecting the server for the first time, or to troubleshoot an existing connection. It points to the same official setup guides as this documentation site:

* [Getting Started](README.md)
* [Local MCP Setup](../local-mcp-setup/README.md)
* [Configuration Options](configuration.md)

## `umb-engage-content-recipes`

Reference recipes for building real Engage content structures through the MCP tools, since some entities can't be created with a single isolated call. An A/B test needs a real, active goal and a real, published content page before it will validate, for example.

Use it when you want Claude Code to build an A/B test, goal, persona, segment, or personalization rule in the correct tool-call order, including:

* A/B test: project (optional), goal, content page, test, variant, then start or stop
* Goals used standalone for campaign scoring
* Personalization: persona, segment, then applied personalization

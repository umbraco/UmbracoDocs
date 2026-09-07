---
description: >-
  Use the Engage Developer MCP Server as a CLI tool for a quick connection to
  Umbraco Engage without additional setup.
---

# CLI Usage

The Engage Developer MCP Server can also be used as a CLI tool. This wraps the same MCP server and exposes the same tools, including the chained `cms:` tools, but runs them directly from the command line. It is a quick way to connect to Umbraco Engage without any host setup.

The MCP connection is more context-efficient because the host manages tool selection and conversation state. The CLI is a simpler alternative when you want to get started quickly or debug your configuration.

## Claude Code Plugin

If you are using Claude Code, install the Engage Developer MCP plugin. The `/umb-engage-dev-cli` skill lets you run queries against Umbraco Engage directly from Claude Code.

```bash
/plugin marketplace add umbraco/Umbraco-Engage-MCP-Dev
/plugin install umb-engage-mcp@umb-engage-mcp-plugins
```

Once installed, use `/umb-engage-dev-cli` with a query to interact with Umbraco Engage:

```
/umb-engage-dev-cli list all running A/B tests
/umb-engage-dev-cli show me the visitor segments configured on this site
/umb-engage-dev-cli what goals are set up for the homepage
```

{% hint style="info" %}
The same plugin also ships an `umb-engage-mcp-setup` skill for connecting the MCP server to an AI client. It ships an `umb-engage-content-recipes` skill too.

That second skill covers end-to-end recipes for building A/B tests, personalization, and goals.
{% endhint %}

## CLI Reference

For the full reference of CLI flags, runtime modes (readonly and dry-run), introspection commands, and input sanitization, see the [CLI Reference](../base-mcp/sdk/cli.md).

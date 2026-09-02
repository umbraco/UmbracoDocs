---
description: Host set up for Claude Code
---

# Claude Code

Claude Code is a CLI-based coding assistant from Anthropic that runs in your terminal. It supports MCP servers for extending its capabilities.

{% hint style="info" %}
The examples below use the Editor MCP Server. Replace the URL if you are using a different hosted Umbraco MCP server.
{% endhint %}

## Configuration

### Using the CLI

Add the hosted MCP server using the `claude mcp add` command:

```bash
claude mcp add umbraco-editor-mcp --transport sse https://your-editor-mcp-url.example.com/sse
```

### Using a Configuration File

Alternatively, add the server to your project's `.mcp.json` file:

```json
{
  "mcpServers": {
    "umbraco-editor-mcp": {
      "type": "url",
      "url": "https://your-editor-mcp-url.example.com/sse"
    }
  }
}
```

{% hint style="warning" %}
Replace the URL with the actual URL provided by your hosting environment.
{% endhint %}

## Authentication

When you first use an Umbraco tool, Claude Code will open a browser window for you to log in to Umbraco using your backoffice credentials.

## Managing the Connection

To reconnect after configuration changes, use:

```
/mcp reconnect
```

## Verifying the Connection

Try a command to verify the connection is working:

```
Search for all content pages
```

## Next Steps

* [Available Tools](../cms-editor-mcp/available-tools.md) — see what tools you can use.
* [Configuration Options](../cms-editor-mcp/configuration.md) — learn how to control which tools are enabled.

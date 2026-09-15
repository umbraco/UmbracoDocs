---
description: Host set up for GitHub Copilot
---

# GitHub Copilot

GitHub Copilot supports MCP servers through Visual Studio Code. You can connect to a hosted Umbraco MCP server to manage your Umbraco site from within Visual Studio Code.

{% hint style="info" %}
The examples below use the Editor MCP Server. Replace the URL if you are using a different hosted Umbraco MCP server.
{% endhint %}

## Configuration

### Using Visual Studio Code Settings

1. Open Visual Studio Code with GitHub Copilot installed.
2. Open the Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`).
3. Search for **MCP: Add Server**.
4. Select **HTTP (Server-Sent Events)** as the transport type.
5. Enter your hosted MCP URL:

```
https://your-editor-mcp-url.example.com/sse
```

6. Enter a name for the server (for example, `umbraco-editor-mcp`).

### Manual Configuration

You can also add the server to your Visual Studio Code `.vscode/mcp.json` file:

```json
{
  "servers": {
    "umbraco-editor-mcp": {
      "type": "sse",
      "url": "https://your-editor-mcp-url.example.com/sse"
    }
  }
}
```

{% hint style="warning" %}
Replace the URL with the actual URL provided by your hosting environment.
{% endhint %}

## Authentication

When you first use an Umbraco tool, a browser window will open for you to log in to Umbraco using your backoffice credentials.

## Managing Your MCP Server

GitHub Copilot may restart MCP servers during certain actions such as reloading the window. The OAuth token is cached, so you should not need to re-authenticate each time.

## Verifying the Connection

Try a command in Copilot Chat to verify:

```
Search for all content pages
```

## Next Steps

* [Available Tools](../cms-editor-mcp/available-tools.md) — see what tools you can use.
* [Configuration Options](../cms-editor-mcp/configuration.md) — learn how to control which tools are enabled.

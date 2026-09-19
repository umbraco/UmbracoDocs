---
description: Host set up for Cursor
---

# Cursor

Cursor is an AI-powered code editor that supports MCP servers for extending its capabilities beyond code editing.

{% hint style="info" %}
The examples below use the Editor MCP Server. Replace the URL if you are using a different hosted Umbraco MCP server.
{% endhint %}

## Configuration

1. Open Cursor.
2. Go to **Settings** > **MCP**.
3. Click **Add new MCP server**.
4. Select **SSE** as the transport type.
5. Enter a name (for example, `umbraco-editor-mcp`) and your hosted MCP URL:

```
https://cms.editor.17.mcp.umbraco.ai/at/my-project.euwest01/
```

6. Save the configuration. A browser window will open for you to authenticate using your Umbraco backoffice credentials.

### Manual Configuration

You can also add the server manually to your Cursor MCP configuration file:

```json
{
  "mcpServers": {
    "umbraco-editor-mcp": {
      "type": "url",
      "url": "https://cms.editor.17.mcp.umbraco.ai/at/my-project.euwest01/"
    }
  }
}
```

{% hint style="warning" %}
Replace `https://cms.editor.17.mcp.umbraco.ai/at/my-project.euwest01/` with your own MCP URL. See [Finding Your MCP URL](README.md#finding-your-mcp-url) for how it's built.
{% endhint %}

## Verifying the Connection

After configuration, you should see the Umbraco MCP tools listed in Cursor's tool panel. Try a command to verify:

```
Search for all content pages
```

## Next Steps

* [Available Tools](../cms-editor-mcp/available-tools.md) — see what tools you can use.
* [Configuration Options](../cms-editor-mcp/configuration.md) — learn how to control which tools are enabled.

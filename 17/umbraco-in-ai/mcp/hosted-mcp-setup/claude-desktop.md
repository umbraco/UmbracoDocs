---
description: Host set up for Claude Desktop
---

# Claude Desktop

Claude Desktop is a desktop application from Anthropic that provides a chat interface with support for MCP servers. It is available for macOS and Windows.

{% hint style="info" %}
The examples below use the Editor MCP Server. Replace the URL if you are using a different hosted Umbraco MCP server.
{% endhint %}

## Configuration

1. Open Claude Desktop.
2. Go to **Settings** > **Developer** > **Edit Config**.
3. This opens the `claude_desktop_config.json` file. Add your hosted MCP server:

```json
{
  "mcpServers": {
    "umbraco-editor-mcp": {
      "type": "url",
      "url": "https://cms.editor.17.mcp.umbraco.ai/at/my-project.euwest01/mcp"
    }
  }
}
```

4. Save the file and restart Claude Desktop.
5. When you first use an Umbraco tool, a browser window will open for you to log in to Umbraco using your backoffice credentials.

{% hint style="warning" %}
Replace `https://cms.editor.17.mcp.umbraco.ai/at/my-project.euwest01/mcp` with your own MCP URL. See [Finding Your MCP URL](README.md#finding-your-mcp-url) for how it's built.
{% endhint %}

## Verifying the Connection

After restarting, you should see the Umbraco MCP tools listed in the tools panel. Try a command to verify:

```
Search for all content pages
```

If the connection is working, you will see results from your Umbraco instance.

## Next Steps

* [Available Tools](../cms-editor-mcp/available-tools.md) — see what tools you can use.
* [Configuration Options](../cms-editor-mcp/configuration.md) — learn how to control which tools are enabled.

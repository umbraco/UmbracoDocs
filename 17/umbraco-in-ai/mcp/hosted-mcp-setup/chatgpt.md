---
description: Host set up for ChatGPT
---

# ChatGPT

ChatGPT from OpenAI supports connecting to external MCP servers. You can connect ChatGPT to a hosted Umbraco MCP server to manage your Umbraco site through conversation.

{% hint style="info" %}
The examples below use the Editor MCP Server. Replace the URL if you are using a different hosted Umbraco MCP server.
{% endhint %}

## Configuration

1. Open ChatGPT.
2. Navigate to **Settings** > **Connected Tools** (or **MCP Servers**).
3. Click **Add MCP Server**.
4. Enter your hosted MCP URL:

```
https://your-editor-mcp-url.example.com/sse
```

5. Save and confirm. A browser window will open for you to authenticate using your Umbraco backoffice credentials.

{% hint style="warning" %}
Replace the URL with the actual URL provided by your hosting environment.
{% endhint %}

## Verifying the Connection

Once connected, you should see the Umbraco tools available in your ChatGPT conversation. Try a command to verify:

```
Search for all content pages
```

## Next Steps

* [Available Tools](../cms-editor-mcp/available-tools.md) — see what tools you can use.
* [Configuration Options](../cms-editor-mcp/configuration.md) — learn how to control which tools are enabled.

---
description: Host set up for Claude.ai
---

# Claude.ai

Claude.ai, the web version of Claude from Anthropic, supports connecting to external MCP servers through its **Connectors** settings. Claude.ai runs in the browser, not on your machine. You add the Umbraco MCP server as a connector through Claude.ai's own settings — there's no local config file to edit.

{% hint style="info" %}
The examples below use the Editor MCP Server. Replace the URL if you are using a different hosted Umbraco MCP server.
{% endhint %}

{% hint style="warning" %}
Anthropic updates the Connectors UI from time to time, so exact menu names and steps may differ from what's shown below. The destination is always the same: a place to add a custom connector by URL. See [Claude's Help Center](https://support.claude.com) for the current steps if this doesn't match what you see.
{% endhint %}

## Creating a Connector

1. Open Claude.ai and go to its Connectors settings.
2. Add a custom connector.
3. Enter your hosted MCP URL:

```
https://cms.editor.17.mcp.umbraco.ai/at/my-project.euwest01/
```

4. Save the connector. A browser window opens for you to authenticate using your Umbraco backoffice credentials.

{% hint style="warning" %}
Replace `https://cms.editor.17.mcp.umbraco.ai/at/my-project.euwest01/` with your own MCP URL. See [Finding Your MCP URL](README.md#finding-your-mcp-url) for how it's built.
{% endhint %}

## Verifying the Connection

Once connected, you should see the Umbraco tools available in your Claude.ai conversation. Try a command to verify:

```
Search for all content pages
```

## Next Steps

* [Available Tools](../cms-editor-mcp/available-tools.md) — see what tools you can use.
* [Configuration Options](../cms-editor-mcp/configuration.md) — learn how to control which tools are enabled.

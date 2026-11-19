---
description: Host set up for Claude Desktop
---

# Claude Desktop

Claude Desktop is a desktop application from Anthropic that provides a chat interface with support for MCP servers. It is available for macOS and Windows.

There are two ways to connect Claude Desktop to a hosted Umbraco MCP server:

* [Add a custom connector](#add-a-custom-connector) in the Claude Desktop settings.
* [Use the configuration file](#use-the-configuration-file) with the `mcp-remote` package. Use this option if you can't add custom connectors, or if your MCP URL isn't reachable from the public internet.

{% hint style="info" %}
The examples below use the Editor MCP Server. Replace the URL if you are using a different hosted Umbraco MCP server.
{% endhint %}

{% hint style="warning" %}
Replace `https://cms.editor.19.mcp.umbraco.ai/at/my-project.euwest01/mcp` with your own MCP URL. See [Finding Your MCP URL](README.md#finding-your-mcp-url) for how it's built.
{% endhint %}

## Add a Custom Connector

{% hint style="warning" %}
Anthropic updates the Connectors UI from time to time, so exact menu names may differ from the steps below. See [Claude's Help Center](https://support.claude.com/en/articles/11175166-get-started-with-custom-connectors-using-remote-mcp) for the current steps.
{% endhint %}

1. Open Claude Desktop.
2. Go to **Settings** > **Connectors**.
3. Select **Add custom connector**.
4. Enter a name for the connector, for example `Umbraco Editor`.
5. Enter your hosted MCP URL:

   ```
   https://cms.editor.19.mcp.umbraco.ai/at/my-project.euwest01/mcp
   ```

6. Select **Add**.
7. Select **Connect**. A browser window opens for you to log in to Umbraco with your backoffice credentials.

On Team and Enterprise plans, only an Owner can add a custom connector. After the Owner adds it, each member selects **Connect** to log in.

{% hint style="info" %}
Claude connects to a custom connector from Anthropic's cloud, not from your machine. Your MCP URL must be reachable from the public internet and use the default HTTPS port.
{% endhint %}

## Use the Configuration File

This option runs the [`mcp-remote`](https://www.npmjs.com/package/mcp-remote) package on your machine. It connects Claude Desktop to the hosted MCP server and handles the login flow. It requires Node.js 18 or later.

1. Go to **Settings** > **Developer** > **Edit Config** to find the `claude_desktop_config.json` file.
2. Open the file in a text editor and add your hosted MCP server:

```json
{
  "mcpServers": {
    "umbraco-editor-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote",
        "https://cms.editor.19.mcp.umbraco.ai/at/my-project.euwest01/mcp"
      ]
    }
  }
}
```

3. Save the file, then quit and restart Claude Desktop.
4. A browser window opens for you to log in to Umbraco with your backoffice credentials.

{% hint style="info" %}
The configuration file only supports MCP servers that Claude Desktop starts with `command` and `args`. A `url` or `type` entry causes an error when Claude Desktop starts.
{% endhint %}

## Verifying the Connection

Start a new chat and check that the Umbraco connector is listed and enabled under the **+** menu. Try a command to verify:

```
Search for all content pages
```

If the connection is working, you will see results from your Umbraco instance.

## Troubleshooting

* **Claude Desktop shows an error after you edit the configuration file.** Check that the file is valid JSON and has no `url` or `type` entries.
* **The server fails to start with the configuration file.** Run `node -v` and check that you have Node.js 18 or later. Claude Desktop uses your system Node.js version.
* **The login loops or fails with the configuration file.** Delete the `~/.mcp-auth` folder, then restart Claude Desktop to log in again.
* **A custom connector can't connect.** Check that the MCP URL is correct and reachable from the public internet. If it isn't, use the configuration file instead.

## Next Steps

* [Available Tools](../../mcp-servers/cms-editor-mcp/available-tools.md) — see what tools you can use.
* [Configuration Options](../../mcp-servers/cms-editor-mcp/configuration.md) — learn how to control which tools are enabled.

---
description: Host set up for Claude Desktop
---

# Claude Desktop

Claude Desktop is a desktop application from Anthropic that provides a chat interface with support for MCP servers. It is available for macOS and Windows.

How you connect Claude Desktop to an Umbraco MCP server depends on where the server runs:

* [Hosted MCP server](#hosted-mcp-server-setup): add a custom connector in the Claude Desktop settings.
* [Local MCP server](#local-mcp-server-setup): add the server to the Claude Desktop configuration file.

## Hosted MCP Server Setup

Claude Desktop connects to a hosted Umbraco MCP server through a custom connector. You add the connector in the Claude Desktop settings and log in with your Umbraco backoffice credentials.

{% hint style="info" %}
The examples below use the Editor MCP Server. Replace the URL if you are using a different hosted Umbraco MCP server.
{% endhint %}

### Before You Start

Who can add a custom connector depends on your Claude plan:

* On Free, Pro, and Max plans, you add the custom connector yourself. Free plans are limited to one custom connector.
* On Team and Enterprise plans, an organization owner adds the custom connector. Each member then connects with their own Umbraco login.

{% hint style="warning" %}
If **Add custom connector** is unavailable, your organization manages connectors centrally. Contact your Claude administrator and ask them to add the connector. Do not use a local workaround to bypass your organization's rules.
{% endhint %}

{% hint style="info" %}
Claude connects to a custom connector from Anthropic's cloud, not from your machine. Your MCP URL must be reachable from the public internet on the standard HTTPS port (443).
{% endhint %}

### Add a Custom Connector

{% hint style="warning" %}
Anthropic updates the Connectors UI from time to time, so exact menu names can differ from the steps below. See [Claude's Help Center](https://support.claude.com/en/articles/11175166-get-started-with-custom-connectors-using-remote-mcp) for the current steps.
{% endhint %}

1. Open Claude Desktop.
2. Go to **Settings** > **Customize** > **Connectors**.
3. Select **Add**, then select **Add custom connector**.
4. Enter a name for the connector, for example `Umbraco Editor`.
5. Enter your hosted MCP URL:

   ```
   https://cms.editor.19.mcp.umbraco.ai/at/my-project.euwest01/mcp
   ```

6. Follow the prompts and select **Add**.
7. Select **Connect**. A browser window opens for you to log in to Umbraco with your backoffice credentials.

{% hint style="warning" %}
Replace `https://cms.editor.19.mcp.umbraco.ai/at/my-project.euwest01/mcp` with your own MCP URL. See [Finding Your MCP URL](README.md#finding-your-mcp-url) for how it's built.
{% endhint %}

### Team and Enterprise Plans

An organization owner adds the custom connector under **Organization settings** > **Connectors**. Each member then goes to **Settings** > **Customize** > **Connectors** and selects **Connect**.

The connector is visible to everyone in the organization. Only users with a backoffice login for the Umbraco site can connect to the site.

### Verifying the Connection

Start a new chat, select **+**, and then select **Connectors**. Check that the Umbraco connector is listed and enabled. Try a command to verify:

```
Search for all content pages
```

If the connection is working, you will see results from your Umbraco instance.

## Local MCP Server Setup

A local MCP server is a server that Claude Desktop starts on your machine with a `command`. You set up a local MCP server in the `claude_desktop_config.json` configuration file.

To open the file, go to **Settings** > **Desktop app** > **Extensions**. Then select **Edit config** under **Local MCP servers**.

{% hint style="warning" %}
The **Extensions** settings are not always available. Your organization can turn off local MCP servers in Claude Desktop. If the settings are missing, contact your Claude administrator.
{% endhint %}

See [Claude Desktop](../local-mcp-setup/claude-desktop.md) in the Local MCP Setup section for the full steps.

{% hint style="warning" %}
The configuration file does not work for connecting to a hosted MCP server. Claude Desktop skips an entry with a `url` and shows the following message:

![The "Some MCP servers couldn't be loaded" message in Claude Desktop](<../../../.gitbook/assets/claude-desktop-mcp-servers-not-loaded.png>)

Remove the entry from the file and restart Claude Desktop. Then [add a custom connector](#add-a-custom-connector) to connect to the hosted MCP server.
{% endhint %}

## Troubleshooting

* **Add custom connector is unavailable.** Contact your Claude administrator and ask them to add the connector for your organization.
* **The connector can't connect.** Check that the MCP URL is correct and reachable from the public internet.
* **The login fails.** Check that your user has access to the backoffice of the Umbraco site.

## Next Steps

* [Available Tools](../../mcp-servers/cms-editor-mcp/available-tools.md) — see what tools you can use.
* [Configuration Options](../../mcp-servers/cms-editor-mcp/configuration.md) — learn how to control which tools are enabled.

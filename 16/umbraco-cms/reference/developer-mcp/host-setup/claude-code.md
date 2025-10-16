---
description: "Host set up for Claude Code"
---

# Claude Code Setup

[Claude Code](https://www.claude.com/product/claude-code) is a developer-focused coding environment from Anthropic that integrates Claude’s large language models (LLMs) directly into your code editor.
It allows you to chat, refactor, and generate code within your projects.

## Getting started 

Install Claude Code globally

```bash
npm install -g @anthropic-ai/claude-code
```

## Configuration using the CLI tool

Basic install

```bash
claude mcp add umbraco-mcp npx @umbraco-cms/mcp-dev@beta
```

If you prefer to define configuration values directly, use the following pattern:

```bash

# Add with environment variables
claude mcp add umbraco-mcp --env UMBRACO_CLIENT_ID="your-id" --env UMBRACO_CLIENT_SECRET="your-secret" --env UMBRACO_BASE_URL="https://your-domain.com" --env NODE_TLS_REJECT_UNAUTHORIZED="0" --env UMBRACO_INCLUDE_TOOL_COLLECTIONS="culture,document,media" -- npx @umbraco-cms/mcp-dev@beta
```

This will add the MCP server as umbraco-mcp in your project’s claude.json configuration file.

{% hint style="info" %}
Use claude mcp list anytime to confirm which MCP servers are active in your Claude Code environment.
{% endhint %}

## Configuration via .mcp.json (Project-specific)

This is the perferred configuration for Claude Code. 
As project-level configuration, create a .mcp.json file in your project root.  

Using the `.mcp.json` file allows you to:
- Configure MCP servers per project
- Share configuration safely with team members
- Override global Claude Code MCP settings
- Use an .env file to prevent secrets being added to source

Example .env file

```bash
UMBRACO_CLIENT_ID=umbraco-back-office-mcp
UMBRACO_CLIENT_SECRET=1234567890
UMBRACO_BASE_URL=http://localhost:123456
```

Example .mcp.json file

```json
{
  "mcpServers": {
    "umbraco-mcp": {
      "command": "npx",
      "args": ["@umbraco-cms/mcp-dev@beta"],
    }
  }
}
```

For details on .env format and supported configuration keys, see the [Configuration guide](../configuration.md).

{% hint style="warning" %}
Never commit live credentials to source control. Always use environment variables or a .env file.
{% endhint %}

## Easier tool and tool collection management 

Another benefit of using a .env file for configuration is that it makes it much easier to adjust tool configurations for different tasks.
Claude Code lets you quickly reconnect to an MCP server using its slash commands, so you can switch environments or update settings without editing your main configuration files.

- Update the .env file with the new tools set
- In Claude Code CLI use **/mcp reconnect umbraco-mcp** to restart the mcp server 

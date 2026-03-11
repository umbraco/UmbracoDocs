---
description: "Host set up for Claude Code"
---

# Claude Code Setup

[Claude Code](https://www.claude.com/product/claude-code) is a developer-focused agentic CLI (command line interface) tool from Anthropic. It integrates Claude's large language models (LLMs) directly into your terminal window. This allows you to explore, refactor, and generate code within your projects.

## Getting started

Installing Claude Code depends on your environment. For installation details, see the [Claude Code Quickstart Guide](https://code.claude.com/docs/en/quickstart).


### Configuration using the CLI tool

1. Add the Umbraco MCP server using the Claude CLI:

```bash
claude mcp add umbraco-mcp npx @umbraco-cms/mcp-dev@17.1
```

2. Define configuration values directly using this pattern:

```bash

# Add with environment variables
claude mcp add umbraco-mcp --env UMBRACO_CLIENT_ID="your-id" --env UMBRACO_CLIENT_SECRET="your-secret" --env UMBRACO_BASE_URL="https://your-domain.com" --env NODE_TLS_REJECT_UNAUTHORIZED="0" --env UMBRACO_INCLUDE_TOOL_COLLECTIONS="document,media,document-type,data-type" -- npx @umbraco-cms/mcp-dev@17.1
```

Replace the following values with your local connection details:

- `UMBRACO_CLIENT_ID`
- `UMBRACO_CLIENT_SECRET`
- `UMBRACO_BASE_URL`
- `UMBRACO_INCLUDE_TOOL_COLLECTIONS`

This command registers the MCP server as `umbraco-mcp` in your project’s `claude.json` configuration file.

3. Check which MCP servers are currently active in your Claude Code environment:

```cs
claude mcp list
```

{% endhint %}

### Project-specific configuration via `.mcp.json`

This is the referred project-level configuration for Claude Code. Creating a `.mcp.json` file in your project root allows you to:  

- Configure MCP servers per project.
- Share configuration safely with team members.
- Override global Claude Code MCP settings.
- Use an `.env` file to prevent secrets being added to source.

#### Example `.env` file

```bash
UMBRACO_CLIENT_ID=umbraco-back-office-mcp
UMBRACO_CLIENT_SECRET=1234567890
UMBRACO_BASE_URL=http://localhost:123456
UMBRACO_INCLUDE_TOOL_COLLECTIONS=document,media,document-type,data-type
```

Replace the `UMBRACO_CLIENT_ID`, `UMBRACO_CLIENT_SECRET`, `UMBRACO_BASE_URL` and `UMBRACO_INCLUDE_TOOL_COLLECTIONS` values with your local connection details.

#### Example `.mcp.json` file

```json
{
  "mcpServers": {
    "umbraco-mcp": {
      "command": "npx",
      "args": ["@umbraco-cms/mcp-dev@17.1"],
    }
  }
}
```

For details on `.env` format and supported configuration keys, see the [Configuration guide](../configuration.md).

{% hint style="warning" %}
Never commit live credentials to source control. Always use environment variables or a `.env` file.
{% endhint %}

## Managing tools and tool collections

Another benefit of using a `.env` file for configuration is that it makes it much easier to adjust tool configurations for different tasks. Claude Code lets you quickly reconnect to an MCP server using its slash commands. This allows you to switch environments or update settings without editing your main configuration files.

Steps to reconnect an MCP server:

- Update the `.env` file with the new tool set.
- In the Claude Code CLI, run `/mcp reconnect umbraco-mcp` to restart the mcp server.

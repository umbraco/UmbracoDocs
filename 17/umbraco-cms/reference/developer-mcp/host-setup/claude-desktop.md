---
description: "Host set up for Claude Desktop"
---

# Claude Desktop Setup

[Claude Desktop](https://www.anthropic.com/claude/desktop) is Anthropic's AI-powered assistant for macOS and Windows. It is designed to help you work conversationally across all kinds of tasks from writing and brainstorming to coding and automation.

## Getting started

1. Download and install the [Claude.ai desktop app](https://claude.ai/download).  

2. Go to **Settings** → **Developer** → **Edit Config** to edit the MCP settings,.

![MCP Panel](../images/Claude%20Desktop.png)

3. Open the JSON configuration file in your preferred text editor.
4. Add the following snippet.  

```bash
{
  "mcpServers": 
  {
    "umbraco-mcp": 
    {
      "command": "npx",
      "args": ["@umbraco-cms/mcp-dev@17"],
      "env": 
      {
        "NODE_TLS_REJECT_UNAUTHORIZED": "0",
        "UMBRACO_CLIENT_ID": "umbraco-back-office-mcp",
        "UMBRACO_CLIENT_SECRET": "1234567890",
        "UMBRACO_BASE_URL": "https://localhost:12345",
        "UMBRACO_INCLUDE_TOOL_COLLECTIONS": "document,media,document-type,data-type"
      }
    }
  }
}
```

5. Replace the `UMBRACO_CLIENT_ID`, `UMBRACO_CLIENT_SECRET`, and `UMBRACO_BASE_URL` values with your local connection details.

6. Restart Claude to activate the new configuration.

7. Open the logs and review the `mcp-server-umbraco-mcp.log` file if you encounter a connection error. This file contains details on how to resolve the issue.

{% hint style="info" %}
A paid version of Claude.ai will have a higher token limit and can run more complex prompts.
{% endhint %}

8. [Choose the tools or tool collections](../available-tools.md) to enable your first task.

You will need to restart Claude Desktop every time you make a change to the tools you are using.

## Node version mismatch

Occasionally, Claude Desktop may choose to use the wrong version of `Node.js` when running the MCP Server. A minimum of `Node.js` version 22 is required. This issue most commonly occurs when using a `Node.js` version manager such as `nvm`. Claude Desktop can sometimes default to the lowest installed version rather than the active one set by `nvm`.

To fix this, remove all older `Node.js` versions, leaving only `Node.js` version 22 or higher installed. This behaviour appears to be specific to Claude Desktop and does not affect any other AI hosts.

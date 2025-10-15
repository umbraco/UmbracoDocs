---
description: "Host set up for Claude Desktop"
---

# Claude Desktop

[Claude Desktop](https://www.anthropic.com/claude/desktop) is Anthropic’s AI-powered assistant for macOS and Windows, designed to help you work conversationally across all kinds of tasks — from writing and brainstorming to coding and automation.

## Getting started 

First download and install the [Claude.ai desktop app](https://claude.ai/download).  

To edit the MCP settings, go to Settings → Developer → Edit Config.
Open the JSON configuration file in your preferred text editor and add the following snippet. Replace the UMBRACO_CLIENT_ID, UMBRACO_CLIENT_SECRET, and UMBRACO_BASE_URL values with your local connection details.

The NODE_TLS_REJECT_UNAUTHORIZED environment flag is included to allow Claude Desktop to connect to the MCP Server when using a self-signed certificate.


```bash
{
  "mcpServers": 
  {
    "umbraco-mcp": 
    {
      "command": "npx",
      "args": ["@umbraco-cms/mcp-dev@beta"],
      "env": 
      {
        "NODE_TLS_REJECT_UNAUTHORIZED": "0",
        "UMBRACO_CLIENT_ID": "umbraco-back-office-mcp",
        "UMBRACO_CLIENT_SECRET": "1234567890",
        "UMBRACO_BASE_URL": "https://localhost:12345"
      }
    }
  }
}
```

Restart Claude to activate the new configuration.
When the Umbraco MCP Server starts, you’ll be prompted to allow access for each of the available tools.

If you encounter a connection error, open the logs and review the file named mcp-server-umbraco-mcp.log for details on how to resolve the issue.

> [!NOTE]
> You may need to update to a paid version of Claude.ai in order to have a large enough context window to run your prompts.

## Node version mismatch

Occasionally, Claude Desktop may use the wrong version of Node.js when running the MCP Server.
A minimum of Node.js version 22 is required. This issue most commonly occurs when using a Node.js version manager such as nvm, as Claude Desktop can sometimes default to the lowest installed version rather than the active one set by nvm.

Unfortunately, the only reliable fix is to remove all older Node.js versions, leaving only version 22 or higher installed.
This behaviour appears to be specific to Claude Desktop and does not affect other AI hosts.

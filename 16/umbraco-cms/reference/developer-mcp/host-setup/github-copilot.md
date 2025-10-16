---
description: "Host set up for GitHub Copilot"
---

# GitHub Copilot Setup

[GitHub Copilot](https://github.com/features/copilot) is an AI-powered coding assistant developed by GitHub and OpenAI. It works as an extension to Visual Studio Code, enhancing your editor with intelligent code suggestions and natural language capabilities.

## Getting started 

#### Click the button to install:
[<img src="https://img.shields.io/badge/VS_Code-VS_Code?style=flat-square&label=Install%20Server&color=0098FF" alt="Install in VS Code">](https://insiders.vscode.dev/redirect?url=vscode%3Amcp%2Finstall%3F%7B%22name%22%3A%22umbraco-mcp%22%2C%22command%22%3A%22npx%22%2C%22args%22%3A%5B%22%40umbraco-cms%2Fmcp-dev%40beta%22%5D%2C%22env%22%3A%7B%22NODE_TLS_REJECT_UNAUTHORIZED%22%3A%220%22%2C%22UMBRACO_CLIENT_ID%22%3A%22%3CAPI%20user%20name%3E%22%2C%22UMBRACO_CLIENT_SECRET%22%3A%22%3CAPI%20client%20secert%3E%22%2C%22UMBRACO_BASE_URL%22%3A%22https%3A%2F%2F%3Cdomain%3E%22%2C%22UMBRACO_EXCLUDE_TOOLS%22%3A%22%3Ctoolname%3E%2C%3Ctoolname%3E%22%7D%7D)

**Requirements:** VS Code 1.101+ with GitHub Copilot Chat extension installed.

Or install manually:
Follow the MCP [install guide](https://code.visualstudio.com/docs/copilot/customization/mcp-servers#_add-an-mcp-server), use this config.

Don't forget to replace the UMBRACO_CLIENT_ID, UMBRACO_CLIENT_SECRET, and UMBRACO_BASE_URL values with your local connection details.

## Getting started

Once you’ve added your MCP Server and updated the JSON configuration, restartins and managing the server is simple.

![MCP Control](../images/GitHub%20Coplot.png)

{% hint style="info" %}
Restarting the MCP Server applies any configuration or tool changes immediately without needing to reinstall or re-add the server.
{% endhint %}

From here, you should [choose which tools or tool collections](../mcp-toolkit.md) you want to enable for your first task.
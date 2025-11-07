---
description: Get started with the Umbraco CMS Developer Model Context Protocol (MCP).
---

# Developer Model Context Protocol (MCP) Server

The Developer [MCP Server](./concepts/model-context-protocol.md#mcp-servers) makes it straightforward for developers to connect AI tools with Umbraco. It allows you to harness large language models (LLMs) to perform almost any task that can be achieved within the Umbraco backoffice. This includes generating and editing content, managing media, automating workflows, and assisting with complex development tasks.

This MCP Server acts as a secure gateway between your Umbraco installation and MCP-compatible AI environments. These include Claude (Desktop or Code), Cursor, GitHub Copilot, and many more.

Through this bridge, your AI assistant can interact directly with the Umbraco Management API. This enables a more natural, conversational way to develop and maintain your sites.

{% hint style="info" %}
Think of it as giving your AI tools a secure, structured way to “speak to Umbraco.”
{% endhint %}

## How it works

Unlike most Umbraco integrations, the Developer MCP Server is not a plugin that you install into your Umbraco site. Instead, it runs as a standalone Node.js application that acts as an MCP Server.

[MCP clients](./concepts/model-context-protocol.md#mcp-clients) are implemented inside compatible [host applications](./concepts/model-context-protocol.md#host-applications) such as Claude Desktop, Cursor, or Windsurf. These clients connect to the server. When you interact with your chat-based development environment, the client communicates with the MCP Server using the Model Context Protocol (MCP).

Learn more about [Model Context Protocol (MCP)](./concepts/model-context-protocol.md).

The MCP Server, in turn, talks directly to Umbraco through the Management API. This is the same API layer that powers the Umbraco backoffice and allows the server to directly read from and modify the CMS.

By exposing these endpoints as MCP tools, the Developer MCP Server enables you to perform almost any backoffice action. You can do this through natural language interaction with your LLM-powered chat environment.

{% hint style="info" %}
The MCP Server acts as the bridge between your Umbraco instance and your AI assistant. It translates and adapts your tasks into Management API calls.
{% endhint %}

## Intended audience

The Developer MCP Server is designed specifically to be used by Umbraco developers.

The Model Context Protocol (MCP) can be used for many types of solution, automation, and workflow integrations. This particular MCP Server focuses on developer-oriented tasks and productivity enhancements within Umbraco projects.

Example use cases:

- **Automation of content, media, and schema**

Automate repetitive actions through conversational commands. This includes creating or updating content or media, generating content models, or performing large-scale operations.

- **Developer quality-of-life improvements**

Speed up tasks that would otherwise take time or require numerous clicks in the backoffice UI. Examples include batch-moving Document Types or Data Types, cleaning up unused entities, or synchronizing content structures.

- **Integration into modern development workflows**

Use the Developer MCP Server alongside other MCP Servers such as Playwright MCP, Figma MCP, or GitHub MCP. This streamlines your end-to-end site development process.

- **Leveraging LLM reasoning**

Use an LLM to understand, debug, or make better decisions. For example, ask it to interpret entries from Umbraco Logs, suggest schema changes, or explain configuration errors.

- [**And many more**](./scenarios.md)

**Not recommended for non-developers**

While it’s technically feasible for non-developers to connect to Umbraco using this MCP Server, it is not recommended for the following reasons:

- **Complex setup requirements**

This MCP server must run locally and it requires a configured Umbraco user account with appropriate permissions.

- **Powerful tool access**

Even for users with limited permissions, the MCP Server exposes many management-level tools. Incorrect commands could unintentionally alter or damage your Umbraco instance.

{% hint style="warning" %}
Do not connect the Developer MCP Server to a production Umbraco environment. Always use a local or isolated development instance.
{% endhint %}

Additional MCP servers tailored to other roles such as editors and content managers are in development. These will provide safer, simplified toolsets and workflows.

## Getting started

### Umbraco Setup

Before connecting the MCP Server, you need to create an [API User](../../fundamentals/data/users/api-users.md) in Umbraco. This user allows the MCP Server to communicate securely with the Management API.

The level of access you assign to this API user determines what actions your AI agent can perform:

- **Editor permissions:** Manage and update content but cannot modify Document Types or perform administrative tasks.
- **Administrator permissions:** Full access including the ability to create, edit, or delete Document Types, Data Types, and more within Umbraco.

{% hint style="warning" %}
Only use a dedicated API user for MCP connections. Do not share or reuse credentials from an existing backoffice user.
{% endhint %}

### Host Setup

Each MCP-compatible host application has its own setup process. Below you can find dedicated setup guides for the main developer environments seen most often:

- [Claude Desktop](./host-setup/claude-desktop.md)  
- [Claude Code](./host-setup/claude-code.md)  
- [GitHub Copilot](./host-setup/github-copilot.md)  
- [Cursor](./host-setup/cursor.md)  

Although the details vary slightly, the general pattern is the same across all hosts:

``` json
{
  "umbraco-mcp": {
    "command": "npx",
    "args": ["@umbraco-cms/mcp-dev@beta"],
    "env": {
      "NODE_TLS_REJECT_UNAUTHORIZED": "0",
      "UMBRACO_CLIENT_ID": "umbraco-back-office-mcp",
      "UMBRACO_CLIENT_SECRET": "1234567890",
      "UMBRACO_BASE_URL": "https://localhost:12345",
      "UMBRACO_INCLUDE_TOOL_COLLECTIONS": "document,media,document-type,data-type"
    }
  }
}

```

Add your Umbraco MCP configuration values (Client ID, Client Secret, and Umbraco URL) in the appropriate section of your host setup. Then restart the MCP Server or, in some cases, restart the host application.

Once restarted, you’ll have access to the full suite of tools available through the Umbraco CMS Developer MCP Server.

{% hint style="info" %}
This Developer MCP Server requires `Node.js` version 22 or higher. Check your current `Node.js` version by running `node -v` in your terminal.
{% endhint %}

#### Never Use Against Production Environments

{% hint style="danger" %}
**Critical: Do not connect the Developer MCP Server to a production Umbraco environment.**

The Developer MCP Server provides powerful, direct access to your Umbraco Management API. While this makes it a good tool for development and testing, mistakes can have serious consequences. Misconfigurations or misunderstood commands can cause immediate and potentially destructive damage.

**Always use the Developer MCP Server with:**

- Local development instances only
- Isolated staging or test environments
- Environments where data loss or corruption would not impact live users or business operations

**Never connect to:**

- Production websites
- Live client sites
- Any environment where content, media, or configuration changes could affect real users

Even with limited user permissions, the scope and power of LLM-driven actions make this tool unsuitable for production use.
{% endhint %}

### Choosing Your Tools

Your first step after setup should be deciding which tools you want to enable. All tools are grouped into collections for easier management and isolation. [Learn more about Tool Collections](./available-tools.md).

Choosing the right tools improves how efficiently the AI communicates with Umbraco, making each conversation faster and more context-aware. [Learn more about Context Engineering](./concepts/context-enginerring.md).

### Using npx?

It is recommended to launch the Developer MCP Server using npx. This allows you to run the `Node.js` application without needing to install anything globally.
npx will temporarily download the package, execute it, and clean up automatically, ensuring you’re always using the latest version.

If you prefer, you can also install it globally with:

``` bash

npm install -g @umbraco/mcp-server

```

For advanced configuration options and environment variable settings, see the [Configuration guide](./configuration.md).

## Working with the MCP Server

Once your MCP Server is configured and connected, explore these guides to get the most out of your setup:

- [Creating Media](best-practice/creating-media.md) - Learn how to upload and manage media items programmatically.
- [Available Tools](./available-tools.md) - Complete reference of all available tools and collections.
- [Scenarios](./scenarios.md) - Real-world examples and use cases.
- [Best Practices](./best-practice/README.md) - Tips for effective MCP usage.

## Version Compatibility

The Umbraco MCP Server is designed to work with specific major versions of Umbraco CMS:

| MCP Server Version | Compatible Umbraco Version | NPM Package Name                     |
|--------------------|----------------------------|--------------------------------------|
| 15.x.x             | alpha                      | @umbraco-mcp/umbraco-mcp-cms@alpha   |
| 16.x.x             | all betas, 16.x            | @umbraco-cms/mcp-dev@beta            |

### Version Checking

The MCP server automatically checks version compatibility on startup:

- **✅ Version Match**: No message displayed, server functions normally.
- **⚠️ Version Mismatch**: The first tool request fails with an error message prompting a retry. After retrying, the warning displays once more and is then suppressed for the rest of the session.
- **⚠️ API Error**: If the version check API call fails, a warning is displayed once but does not block tool execution.

The version check uses the Umbraco Management API endpoint `/umbraco/management/api/v1/server/information` to detect the connected Umbraco version and compares the major version number.

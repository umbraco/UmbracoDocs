---
description: Get started with the CMS developer MCP.
---

# Developer Model Context Protocol (MCP) server

The Developer [MCP Server](./concepts/model-context-protocol.md#mcp-servers) makes it easy for developers to connect AI tools with Umbraco. It allows you to harness large language models (LLMs) to perform almost any task that can be achieved within the Umbraco backoffice — from generating and editing content to managing media, automating workflows, and assisting with complex development tasks.

This MCP Server acts as a secure gateway between your Umbraco installation and MCP-compatible AI environments such as Claude (Desktop or Code), Cursor, or GitHub Copilot. Through this bridge, your AI assistant can interact directly with Umbraco’s Management API, enabling a more natural, conversational way to develop and maintain your sites.

{% hint style="info" %}
Think of it as giving your AI tools a secure, structured way to “speak to Umbraco.”
{% endhint %}

## How does it work

Unlike most Umbraco integrations, the Developer CMS MCP Server is not a plugin that you install into your Umbraco site.
Instead, it runs as a standalone Node.js application that acts as an MCP server.

[MCP clients](./concepts/model-context-protocol.md#mcp-clients)—implemented inside compatible [host applications](./concepts/model-context-protocol.md#host-applications) such as Claude Desktop, Cursor, or Windsurf—connect to this server. When you interact with your chat-based development environment, the client communicates with the MCP Server using the Model Context Protocol (MCP).

Learn more about [Model Context Protocol (MCP)](./concepts/model-context-protocol.md)

The MCP Server, in turn, talks directly to Umbraco through the Management API. This is the same API layer that powers the Umbraco backoffice, allowing it to read from and modify the CMS.

By exposing these endpoints as MCP tools, the Developer MCP Server enables you to perform almost any backoffice action through natural language interaction with your LLM-powered chat environment.

{% hint style="info" %}
The MCP Server acts as the bridge between your Umbraco instance and your AI assistant, translating and adapting your tasks into Management API calls.
{% endhint %}

## Who is this for?

**The Developer MCP Server is designed specifically to be used by Umbraco developers.**

While the Model Context Protocol (MCP) can be used for many types of solution, automation, and workflow integrations. This particular MCP Server focuses on developer-oriented tasks and productivity enhancements within Umbraco projects.

Example use cases

- **Automation of content, media and schema**  
Automate repetitive actions such as creating or updating content or media, generating content models, or performing large-scale content or media operations directly through conversational commands.

- **Developer quality-of-life improvements**  
Speed up tasks that would otherwise take time or require numerous clicks in the backoffice UI. For example, batch-moving Document Types or Data Types, cleaning up unused entities, or synchronising content structures across environments.

- **Integration into modern development workflows**  
Use the Developer MCP Server alongside other MCP servers such as Playwright MCP, Figma MCP, or GitHub MCP to streamline your end-to-end site development process.

- **Leveraging LLM reasoning**  
Use your LLM to understand, debug, or make better decisions. For example, ask it to interpret entries from Umbraco Logs, suggest schema changes, or explain configuration errors.

- [**plus many, many more**](./scenarios.md)

**Not recommended for non-developers**

While it’s technically feasible for non-developers to connect to Umbraco using this MCP server, we do not recommend it for the following reasons:

- **Complex setup requirements**  
This MCP server must be run locally, and it requires a configured Umbraco user account with appropriate permissions.

- **Powerful tool access**  
Even for users with limited permissions, the MCP Server exposes many management-level tools. Incorrect commands could unintentionally alter or damage your Umbraco instance.

{% hint style="warning" %}
Do not connect the Developer MCP Server to a production Umbraco environment.   
Always use a local or isolated development instance.
{% endhint %}

We are actively working on additional MCP servers tailored to other roles—such as editors and content managers—that will provide safer, simplified toolsets and workflows.

## Getting started

### Umbraco Setup

Before connecting the MCP Server, you need to create an [API User](../../fundamentals/data/users/api-users.md) in Umbraco. This user allows the MCP Server to communicate securely with the Management API.

The level of access you assign to this API user determines what actions your AI agent can perform.
For example:

- A user with Editor permissions can manage and update content but cannot modify Document Types or perform administrative tasks.
- A user with Administrator permissions grants full access — including the ability to create, edit, or delete document types, data types and more within Umbraco.

{% hint style="warning" %}
Only use a dedicated API user for MCP connections.   
Do not share or reuse credentials from an existing backoffice user.
{% endhint %}

### Host Setup

Each MCP-compatible host application has its own setup process. For this reason, we provide dedicated setup guides for the main developer environments we see most often:

[Claude Desktop](./host-setup/claude-desktop.md)  
[Claude Code](./host-setup/claude-code.md)  
[GitHub Copilot](./host-setup/github-copilot.md)  
[Cursor](./host-setup/cursor.md)  

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

Add your Umbraco MCP configuration values (Client ID, Client Secret, URL of umbraco) in the appropriate section of your host setup, then restart the MCP Server — or in some cases, restart the host application itself.

Once restarted, you’ll have access to the full suite of tools available through the Umbraco CMS Developer MCP Server.

{% hint style="info" %}
This Developer MCP Server requires Node.js version 22 or higher to be installed.  
You can check your current Node.js version by running node -v in your terminal.
{% endhint %}

#### Never Use Against Production Environments

{% hint style="danger" %}
**Critical: Do not connect the Developer MCP Server to a production Umbraco environment.**

The Developer MCP Server provides powerful, direct access to your Umbraco Management API. While this makes it an excellent tool for development and testing, it also means that mistakes, misconfigurations, or misunderstood commands can have immediate and potentially destructive consequences.

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

Your first step after setup should be deciding which tools you want to enable.
All tools are grouped into collections for easier management and isolation.

[Learn more about Tool Collections](./available-tools.md)

Choosing the right tools improves how efficiently the AI communicates with Umbraco, making each conversation faster and more context-aware.

[Learn more about Context Engineering](./concepts/context-enginerring.md)

### Why Use npx?

We recommend launching the Developer MCP Server using npx.
This allows you to run the Node.js application without needing to install anything globally.
npx will temporarily download the package, execute it, and clean up automatically — ensuring you’re always using the latest version.

If you prefer, you can also install it globally with:

``` bash

npm install -g @umbraco/mcp-server

```

For advanced configuration options and environment variable settings, see the [Configuration guide](./configuration.md).

## Working with the MCP Server

Once your MCP server is configured and connected, explore these guides to get the most out of your setup:

- [Creating Media](./creating-media.md) - Learn how to upload and manage media items programmatically
- [Available Tools](./available-tools.md) - Complete reference of all available tools and collections
- [Scenarios](./scenarios.md) - Real-world examples and use cases
- [Best Practices](./best-practice/README.md) - Tips for effective MCP usage

## Version Compatibility

The Umbraco MCP Server is designed to work with specific major versions of Umbraco CMS:

| MCP Server Version | Compatible Umbraco Version | NPM Package Name                     |
|--------------------|----------------------------|--------------------------------------|
| 15.x.x             | alpha                      | @umbraco-mcp/umbraco-mcp-cms@alpha   |
| 16.x.x             | all betas, 16.x            | @umbraco-cms/mcp-dev@beta            |

### Version Checking

The MCP server automatically checks version compatibility on startup:

- **✅ Version Match**: No message displayed, server functions normally
- **⚠️ Version Mismatch**: The first tool request will fail with an error message asking you to retry if you want to proceed. After you retry, the warning is displayed once more and then never shown again for that session.
- **⚠️ API Error**: If the version check API call fails, a warning is displayed once but does not block tool execution.

The version check uses the Umbraco Management API endpoint `/umbraco/management/api/v1/server/information` to detect the connected Umbraco version and compares the major version number.


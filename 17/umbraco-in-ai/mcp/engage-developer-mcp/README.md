---
description: Get started with the Umbraco Engage Developer Model Context Protocol (MCP).
---

# Engage Developer MCP Server

The Engage Developer [MCP Server](../../concepts/model-context-protocol.md#mcp-servers) makes it straightforward for developers to connect AI tools with Umbraco Engage. It gives large language models (LLMs) access to Engage's marketing, analytics, and personalization capabilities. This includes running A/B tests, querying analytics, managing personas and segments, configuring campaigns and goals, and inspecting visitor profiles.

Like the [CMS Developer MCP Server](../cms-developer-mcp/README.md), this MCP Server acts as a secure gateway between your Umbraco installation and MCP-compatible AI environments. These include Claude (Desktop or Code), Cursor, and GitHub Copilot. It talks directly to the Umbraco Engage Management API, the same API layer that powers the Engage backoffice sections.

{% hint style="info" %}
The Engage Developer MCP Server automatically chains to the [CMS Developer MCP Server](../cms-developer-mcp/README.md), proxying its tools with a `cms:` prefix.

This gives your AI agent access to both Engage and CMS capabilities in a single session. It is useful when personalization rules, A/B tests, or campaigns need to reference real documents, media, or content types.

See [Configuration Options](configuration.md#cms-mcp-server-chaining) to learn more, or to disable it.
{% endhint %}

## Requirements

* An Umbraco installation with **Umbraco Engage** installed and licensed
* An [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) with access to the **Engage** section, and to **Content** (or other sections) if you plan to use the chained CMS tools
* `Node.js` version 22 or higher

## Intended audience

Like the CMS Developer MCP Server, this MCP Server is designed to be used by Umbraco developers. It focuses on developer-oriented tasks and productivity enhancements around Engage's marketing and analytics features rather than general end-user workflows.

Example use cases:

* **Analyzing and reporting on visitor behavior** - Ask an LLM to summarize analytics trends, goal completions, or A/B test results in plain language.
* **Automating campaign and personalization setup** - Create segments, personas, applied personalization rules, and A/B tests through conversational commands instead of clicking through the backoffice.
* **Combining Engage and CMS context** - Use the chained `cms:` tools to look up real documents, media, or content types while configuring Engage features that target them.
* **Integrating into modern development workflows** - Use the Engage Developer MCP Server alongside other MCP servers such as Playwright MCP or GitHub MCP.

**Not recommended for non-developers**

As with the CMS Developer MCP Server, this server exposes powerful, direct access to the Engage Management API. Incorrect commands could unintentionally alter analytics configuration, tracking behavior, or personalization rules.

{% hint style="warning" %}
Do not connect the Engage Developer MCP Server to a production Umbraco environment. Always use a local or isolated development instance.
{% endhint %}

## Getting started

### Umbraco Setup

Before connecting the MCP Server, create an [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) in Umbraco. Grant this user access to the **Engage** section, plus any additional sections (such as **Content**) reached through the chained CMS tools.

{% hint style="warning" %}
Only use a dedicated API user for MCP connections. Do not share or reuse credentials from an existing backoffice user.
{% endhint %}

### Host Setup

Each MCP-compatible host application has its own setup process. See the [Local MCP Setup](../local-mcp-setup/README.md) guides for the main developer environments: Claude Desktop, Claude Code, Cursor, GitHub Copilot, and OpenAI Codex.

The same setup pattern applies here, using the Engage server's package instead of the CMS one:

```json
{
  "mcpServers": {
    "umbraco-engage": {
      "command": "npx",
      "args": ["umbraco-engage-editor-mcp"],
      "env": {
        "NODE_TLS_REJECT_UNAUTHORIZED": "0",
        "UMBRACO_CLIENT_ID": "your-api-user-id",
        "UMBRACO_CLIENT_SECRET": "your-api-secret",
        "UMBRACO_BASE_URL": "https://localhost:{port}"
      }
    }
  }
}
```

Restart your MCP client after saving the configuration.

### Choosing Your Tools

Your first step after setup should be deciding which tools you want to enable. Tools are grouped into collections, and collections into modes, for easier management and isolation. See [Available Tools](available-tools.md) to learn more.

Choosing the right tools improves how efficiently the AI communicates with Umbraco Engage, making each conversation faster and more context-aware. Learn more about [Context Engineering](../../concepts/context-engineering.md).

For advanced configuration options and environment variable settings, see the [Configuration guide](configuration.md).

#### Never Use Against Production Environments

{% hint style="danger" %}
**Critical: Do not connect the Engage Developer MCP Server to a production Umbraco environment.**

The Engage Developer MCP Server provides powerful, direct access to your Umbraco Engage Management API - and, through chaining, to the CMS Management API as well. Misconfigurations or misunderstood commands can cause immediate and potentially destructive damage to analytics data, tracking configuration, or content.

**Always use the Engage Developer MCP Server with:**

* Local development instances only
* Isolated staging or test environments
* Environments where data loss or corruption would not impact live users or business operations

**Never connect to:**

* Production websites
* Live client sites
* Any environment where content, analytics, or configuration changes could affect real users
{% endhint %}

## Working with the MCP Server

Once your MCP Server is configured and connected, explore these guides to get the most out of your setup:

* [Available Tools](available-tools.md) - Complete reference of all available tool collections and the tools within them.
* [Configuration Options](configuration.md) - Modes, slices, and CMS MCP server chaining.
* [Excluded Tools](excluded-tools.md) - Endpoints intentionally not exposed as tools, and why.
* [Skills & CLI](skills-and-cli.md) - The Claude Code plugin's skills, and running the server as a CLI tool.

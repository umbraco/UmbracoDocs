---
description: Get started with the Umbraco Forms Developer Model Context Protocol (MCP).
---

# Forms Developer MCP Server

The Forms Developer [MCP Server](../../concepts/model-context-protocol.md#mcp-servers) connects AI tools with Umbraco Forms. It gives large language models (LLMs) access to Forms' authoring, data, and reporting capabilities. This includes building and editing forms, managing data sources and prevalue sources, working with submitted entries, and querying submission analytics.

Like the [CMS Developer MCP Server](../cms-developer-mcp/README.md), this MCP Server acts as a secure gateway between your Umbraco installation and MCP-compatible AI environments. These include Claude (Desktop or Code), Cursor, and GitHub Copilot. The server talks directly to the Umbraco Forms Management API, the same API layer that powers the Forms section of the backoffice.

{% hint style="info" %}
The Forms Developer MCP Server is in beta. Tools and configuration options can change between releases.
{% endhint %}

{% hint style="info" %}
The Forms Developer MCP Server automatically chains to the [CMS Developer MCP Server](../cms-developer-mcp/README.md), proxying its tools with a `cms--` prefix.

This gives your AI agent access to both Forms and CMS capabilities in a single session. Chaining is useful when you work with forms and content together, such as adding a new form to a content page.

See [Configuration Options](configuration.md#cms-mcp-server-chaining) to learn more, or to disable it.
{% endhint %}

## Requirements

* An Umbraco 18 installation with **Umbraco Forms** 18 installed
* An [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) with access to the **Forms** section, and to **Content** (or other sections) if you plan to use the chained CMS tools
* `Node.js` version 22 or higher

### Umbraco Forms Version Support

The Forms Developer MCP Server has a separate release line for each Umbraco major version. Install the package that matches the Umbraco version of your site:

| Umbraco | Umbraco Forms | Package |
| --- | --- | --- |
| 17 | 17.x | `@umbraco-forms/mcp-dev@lts-17-beta` |
| 18 | 18.x | `@umbraco-forms/mcp-dev` |

This article covers the Umbraco 18 line. For an Umbraco 17 site, install `@umbraco-forms/mcp-dev@lts-17-beta` and follow the Umbraco 17 version of this documentation.

When the server starts, it checks the Umbraco version of the connected instance. If the major version does not match, the first tool call returns a warning instead of running. See [Configuration Options](configuration.md#version-check) for details.

All Umbraco Forms 18.x releases are supported. `get-member-linkable-properties` and `get-member-form-summaries` need Umbraco Forms 18.1 or later. On Umbraco Forms 18.0, these two tools return an error that names the version they need. All other tools work as normal.

## Intended audience

Like the CMS Developer MCP Server, this MCP Server is designed to be used by Umbraco developers. It focuses on developer-oriented tasks and productivity enhancements around Umbraco Forms rather than general end-user workflows.

Example use cases:

* **Building forms from a description** - Describe a form in plain language and let an LLM create it. This works for anything from a contact form to a multi-page design with conditions and workflows.
* **Reviewing and reporting on submissions** - Search submitted entries, summarize submission trends, and find workflows that failed.
* **Managing data sources and prevalue sources** - Set up the sources that populate form fields, and preview the values they return.
* **Testing forms end to end** - Use the Delivery API tools to submit test entries, then check the resulting records and workflow runs.
* **Combining Forms and CMS context** - Use the chained `cms--` tools to look up or update content, media, and members while you work on forms.
* **Integrating into modern development workflows** - Use the Forms Developer MCP Server alongside other MCP servers such as Playwright MCP or GitHub MCP.

**Not recommended for non-developers**

As with the CMS Developer MCP Server, this server exposes powerful, direct access to the Forms Management API. Incorrect commands could unintentionally delete forms, change workflows, or alter submitted entries.

{% hint style="warning" %}
Do not connect the Forms Developer MCP Server to a production Umbraco environment. Always use a local or isolated development instance.
{% endhint %}

## Getting started

### Umbraco Setup

Before connecting the MCP Server, create an [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) in Umbraco. Grant this user access to the **Forms** section, plus any additional sections (such as **Content**) reached through the chained CMS tools.

Umbraco Forms also has its own permissions, such as **Manage Forms** and **View Entries**. Check that the API user has the Forms permissions your tasks need. For more information, see the [Security](https://docs.umbraco.com/umbraco-forms/developer/security) article in the Umbraco Forms documentation.

{% hint style="warning" %}
Only use a dedicated API user for MCP connections. Do not share or reuse credentials from an existing backoffice user.
{% endhint %}

### Host Setup

Each MCP-compatible host application has its own setup process. See the [Local MCP Setup](../local-mcp-setup/README.md) guides for the main developer environments: Claude Desktop, Claude Code, Cursor, GitHub Copilot, and OpenAI Codex.

The same setup pattern applies here, using the Forms server's package instead of the CMS one:

{% code title=".mcp.json" %}

```json
{
  "mcpServers": {
    "umbraco-forms": {
      "command": "npx",
      "args": ["-y", "@umbraco-forms/mcp-dev"],
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

{% endcode %}

`NODE_TLS_REJECT_UNAUTHORIZED` set to `0` allows the self-signed certificate of a local Umbraco instance. The setting turns off certificate verification for the whole process, so only use it against local development instances.

Restart your MCP client after saving the configuration.

### Verify the Connection

You can check the server without connecting an MCP client. The following commands list the available tools and show the resolved configuration, with secrets masked:

```bash
npx -y @umbraco-forms/mcp-dev --list-tools
npx -y @umbraco-forms/mcp-dev --debug-config
```

Both commands print their output and exit without starting the MCP Server. For all introspection commands, see the [CLI Reference](../base-mcp/sdk/cli.md).

### Choosing Your Tools

Your first step after setup should be deciding which tools you want to enable. Tools are grouped into collections, and collections into modes, for easier management and isolation. See [Available Tools](available-tools.md) to learn more.

Choosing the right tools improves how efficiently the AI communicates with Umbraco Forms, making each conversation faster and more context-aware. Learn more about [Context Engineering](../../concepts/context-engineering.md).

For advanced configuration options and environment variable settings, see the [Configuration guide](configuration.md).

#### Never Use Against Production Environments

{% hint style="danger" %}
**Critical: Do not connect the Forms Developer MCP Server to a production Umbraco environment.**

The Forms Developer MCP Server provides powerful, direct access to your Umbraco Forms Management API - and, through chaining, to the CMS Management API as well. Misconfigurations or misunderstood commands can cause immediate and potentially destructive damage to forms, workflows, submitted entries, or content.

Submitted entries often contain personal data. Any entry that the AI agent reads is sent to the AI tool as part of the conversation.

**Always use the Forms Developer MCP Server with:**

* Local development instances only
* Isolated staging or test environments
* Environments where data loss or corruption would not impact live users or business operations

**Never connect to:**

* Production websites
* Live client sites
* Any environment where forms, entries, or configuration changes could affect real users
{% endhint %}

## Working with the MCP Server

Once your MCP Server is configured and connected, explore these guides to get the most out of your setup:

* [Available Tools](available-tools.md) - Complete reference of all available tool collections and the tools within them.
* [Configuration Options](configuration.md) - Modes, slices, the Forms Delivery API, and CMS MCP server chaining.
* [Excluded Tools](excluded-tools.md) - Endpoints intentionally not exposed as tools, and why.

---
description: Get started with the Umbraco Automate Developer Model Context Protocol (MCP).
---

# Automate Developer MCP Server

{% hint style="info" %}
The Automate Developer MCP Server is in beta. Tools and configuration options can change between releases.
{% endhint %}

The Automate Developer [MCP Server](../../concepts/model-context-protocol.md#mcp-servers) connects AI tools with Umbraco Automate. It gives large language models (LLMs) access to Automate's capabilities for building, running, and monitoring automations. This includes building and publishing automations, managing connections and workspaces, inspecting and controlling runs, handling approvals, and rolling back to earlier versions.

Like the [CMS Developer MCP Server](../cms-developer-mcp/README.md), this MCP Server acts as a secure gateway between your Umbraco installation and MCP-compatible AI environments. These include Claude (Desktop or Code), Cursor, and GitHub Copilot. The server talks directly to the Umbraco Automate Management API, the same API layer that powers the Automation section of the backoffice.

{% hint style="info" %}
The Automate Developer MCP Server automatically chains to the [CMS Developer MCP Server](../cms-developer-mcp/README.md), proxying its tools with a `cms--` prefix.

This gives your AI agent access to both Automate and CMS capabilities in a single session. Chaining is useful when automations work with content, such as looking up the documents or Document Types that a trigger or step refers to.

See [Configuration Options](configuration.md#cms-mcp-server-chaining) to learn more, or to disable it.
{% endhint %}

## Requirements

* An Umbraco 18 installation with **Umbraco Automate** 18 installed
* An [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) with access to the **Automation** section, and to **Content** (or other sections) if you plan to use the chained CMS tools
* `Node.js` version 22 or higher

### Umbraco Automate Version Support

The Automate Developer MCP Server has a separate release line for each Umbraco major version. Install the package that matches the Umbraco version of your site:

| Umbraco | Umbraco Automate | Package |
| --- | --- | --- |
| 17 | 17.x | `@umbraco-automate/mcp-dev@lts-17-beta` |
| 18 | 18.x | `@umbraco-automate/mcp-dev` |

This article covers the Umbraco 18 line. For an Umbraco 17 site, install `@umbraco-automate/mcp-dev@lts-17-beta` and follow the Umbraco 17 version of this documentation.

When the server starts, it checks the Umbraco version of the connected instance. If the major version does not match, the first tool call returns a warning instead of running. See [Configuration Options](configuration.md#version-check) for details.

Some features were added in later 18.x minor releases. On an older release, the tools refuse those features with a message, or fall back to an alternative:

| Feature | Minimum Umbraco Automate version | On older versions |
| --- | --- | --- |
| `done` output on While, ForEach, and Parallel steps | 18.3 | `connect-automation-steps` refuses the `done` outcome. Connect steps to the `body` output instead. |
| Webhook URLs reported by Umbraco | 18.4 | `get-automation-webhook-url` builds the URL from `UMBRACO_BASE_URL` and adds a note. |
| `supportsManualRun` on triggers | 18.4 | `list-catalogue-triggers` leaves the field out. |

## Intended audience

Like the CMS Developer MCP Server, this MCP Server is designed to be used by Umbraco developers. It focuses on developer-oriented tasks and productivity enhancements around Umbraco Automate rather than general end-user workflows.

Example use cases:

* **Building automations from a description** - Describe what should happen and when, and let an LLM set the trigger, add the steps, and connect them.
* **Investigating failed runs** - Find failed runs, see which step failed and why, then replay or resume the run once the cause is fixed.
* **Reporting on automation activity** - Summarize run metrics, success rates, and the automations that fail most often.
* **Moving and restoring automations** - Export automations, import them into another workspace, and roll back to earlier versions.
* **Combining Automate and CMS context** - Use the chained `cms--` tools to look up content, media, and members while you build automations.
* **Integrating into modern development workflows** - Use the Automate Developer MCP Server alongside other MCP servers such as Playwright MCP or GitHub MCP.

**Not recommended for non-developers**

As with the CMS Developer MCP Server, this server exposes powerful, direct access to the Automate Management API. Incorrect commands could unintentionally publish automations, start runs with real side effects, or delete automations and their run history.

{% hint style="warning" %}
Do not connect the Automate Developer MCP Server to a production Umbraco environment. Always use a local or isolated development instance.
{% endhint %}

## Getting started

### Umbraco Setup

Before connecting the MCP Server, create an [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) in Umbraco. Grant this user access to the **Automation** section, plus any additional sections (such as **Content**) reached through the chained CMS tools.

Workspaces decide which user groups can view, edit, and run their automations. Make sure the API user belongs to a user group that the relevant workspaces allow. For more information, see the [Workspaces](https://docs.umbraco.com/umbraco-automate/concepts/workspaces) article in the Umbraco Automate documentation.

{% hint style="warning" %}
Only use a dedicated API user for MCP connections. Do not share or reuse credentials from an existing backoffice user.
{% endhint %}

### Host Setup

Each MCP-compatible host application has its own setup process. See the [Local MCP Setup](../local-mcp-setup/README.md) guides for the main developer environments: Claude Desktop, Claude Code, Cursor, GitHub Copilot, and OpenAI Codex.

The same setup pattern applies here, using the Automate server's package instead of the CMS one:

{% code title=".mcp.json" %}

```json
{
  "mcpServers": {
    "umbraco-automate": {
      "command": "npx",
      "args": ["-y", "@umbraco-automate/mcp-dev"],
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
npx -y @umbraco-automate/mcp-dev --list-tools
npx -y @umbraco-automate/mcp-dev --debug-config
```

Both commands print their output and exit without starting the MCP Server. For all introspection commands, see the [CLI Reference](../base-mcp/sdk/cli.md).

### Choosing Your Tools

Your first step after setup should be deciding which tools you want to enable. Tools are grouped into collections, and collections into modes, for easier management and isolation. See [Available Tools](available-tools.md) to learn more.

Choosing the right tools improves how efficiently the AI communicates with Umbraco Automate, making each conversation faster and more context-aware. Learn more about [Context Engineering](../../concepts/context-engineering.md).

For advanced configuration options and environment variable settings, see the [Configuration guide](configuration.md).

#### Never Use Against Production Environments

{% hint style="danger" %}
**Critical: Do not connect the Automate Developer MCP Server to a production Umbraco environment.**

The Automate Developer MCP Server provides powerful, direct access to your Umbraco Automate Management API - and, through chaining, to the CMS Management API as well. Misconfigurations or misunderstood commands can cause immediate and potentially destructive damage to automations, run history, connections, or content.

Triggering or publishing an automation runs its steps for real. Steps that use connections can reach external services, even from a test environment.

**Always use the Automate Developer MCP Server with:**

* Local development instances only
* Isolated staging or test environments
* Environments where data loss or corruption would not impact live users or business operations

**Never connect to:**

* Production websites
* Live client sites
* Any environment where automations, runs, or configuration changes could affect real users
{% endhint %}

## Building an Automation

The automation tools build an automation one piece at a time. The usual order is:

1. List the available triggers and steps with `list-catalogue-triggers` and `list-catalogue-step-types`.
2. Create an empty draft automation in a workspace with `create-automation`.
3. Set what starts the automation with `set-automation-trigger`.
4. Add steps with `add-automation-step`, and connect them with `connect-automation-steps`.
5. Publish the automation with `publish-automation` to make it live.

To start a run manually, use `trigger-automation`.

To copy an existing automation, export it with `export-automation`. Then check the export with `validate-automation-import`, and import it with `import-automation`.

## Working with the MCP Server

Once your MCP Server is configured and connected, explore these guides to get the most out of your setup:

* [Available Tools](available-tools.md) - Complete reference of all available tool collections and the tools within them.
* [Configuration Options](configuration.md) - Modes, slices, the version check, and CMS MCP server chaining.

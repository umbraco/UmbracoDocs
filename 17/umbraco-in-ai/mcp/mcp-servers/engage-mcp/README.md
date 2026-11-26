---
description: Get started with the Umbraco Engage Model Context Protocol (MCP).
---

# Engage MCP Server

The Engage [MCP Server](../../../concepts/model-context-protocol.md#mcp-servers) makes it straightforward for developers to connect AI tools with Umbraco Engage. It gives large language models (LLMs) access to Engage's marketing, analytics, and personalization capabilities. This includes running A/B tests, querying analytics, managing personas and segments, configuring campaigns and goals, and inspecting visitor profiles.

Like the [CMS Developer MCP Server](../cms-developer-mcp/README.md), this MCP Server acts as a secure gateway between your Umbraco installation and MCP-compatible AI environments. These include Claude (Desktop or Code), Cursor, and GitHub Copilot. It talks directly to the Umbraco Engage Management API, the same API layer that powers the Engage backoffice sections.

{% hint style="info" %}
The Engage MCP Server automatically chains to the [CMS Developer MCP Server](../cms-developer-mcp/README.md), proxying its tools with a `cms--` prefix.

This gives your AI agent access to both Engage and CMS capabilities in a single session. It is useful when personalization rules, A/B tests, or campaigns need to reference real documents, media, or content types.

See [Configuration Options](configuration.md#cms-mcp-server-chaining) to learn more, or to disable it.
{% endhint %}

## Requirements

* An Umbraco 17 installation with **Umbraco Engage** 17.5.0 or later installed and licensed
* An [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) with access to the **Engage** section, and to **Content** (or other sections) if you plan to use the chained CMS tools
* `Node.js` 22 (22.23.4 or later), 24 (24.22.1 or later), or 26.12.1 or later. Earlier releases have a known [security vulnerability](https://nodejs.org/en/blog/vulnerability/october-2026-security-releases).

### Umbraco Engage Version Support

The Engage MCP Server has a separate release line for each Umbraco major version. Install the package that matches the Umbraco version of your site:

| Umbraco | Umbraco Engage | Package |
| --- | --- | --- |
| 17 | 17.5.0 or later | `@umbraco-engage/mcp@lts-17` |
| 18 | 18.2.0 or later | `@umbraco-engage/mcp` |

The package was previously published as `@umbraco-engage/mcp-dev`. The command is now `engage-mcp-server` (it was `umbraco-engage-mcp-dev`), so also update any script that runs the old command. If your MCP client configuration still uses the old name, change it to the package in the table.

The Umbraco 17 line is published under the `lts-17` tag. The `latest` tag points to the Umbraco 18 line.

Umbraco Engage changed its Management API in 17.5.0, so the Umbraco 17 line needs Umbraco Engage 17.5.0 or later. From 17.5.0, A/B tests and personalizations reference goals, projects, and segments by key instead of by numeric ID.

When the server starts, it also reads the installed Umbraco Engage version. On an earlier release, the server shows a warning. The A/B test, personalization, analytics query, and related tools then return an error that names the version they need. All other tools work as normal. If the server cannot read the Engage version, it does not block any tools.

## Intended audience

Like the CMS Developer MCP Server, this MCP Server is designed to be used by Umbraco developers. It focuses on developer-oriented tasks and productivity enhancements around Engage's marketing and analytics features rather than general end-user workflows.

Example use cases:

* **Analyzing and reporting on visitor behavior** - Ask an LLM to summarize analytics trends, goal completions, or A/B test results in plain language.
* **Automating campaign and personalization setup** - Create segments, personas, applied personalization rules, and A/B tests through conversational commands instead of clicking through the backoffice.
* **Combining Engage and CMS context** - Use the chained `cms--` tools to look up real documents, media, or content types while configuring Engage features that target them.
* **Integrating into modern development workflows** - Use the Engage MCP Server alongside other MCP servers such as Playwright MCP or GitHub MCP.

**Not recommended for non-developers**

As with the CMS Developer MCP Server, this server exposes powerful, direct access to the Engage Management API. Incorrect commands could unintentionally alter analytics configuration, tracking behavior, or personalization rules.

{% hint style="warning" %}
Do not connect the Engage MCP Server to a production Umbraco environment. Always use a local or isolated development instance.
{% endhint %}

## Getting started

### Umbraco Setup

Before connecting the MCP Server, create an [API User](https://docs.umbraco.com/umbraco-cms/fundamentals/data/users/api-users) in Umbraco. Grant this user access to the **Engage** section, plus any additional sections (such as **Content**) reached through the chained CMS tools.

{% hint style="warning" %}
Only use a dedicated API user for MCP connections. Do not share or reuse credentials from an existing backoffice user.
{% endhint %}

### Host Setup

Each MCP-compatible host application has its own setup process. See the [Local MCP Setup](../../connect-to-an-mcp-server/local-mcp-setup/README.md) guides for the main developer environments: Claude Desktop, Claude Code, Cursor, GitHub Copilot, and OpenAI Codex.

The same setup pattern applies here, using the Engage server's package instead of the CMS one:

```json
{
  "mcpServers": {
    "umbraco-engage": {
      "command": "npx",
      "args": ["-y", "@umbraco-engage/mcp@lts-17"],
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

{% hint style="warning" %}
`NODE_TLS_REJECT_UNAUTHORIZED` set to `0` lets the MCP server accept the self-signed certificate of a local Umbraco. The setting turns off certificate verification for the whole process. Only use it when `UMBRACO_BASE_URL` is `localhost`, `127.0.0.1` or `[::1]`. With any other base URL, the server refuses to start, so remove the setting for a remote site. See [TLS Certificates](../../connect-to-an-mcp-server/local-mcp-setup/tls-certificates.md) for the reasons, and how to keep verification on with `NODE_EXTRA_CA_CERTS`.
{% endhint %}

Restart your MCP client after saving the configuration.

### Choosing Your Tools

Your first step after setup should be deciding which tools you want to enable. Tools are grouped into collections, and collections into modes, for easier management and isolation. See [Available Tools](available-tools.md) to learn more.

Choosing the right tools improves how efficiently the AI communicates with Umbraco Engage, making each conversation faster and more context-aware. Learn more about [Context Engineering](../../../concepts/context-engineering.md).

For advanced configuration options and environment variable settings, see the [Configuration guide](configuration.md).

#### Never Use Against Production Environments

{% hint style="danger" %}
**Critical: Do not connect the Engage MCP Server to a production Umbraco environment.**

The Engage MCP Server provides powerful, direct access to your Umbraco Engage Management API - and, through chaining, to the CMS Management API as well. Misconfigurations or misunderstood commands can cause immediate and potentially destructive damage to analytics data, tracking configuration, or content.

**Always use the Engage MCP Server with:**

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

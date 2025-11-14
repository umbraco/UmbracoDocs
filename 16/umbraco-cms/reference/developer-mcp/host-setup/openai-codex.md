---
description: "Host setup for OpenAI Codex"
---

# OpenAI Codex Setup

[OpenAI Codex](https://openai.com/blog/openai-codex) is OpenAI's terminal-first workspace that pairs a shell, editor, and conversational developer agent. With Model Context Protocol (MCP) support, you can connect Codex directly to Umbraco's tools and data so the assistant can work inside your projects.

## Getting started

Install the Codex CLI with npm:

```bash
npm install -g @openai/codex
```

Or install the Codex CLI with brew:

```bash
brew install codex
```

### Configure using the Codex CLI

Add the Umbraco MCP server with the Codex CLI:

```bash
codex mcp add umbraco-mcp -- npx -y @umbraco-cms/mcp-dev@beta
```

**Define configuration values directly**

If you prefer to keep secrets in your shell session, pass them as environment variables during registration:

```bash
codex mcp add umbraco-mcp \
  --env UMBRACO_CLIENT_ID="your-id" \
  --env UMBRACO_CLIENT_SECRET="your-secret" \
  --env UMBRACO_BASE_URL="https://your-domain.com" \
  --env NODE_TLS_REJECT_UNAUTHORIZED="0" \
  --env UMBRACO_INCLUDE_TOOL_COLLECTIONS="document,media,document-type,data-type" \
  -- npx -y @umbraco-cms/mcp-dev@beta
```

Replace the `UMBRACO_CLIENT_ID`, `UMBRACO_CLIENT_SECRET`, `UMBRACO_BASE_URL`, and `UMBRACO_INCLUDE_TOOL_COLLECTIONS` values with your local connection details.

This command stores the MCP server as `umbraco-mcp` in your Codex configuration file (typically `~/.codex/config.toml`).

{% hint style="info" %}
Use the command below at any time to see which MCP servers Codex is currently loading:

```
codex mcp list
```
{% endhint %}

## Managing tools and tool collections

When you change the tool set:

- Update your `.env` file with the tool collections you want (for example `document,media`).
- Repeat the `codex mcp list` command to confirm that the server is healthy.

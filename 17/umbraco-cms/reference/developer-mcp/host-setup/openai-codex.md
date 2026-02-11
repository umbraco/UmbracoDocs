---
description: "Host setup for OpenAI Codex"
---

# OpenAI Codex Setup

[OpenAI Codex](https://openai.com/blog/openai-codex) is OpenAI's terminal-first workspace that pairs a shell, editor, and conversational developer agent. With Model Context Protocol (MCP) support, you can connect Codex directly to Umbraco's tools and data so the assistant can work inside your projects.

## Getting started

Option A: Install via npm:

```bash
npm install -g @openai/codex
```

Option B: Install via Homebrew:

```bash
brew install codex
```

### Configure using the Codex CLI

1. Add the Umbraco MCP server with the Codex CLI:

```bash
codex mcp add umbraco-mcp -- npx -y @umbraco-cms/mcp-dev@17.1
```

2. Define configuration values directly. If you prefer to keep secrets in your shell session, pass them as environment variables during registration:

```bash
codex mcp add umbraco-mcp \
  --env UMBRACO_CLIENT_ID="your-id" \
  --env UMBRACO_CLIENT_SECRET="your-secret" \
  --env UMBRACO_BASE_URL="https://your-domain.com" \
  --env NODE_TLS_REJECT_UNAUTHORIZED="0" \
  --env UMBRACO_INCLUDE_TOOL_COLLECTIONS="document,media,document-type,data-type" \
  -- npx -y @umbraco-cms/mcp-dev@17.1
```

Replace the following values with your local connection details:

- `UMBRACO_CLIENT_ID`
- `UMBRACO_CLIENT_SECRET`
- `UMBRACO_BASE_URL`
- `UMBRACO_INCLUDE_TOOL_COLLECTIONS`

This command stores the MCP server as `umbraco-mcp` in your Codex configuration file (typically `~/.codex/config.toml`).

3. Use the command below to see which MCP servers Codex is currently loading:

```cs
codex mcp list
```

## Managing tools and tool collections

When you need to change the tool set:

- Update your `.env` file with the tool collections you want (for example, `document,media`).
- Run the `codex mcp list` command to confirm that the server is healthy.

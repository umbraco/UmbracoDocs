---
description: >-
  How to run and exercise a scaffolded MCP server in Claude Code using the shipped .mcp.json, with MCP Inspector as a fallback.
---

# Testing Your MCP Server

The [development workflow](./development-workflow.md) generates everything you need to verify your tools automatically. This includes integration tests in [Phase 4](./development-workflow.md#phase-4-tool-implementation) and LLM eval tests in [Phase 5](./development-workflow.md#phase-5-evaluation-and-iteration).

This page covers the third leg: **manual, exploratory testing**. You drive your tools through real natural-language prompts to spot rough edges while iterating on descriptions and behavior.

The project template ships with a `.mcp.json` file that makes the MCP server immediately available in Claude Code. No extra `claude mcp add` step, no copying config between files — open the project directory in Claude Code, and the server is connected.

| Kind of testing | How | When to use |
|---|---|---|
| **Integration tests** | `npm run test` | Verify each tool works against a real Umbraco instance. |
| **LLM eval tests** | `npm run test:evals` | Verify an LLM can use your tools together to complete workflows. |
| **Manual exploration** | `.mcp.json` in Claude Code (this page) | Try prompts, watch tool selection, spot surprising behavior. |

## The shipped `.mcp.json`

Every scaffolded project contains a `.mcp.json` at its root:

```json
{
  "mcpServers": {
    "umbraco": {
      "command": "node",
      "args": ["--env-file=.env", "./dist/index.js"]
    }
  }
}
```

Claude Code reads project-scoped `.mcp.json` files on startup and launches the listed servers with the project directory as the working directory. That means:

* `./dist/index.js` resolves to the built MCP server inside your project
* `--env-file=.env` tells Node.js 22+ to load environment variables from the project's `.env` file at startup — your `UMBRACO_CLIENT_ID`, `UMBRACO_CLIENT_SECRET`, and `UMBRACO_BASE_URL` flow in automatically

No secrets are baked into `.mcp.json`. Credentials live only in `.env`, which is listed in `.gitignore`.

{% hint style="info" %}
`.mcp.json` is safe to commit. It only contains the command used to start the server. Teammates who clone the project get the same launch configuration automatically.
{% endhint %}

## Prerequisites

Before the server can be called, three things must be in place:

1. **`.env` is populated.** If you used `init`'s "create new instance" flow, `UMBRACO_BASE_URL`, `UMBRACO_CLIENT_ID`, and `UMBRACO_CLIENT_SECRET` are written for you. If you connected an existing Umbraco instance, copy `.env.example` to `.env` and fill in the three values by hand — this path does not yet auto-populate them.
2. **Your Umbraco instance is running.** The MCP server authenticates against it on every tool call.
3. **The project is built.** `.mcp.json` points at `./dist/index.js`, not source.

```bash
npm run build
```

## Opening the project in Claude Code

From the project root:

```bash
claude .
```

Claude Code loads `.mcp.json` and starts the `umbraco` server. Confirm the connection with the `/mcp` command inside Claude Code — it lists connected servers and their available tools.

{% hint style="warning" %}
Renaming the server key in `.mcp.json` makes Claude Code treat it as a new server. It re-prompts for approval the first time you open the project.
{% endhint %}

## Invoking tools

Ask Claude Code to use one of your tools in natural language. It picks the right tool from the descriptions and annotations generated during [Phase 4](./development-workflow.md#phase-4-tool-implementation). For example:

> List the first five content types.

Claude Code calls the relevant tool, shows the request and response, and summarizes the result. If the tool expects parameters that Claude cannot infer, it asks you to clarify.

## Iterating on changes

The MCP server runs from the built bundle, so after editing a tool, you must rebuild:

```bash
npm run build
```

Then restart the MCP server connection inside Claude Code. The easiest way is to run `/mcp` and reconnect the `umbraco` server, or restart Claude Code entirely.

{% hint style="info" %}
For a tighter loop while iterating on a tool, run `npm run watch` in a terminal to keep `dist/` in sync with your source changes. You still need to trigger a reconnection in Claude Code for the new code to take effect.
{% endhint %}

## Falling back to the MCP Inspector

`.mcp.json` is the primary test path. The MCP Inspector is still useful when you want a pure-protocol view of requests and responses without an LLM in the loop:

```bash
npm run inspect
```

The Inspector launches a local web UI that connects to the same built server. Use it when you want to verify request schemas, exercise edge cases, or confirm a tool's behavior independent of Claude's tool-selection logic.

## Common issues

| Symptom | Likely cause | Fix |
|---|---|---|
| Claude Code does not list the `umbraco` server. | `.mcp.json` not found or malformed. | Verify the file exists at the project root and is valid JSON. |
| Server fails to start with `Cannot find module './dist/index.js'`. | Project not built. | Run `npm run build`. |
| Server starts but every tool call returns 401. | `.env` missing or stale. | Re-run `init`, or populate `UMBRACO_CLIENT_ID` / `UMBRACO_CLIENT_SECRET` / `UMBRACO_BASE_URL` by hand. |
| Tool calls fail with TLS errors against a local Umbraco. | Self-signed certificate. | Ensure `NODE_TLS_REJECT_UNAUTHORIZED=0` is set in `.env` (default for scaffolded projects). |
| Changes to a tool are not reflected. | Server is running stale code. | Rebuild with `npm run build` and reconnect the server in Claude Code. |

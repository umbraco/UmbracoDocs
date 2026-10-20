---
description: >-
  What the MCP server project template contains and how to get it running.
---

# Project Template

When you create a project with `npx @umbraco-cms/create-umbraco-mcp-server`, you get a complete Umbraco MCP server project using the [`@umbraco-cms/mcp-server-sdk`](../sdk/README.md) and [`@umbraco-cms/mcp-hosted`](../hosted-mcp/README.md) packages.

## Project Structure

The project includes:

* **Server entry point** — A configured MCP server at `src/index.ts` that loads tool collections, applies filtering, and registers tools
* **API client** — [Orval](https://orval.dev/) configuration for generating a typed API client and Zod schemas from your Umbraco instance's OpenAPI spec
* **Tool collections** — A directory structure under `src/umbraco-api/tools/` where each collection groups related tools by HTTP method (`get/`, `post/`, `put/`, `delete/`)
* **Configuration** — Mode and slice registries in `src/config/` that control tool filtering. See [Configuration](../sdk/configuration.md) and [Tool Filtering](../sdk/tool-filtering.md) in the SDK documentation
* **Testing infrastructure** — Jest setup for both integration tests (against a real Umbraco instance) and LLM eval tests (using the Claude Agent SDK). See [Testing and Evals](../sdk/testing.md) in the SDK documentation
* **Hosted Worker** — A Cloudflare Worker entry point at `src/worker.ts` using the [`@umbraco-cms/mcp-hosted`](../hosted-mcp/README.md) package for remote deployment with OAuth authentication and multi-site support

## Optional Features

The [init phase](./development-workflow.md#phase-2-init) lets you keep or remove these optional features:

### Mock Infrastructure (MSW)

The `src/mocks/` directory contains Mock Service Worker handlers for testing without a running Umbraco instance. The mock server setup, API handlers, and in-memory data store provide a lightweight alternative for development.

### MCP Chaining

The `src/umbraco-api/mcp-client.ts` file configures connections to other MCP servers (such as `@umbraco-cms/mcp-dev`). MCP chaining lets you proxy tools from existing servers alongside your custom tools. See [MCP Chaining](../sdk/mcp-chaining.md) in the SDK documentation.

### Example Tools

An example tool collection demonstrates the patterns for building your own tools. The init phase gives you the choice to remove these examples if you prefer a clean starting point.

### Agent Evaluation Tests

The `tests/evals/` directory provides an LLM evaluation framework with eval setup, helpers, and example test files. These tests verify that an LLM can use your tools to complete real workflows.

## Scripts

The project includes the following npm scripts:

| Script | Purpose |
|---|---|
| `npm run build` | Build the MCP server with `tsup` |
| `npm run compile` | Type-check without emitting files |
| `npm run watch` | Rebuild on file changes |
| `npm run generate` | Regenerate the Orval API client from the OpenAPI spec |
| `npm run start:umbraco` | Start the local Umbraco instance |
| `npm run inspect` | Launch the MCP Inspector to test your server interactively |
| `npm run test` | Run integration tests |
| `npm run test:evals` | Build and run LLM eval tests |
| `npm run test:all` | Run both integration and eval tests |
| `npm run dev:worker` | Start the Cloudflare Worker locally |
| `npm run deploy:worker` | Deploy the Cloudflare Worker |
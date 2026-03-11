---
description: Overview of the MCP Server SDK package for building MCP servers that expose Umbraco APIs to AI assistants.
---

# MCP Server SDK

The `@umbraco-cms/mcp-server-sdk` package provides infrastructure for building Model Context Protocol (MCP) servers that expose Umbraco APIs to AI assistants. The SDK handles tool registration, API communication, error handling, configuration loading, tool filtering, and MCP chaining.

Use this SDK when building your own MCP server on top of Umbraco. For a quick start, see the [Create Umbraco MCP Server](../create-umbraco-mcp-server/README.md) CLI.

## Package Exports

The SDK is organized into focused entry points so you can import only what you need.

| Entry Point | Purpose |
|---|---|
| `@umbraco-cms/mcp-server-sdk` | Main: tool helpers, decorators, types, filtering, MCP chaining, constants |
| `@umbraco-cms/mcp-server-sdk/testing` | Test utilities: environment setup, MSW helpers, snapshot normalization |
| `@umbraco-cms/mcp-server-sdk/evals` | LLM eval framework: scenario tests, agent runner, verification |
| `@umbraco-cms/mcp-server-sdk/config` | Configuration loading from env vars and CLI flags |
| `@umbraco-cms/mcp-server-sdk/helpers` | API call helpers only |
| `@umbraco-cms/mcp-server-sdk/types` | Type definitions only |
| `@umbraco-cms/mcp-server-sdk/constants` | Umbraco well-known IDs (media types, user groups, etc.) |

## Getting Started

Create a new MCP server project with the [Create Umbraco MCP Server](../create-umbraco-mcp-server/README.md) CLI. The project template includes this SDK and configures it for you.

## Documentation

| Guide | Description |
|---|---|
| [Tool Authoring](./tool-authoring.md) | How the system works, adding collections and tools, examples |
| [API Helpers](./api-helpers.md) | API call helpers, HTTP client, ProblemDetails handling |
| [Tool Filtering](./tool-filtering.md) | Modes, slices, collections, configuration flow |
| [MCP Chaining](./mcp-chaining.md) | Proxying, delegation, and composite tool patterns |
| [Configuration](./configuration.md) | Server config, env vars, CLI flags, custom fields |
| [Constants](./constants.md) | Well-known Umbraco IDs reference |
| [Testing and Evals](./testing.md) | Unit testing, snapshot helpers, LLM eval framework |
| [Coverage Tracking](./coverage-tracking.md) | Count tools and catalog ignored endpoints |

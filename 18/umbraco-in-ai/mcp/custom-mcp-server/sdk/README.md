---
description: Overview of the MCP Server SDK package for building MCP servers that expose Umbraco APIs to AI assistants.
---

# MCP Server SDK

The `@umbraco-cms/mcp-server-sdk` package provides infrastructure for building Model Context Protocol (MCP) servers that expose Umbraco APIs to AI assistants. The SDK handles tool registration, API communication, error handling, configuration loading, tool filtering, and MCP chaining.

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

---
description: >-
  CLI toolkit and Claude Code plugin for creating, configuring, and building
  custom MCP servers that expose Umbraco APIs to AI assistants.
---

# Create Umbraco MCP Server

The `@umbraco-cms/create-umbraco-mcp-server` package provides a CLI toolkit and Claude Code plugin for building custom MCP servers on top of Umbraco. The toolkit takes you from an empty directory to a tested, production-ready MCP server through a five-phase workflow.

## What it includes

The package has three components:

* **[Project template](./project-template.md)** — A ready-to-go MCP server project with tool collections, API client generation, testing infrastructure, and optional features like MCP chaining.
* **[CLI toolkit](./development-workflow.md)** — Creates a new project, configures your Umbraco connection, and discovers API endpoints.
* **[Claude Code plugin](./claude-code-plugin.md)** — Skills and agents that automate tool creation, test generation, and Agent evaluation inside Claude Code.

## Prerequisites

Before starting, ensure the following are installed:

* **Node.js 22+**
* **.NET SDK** — Required for creating Umbraco instances
* **SQL Server** — Required for the Umbraco instance database, SQLite is not suitable for integration tests
* **Claude Code** — Required for tool building and evaluation (Phases 4-5)

## Getting Started

Create a new project and run the init wizard:

```bash
npx @umbraco-cms/create-umbraco-mcp-server my-mcp-server
cd my-mcp-server
npm install
npx @umbraco-cms/create-umbraco-mcp-server init
```

See the [development workflow](./development-workflow.md) for the complete walkthrough.

## Five-Phase Workflow

The [development workflow](./development-workflow.md) guides you through building a custom MCP server:

### CLI Phases

| Phase | Command | What happens |
|---|---|---|
| 1. Create | `npx @umbraco-cms/create-umbraco-mcp-server my-server` | Creates the project |
| 2. Init | `npx @umbraco-cms/create-umbraco-mcp-server init` | Configures the instance and trims features |
| 3. Discover | `npx @umbraco-cms/create-umbraco-mcp-server discover` | Analyzes APIs and plans tool collections |

### Claude Code Plugin Phases

After Phase 3, install the [Claude Code plugin](./claude-code-plugin.md) to automate the remaining phases:

```
/plugin marketplace add umbraco/Umbraco-MCP-Base
/plugin install umbraco-mcp-skills@umbraco-mcp-server-sdk-plugins
```

| Phase | Command | What happens |
|---|---|---|
| 4. Build | `/build-tools` and `/build-tools-tests` | Generates tools and tests via Claude Code |
| 5. Evaluate | `/build-evals` and `npm run test:evals` | Runs LLM eval tests and iterates |

## Learn more

* [Project Template](./project-template.md) — Structure, configuration, registries, and conventions of the generated project
* [Development Workflow](./development-workflow.md) — Detailed five-phase guide from scaffolding to evaluation
* [Claude Code Plugin](./claude-code-plugin.md) — Skills and agents for automated tool building and testing

---
description: >-
  Five-phase workflow for building custom MCP servers: scaffolding, configuration,
  API discovery, tool implementation, and LLM evaluation.
---

# Development Workflow

The development workflow takes you from an empty directory to a tested MCP server in five phases. Each phase builds on the previous one.

## Phase 1: Create

Scaffold a new MCP server project:

```bash
npx @umbraco-cms/create-umbraco-mcp-server my-mcp-server
```

The command creates a complete MCP server project with:

* MCP server boilerplate with `@umbraco-cms/mcp-server-sdk`
* Orval configuration for API client generation
* Example tool collection and tests
* Optional features: mocks (MSW), MCP chaining, evals

See the [Project Template](./project-template.md) for full details on what is included.

## Phase 2: Init

Configure the project and optionally create an Umbraco instance:

```bash
npx @umbraco-cms/create-umbraco-mcp-server init
```

### Umbraco Instance Setup

The CLI prompts you to choose how to connect to an Umbraco instance. You can create a new instance or use an existing one.

#### Create a new instance

This option walks you through creating a local Umbraco instance:

1. Detects whether the [Package Script Writer (PSW) CLI](https://www.nuget.org/packages/PackageScriptWriter.Cli) is installed, and installs it if needed
2. Prompts for a SQL Server connection string
3. Searches the Umbraco Marketplace and lets you select NuGet packages to install
4. Builds the Umbraco instance in a `demo-site/` directory
5. Populates your `.env` file with the base URL and client credentials

{% hint style="warning" %}
A SQL Server connection string is required. SQLite is not supported because integration tests run sequential write operations that require a full database engine.
{% endhint %}

#### Use an existing instance

If you already have a running Umbraco instance, choose this option. The CLI prompts for the Swagger JSON URL and updates `orval.config.ts` to point at your API.

### Feature Configuration

The CLI prompts you to keep or remove optional features:

| Feature | Default | Description |
|---|---|---|
| Mock infrastructure (MSW) | Keep | Mocks for testing without a running Umbraco instance |
| MCP chaining | Keep | Proxy tools from other MCP servers like `@umbraco-cms/mcp-dev` |
| Example tools | Remove | Example tool collections demonstrating patterns |
| LLM eval tests | Keep | Claude-based acceptance tests for tool effectiveness |

{% hint style="info" %}
Start lean — remove features you do not need. You can regenerate them later using the Claude Code plugin skills.
{% endhint %}

### Next Steps

After creating a new instance, start the Umbraco site before moving to Phase 3:

```bash
npm run start:umbraco
```

Keep this running in a separate terminal. The discover command in Phase 3 requires a running Umbraco instance.

## Phase 3: Discover

Analyze a running Umbraco instance's APIs and plan tool collections:

```bash
npx @umbraco-cms/create-umbraco-mcp-server discover
```

{% hint style="warning" %}
The Umbraco instance must be running before you execute the discover command.
{% endhint %}

### Instance Preparation

The discover command starts by connecting to your Umbraco instance and setting up authentication:

1. **Detect base URL** from `launchSettings.json`, `.env`, or `orval.config.ts`
2. **Health check** the instance
3. **Create an API user** for authentication against the local Umbraco instance used for development and testing

### Swagger Setup

Next, the command discovers the available APIs and generates a typed client:

4. **Discover Swagger endpoints** and prompt you to select which API to target
5. **Update the Orval config** and **generate the API client**

### API Analysis

The command analyzes the OpenAPI spec and reports what it finds:

6. **Analyze the OpenAPI spec** — extract groups, operations, slices (CRUD categories), and permissions
7. **Print a discovery report** — groups, operation counts, slices, and security scheme

### Collections, Modes, and Slices

Finally, the command helps you organize the discovered operations into tool collections and configure how they are filtered:

8. **Select groups** to include as tool collections
9. **Suggest modes** — asks Claude to propose meaningful mode groupings (falls back to a heuristic if Claude is unavailable)
10. **Update registries** — optionally write to `mode-registry.ts` and `slice-registry.ts`
11. **Write `.discover.json`** — a manifest consumed by `/build-tools` in Phase 4

### Review and Refine

After discovery, review the generated registries and refine as needed:

* **Modes** — Combine or split groups based on your use cases (for example, `commerce-admin` versus `commerce-catalog`)
* **Slices** — Add domain-specific slices beyond the standard CRUD operations
* **Permissions** — Note the required OAuth2 scopes for your `.env` configuration

## Phase 4: Tool Implementation

Build tool collections using the [Claude Code plugin](./claude-code-plugin.md). Install the plugin first:

```
/plugin marketplace add umbraco/Umbraco-MCP-Base
/plugin install umbraco-mcp-skills@umbraco-mcp-server-sdk-plugins
```

### Build Tools

Generate tool collections from the `.discover.json` manifest:

```
/build-tools              # Build all collections from .discover.json
/build-tools form         # Build a single collection
```

For each collection, the skill reads the Swagger spec and maps operations to Orval-generated client functions. The skill creates tool files with correct slices and annotations, then compiles to verify types. Collections that already have an `index.ts` file are skipped — use [`/add-tool`](./claude-code-plugin.md#add-tool) to add new tools to existing collections. See [`/build-tools`](./claude-code-plugin.md#build-tools) for full details.

### Build Tests

Generate integration tests per collection:

```
/build-tools-tests        # Generate tests for all collections
/build-tools-tests form   # Generate tests for a single collection
```

For each collection, the skill creates test setup, builders, helpers, and integration test files. Tests run sequentially against the real API. Collections that already have a `__tests__/setup.ts` file are skipped — use [`/add-test`](./claude-code-plugin.md#add-test) to add tests for new tools in existing collections. See [`/build-tools-tests`](./claude-code-plugin.md#build-tools-tests) for full details.

### Tool Review

After tools are built, the `mcp-tool-reviewer` agent checks each tool against an [LLM-readiness checklist](./claude-code-plugin.md#mcp-tool-reviewer). Address any issues flagged by the reviewer before moving to Phase 5.

## Phase 5: Evaluation and Iteration

Test tool effectiveness using LLM-driven eval tests.

### Build Evals

Generate eval tests for tool collections:

```
/build-evals              # Generate eval tests for all collections
/build-evals form         # Generate eval tests for a single collection
```

For each collection, the skill designs workflow scenarios, creates eval test files, builds, and runs them. Collections that already have eval test files in `tests/evals/` are skipped — use [`/add-eval`](./claude-code-plugin.md#add-eval) to add evals for new tools or workflows. See [`/build-evals`](./claude-code-plugin.md#build-evals) for full details.

{% hint style="info" %}
Eval tests differ from integration tests. Integration tests verify each tool individually. Eval tests group related tools into workflow scenarios (1-2 files per collection) and verify that an LLM can use them together effectively.
{% endhint %}

### Run and Iterate

Build and run the eval tests:

```bash
npm run build && npm run test:evals
```

### Common Eval Issues

When eval tests reveal problems, use this reference to diagnose and fix them:

| Symptom | Likely Cause | Fix |
|---|---|---|
| Wrong tool selected | Poor tool description | Improve description clarity |
| Missing parameters | Unclear parameter documentation | Add examples to descriptions |
| Tool not found | Unintuitive name | Rename the tool |
| Inefficient tool chain | Missing composite tool | Create a workflow tool |

### The Iteration Loop

The eval-driven iteration loop follows this pattern:

1. Run eval tests
2. Analyze traces to understand LLM behavior
3. Improve tool descriptions, parameters, or design
4. Rebuild and re-run
5. Repeat until tests pass reliably

### Conversational Improvement

Once your eval tests are passing, use `/discuss-mcp` to conversationally analyze and improve your MCP server. The skill provides advisory analysis across three areas:

* **Trace optimization** — Analyze eval traces to find inefficiencies in tool usage
* **Chaining analysis** — Identify tools that could benefit from MCP chaining to other servers
* **Coverage analysis** — Find API operations not yet exposed as tools

### Evaluate Chaining Value

If `/discuss-mcp` or your own analysis suggests chaining would help, determine whether connecting to other MCP servers (such as `@umbraco-cms/mcp-dev`) adds value:

| Scenario | Chain? | Reason |
|---|---|---|
| Need content and commerce data | Yes | Combine content and commerce tools |
| Commerce-only operations | No | Standalone is simpler |
| Complex workflows | Yes | Leverage existing tools |

If chaining adds value, configure connections in `src/config/mcp-servers.ts`. See [MCP Chaining](../sdk/mcp-chaining.md) in the SDK documentation.


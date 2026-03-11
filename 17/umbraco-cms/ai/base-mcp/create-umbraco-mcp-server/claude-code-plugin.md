---
description: >-
  Claude Code skills and agents for automating MCP tool creation, test
  generation, and LLM evaluation.
---

# Claude Code Plugin

The Umbraco MCP skills plugin provides specialized Claude Code skills and agents for building MCP servers. Skills are invoked with slash commands. Agents are invoked automatically when Claude Code detects a matching task.

## Installation

Add the marketplace and install the plugin:

```
/plugin marketplace add umbraco/Umbraco-MCP-Base
/plugin install umbraco-mcp-skills@umbraco-mcp-server-sdk-plugins
```

The plugin requires a project built with `@umbraco-cms/mcp-server-sdk`. See [Project Template](./project-template.md) for the expected project structure.

## How Skills and Agents Work

Skills and agents serve different purposes in the development workflow:

* **Skills** are slash commands you invoke explicitly. They load reference information or orchestrate multi-step workflows. For example, `/build-tools` reads the `.discover.json` manifest and orchestrates the creation of tool collections.
* **Agents** are invoked automatically by Claude Code when a task matches their purpose. For example, when `/build-tools` needs to create a tool file, it delegates to the `mcp-tool-creator` agent.

Skills often invoke agents as part of their workflow. You can also trigger agents directly by describing a task in natural language.

## Skills

### `/build-tools`

Generates tool collections from the `.discover.json` manifest produced by the discover phase.

**Phase:** 4 (Tool Implementation)

**Usage:**

```
/build-tools              # Build all collections
/build-tools form         # Build a single collection by name
```

**What it does for each collection:**

1. Reads the Swagger spec for operations matching the collection's tag
2. Maps operations to Orval-generated client functions and Zod schemas
3. Delegates to the `mcp-tool-creator` agent to create each tool file
4. Delegates to the `mcp-tool-description-writer` agent to write LLM-optimized descriptions
5. Creates the collection `index.ts` and registers it in the entry point
6. Compiles with `npm run compile` to verify types
7. Delegates to the `mcp-tool-reviewer` agent to check LLM-readiness

Collections that already have an `index.ts` file are skipped.

### `/build-tools-tests`

Generates integration tests for tool collections.

**Phase:** 4 (Tool Implementation)

**Usage:**

```
/build-tools-tests        # Generate tests for all collections
/build-tools-tests form   # Generate tests for a single collection
```

**What it does for each collection:**

1. Reads existing tool files to understand schemas and handlers
2. Delegates to the `test-builder-helper-creator` agent to create builders and helpers
3. Delegates to the `integration-test-creator` agent to create test files
4. Delegates to the `integration-test-validator` agent to validate test quality
5. Runs the tests to verify they pass

Collections that already have a `__tests__/setup.ts` file are skipped.

### `/build-evals`

Generates LLM eval tests for tool collections.

**Phase:** 5 (Evaluation and Iteration)

**Usage:**

```
/build-evals              # Generate eval tests for all collections
/build-evals form         # Generate eval tests for a single collection
```

**What it does for each collection:**

1. Reads existing tool files to understand available operations
2. Creates eval setup at `tests/evals/helpers/e2e-setup.ts`
3. Designs workflow scenarios (CRUD lifecycle, read-only, search, hierarchy)
4. Delegates to the `eval-test-creator` agent to create test files
5. Builds and runs the tests

Collections that already have eval test files are skipped.

### `/discuss-mcp`

Advisory skill for improving MCP tools. Does not generate code — provides analysis and recommendations.

**Phase:** 5 (Evaluation and Iteration)

**Usage:**

```
/discuss-mcp
```

**Analysis modes:**

* **Trace optimization** — Analyzes eval traces to find inefficiencies in how the LLM uses your tools. Highlights cases where the LLM calls unnecessary tools, passes wrong parameters, or takes indirect paths.
* **Chaining analysis** — Identifies tools that could benefit from MCP chaining to other servers. Recommends when to proxy, delegate, or create composite tools.
* **Coverage analysis** — Compares your tool collections against the full OpenAPI spec. Finds API operations not yet exposed as tools and recommends priorities.

## Agents

Agents are invoked automatically by Claude Code when the task matches. You can also invoke them by describing the task in natural language.

### mcp-tool-creator

Creates MCP tool files following SDK patterns.

**Invoked by:** `/build-tools`

**What it does:**

* Creates a tool file with the correct structure (inputSchema, outputSchema, slices, annotations, handler)
* Uses the appropriate API helper function (`executeGetApiCall`, `executeVoidApiCall`, or manual handling)
* Wraps the export with `withStandardDecorators`
* Uses Zod schemas from the Orval-generated code

See [Tool Authoring](../sdk/tool-authoring.md) in the SDK docs for the patterns used.

### mcp-tool-description-writer

Writes LLM-optimized tool descriptions. Focuses on making descriptions clear and actionable for AI assistants.

**Invoked by:** `/build-tools`

**What it does:**

* Writes descriptions using action verbs (Gets, Creates, Deletes)
* Includes parameter constraints and valid values
* Specifies when NOT to use the tool
* Keeps descriptions concise but informative

### mcp-tool-reviewer

Reviews tools against an LLM-readiness checklist. The reviewer flags issues that would make tools difficult for an LLM to use effectively.

**Invoked by:** `/build-tools`

**Checklist items:**

| Category | What it checks |
|---|---|
| Schema simplification | Maximum 3-5 fields, no nested objects, no UUID generation expected from the LLM |
| Description quality | Action verbs, constraints, when NOT to use |
| Response shaping | Essential fields only, actionable errors |
| Composite opportunities | Sequences that should be bundled into a single tool |
| Naming and annotations | Consistent naming, correct hints per HTTP method |
| Context and scope | No redundant tools, reasonable count per collection |
| Pagination design | Appropriate page sizes, documented mechanics |

### integration-test-creator

Creates integration tests for tool collections. Tests run against a real Umbraco instance.

**Invoked by:** `/build-tools-tests`

**What it does:**

* Creates test files with 2-3 tests per tool
* Uses `setupTestEnvironment()` for consistent test setup
* Tests tool handlers directly with `createMockRequestHandlerExtra()`
* Uses builder patterns for test data setup and cleanup
* Runs tests sequentially to avoid API conflicts

See [Testing and Evals](../sdk/testing.md) in the SDK docs for the patterns used.

### integration-test-validator

Validates test quality after the `integration-test-creator` generates tests.

**Invoked by:** `/build-tools-tests`

**What it checks:**

* Tests follow consistent patterns
* Each tool has adequate test coverage
* Test data is set up and cleaned up correctly
* Assertions check both success and error paths
* Tests run without failures

### test-builder-helper-creator

Creates test builders and helpers specific to each collection.

**Invoked by:** `/build-tools-tests`

**What it does:**

* Creates builder classes for constructing test data (for example, `DocumentBuilder`, `MediaBuilder`)
* Creates helper functions for common test operations
* Sets up test infrastructure in `__tests__/helpers/`

### eval-test-creator

Creates LLM eval workflow tests using the Claude Agent SDK.

**Invoked by:** `/build-evals`

**What it does:**

* Groups related tools into workflow scenarios rather than testing tools individually
* Uses `runScenarioTest` with a natural language prompt, tool list, required tools, and success pattern
* Designs scenarios that exercise CRUD lifecycles, search, hierarchy traversal, and edge cases
* Sets appropriate timeouts and budget limits

See [Testing and Evals](../sdk/testing.md) in the SDK docs for the eval framework.

## Skills and Agents Summary

### Skills Reference

| Skill | Command | Phase | Purpose |
|---|---|---|---|
| build-tools | `/build-tools` | 4 | Generate tool collections from `.discover.json` |
| build-tools-tests | `/build-tools-tests` | 4 | Generate integration tests per collection |
| build-evals | `/build-evals` | 5 | Generate LLM eval tests per collection |
| discuss-mcp | `/discuss-mcp` | 5 | Advisory: trace optimization, chaining, coverage |

### Agents Reference

| Agent | Invoked By | Purpose |
|---|---|---|
| mcp-tool-creator | `/build-tools` | Creates tool files following SDK patterns |
| mcp-tool-description-writer | `/build-tools` | Writes LLM-optimized tool descriptions |
| mcp-tool-reviewer | `/build-tools` | Reviews tools for LLM-readiness |
| integration-test-creator | `/build-tools-tests` | Creates integration tests |
| integration-test-validator | `/build-tools-tests` | Validates test quality |
| test-builder-helper-creator | `/build-tools-tests` | Creates test builders and helpers |
| eval-test-creator | `/build-evals` | Creates LLM eval workflow tests |

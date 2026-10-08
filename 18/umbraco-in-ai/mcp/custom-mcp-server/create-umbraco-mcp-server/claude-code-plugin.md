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

The plugin requires a project built with `@umbraco-cms/mcp-server-sdk`. See [Project Template](project-template.md) for the expected project structure.

## Skills

### Bulk Generation

These skills generate entire collections, test suites, or eval suites from scratch. They skip collections that already have output files.

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

### Incremental Additions

These skills add individual tools, tests, or evals to existing collections. Use them after the bulk generation skills, or when adding new API endpoints.

### `/add-tool`

Adds a new tool to an existing collection. Use this when a new API endpoint has been added, or when `/build-tools` skipped a collection because it already exists.

**Phase:** 4 (Tool Implementation)

**Usage:**

```
/add-tool form                      # Add a tool to the form collection (will show available endpoints)
/add-tool form "copy form endpoint" # Add a specific endpoint
```

**What it does:**

1. Reads the existing collection to match patterns and conventions.
2. Reads the Swagger spec to find the new endpoint.
3. Delegates to the `mcp-tool-creator` agent to create the tool file.
4. Delegates to the `mcp-tool-description-writer` agent to write the description.
5. Updates the collection `index.ts` to export the new tool.
6. Compiles with `npm run compile` to verify types.
7. Delegates to the `mcp-tool-reviewer` agent to check LLM-readiness.
8. Adds an integration test if the collection already has tests.
9. Updates eval tests if the collection already has evals.

This skill fills the gap between `/build-tools` (which generates entire collections from scratch) and manual tool creation. It reuses the same agents but operates on a single tool within an existing collection.

### `/add-test`

Adds an integration test for a specific tool in an existing collection.

**Phase:** 4 (Tool Implementation)

**Usage:**

```
/add-test form                # Show untested tools in the form collection
/add-test form copy-form      # Add a test for the copy-form tool
```

**What it does:**

1. Reads the existing test infrastructure (setup, builders, helpers).
2. Identifies the tool to test and reads its schema and handler.
3. Updates the builder or helper if the new tool needs additional methods.
4. Delegates to the `integration-test-creator` agent to create the test file.
5. Compiles and runs the test.
6. Delegates to the `integration-test-validator` agent to check quality.

Requires existing test infrastructure (`__tests__/setup.ts`). If it doesn't exist, run `/build-tools-tests` first.

### `/add-eval`

Adds or updates an LLM eval test for a specific tool or collection.

**Phase:** 5 (Evaluation and Iteration)

**Usage:**

```
/add-eval form                       # Show tools without eval coverage
/add-eval form "copy form workflow"  # Add eval for a specific workflow
```

**What it does:**

1. Compares collection tools against existing eval scenarios to find gaps.
2. Decides whether to update an existing scenario or create a new one.
3. Delegates to the `eval-test-creator` agent to create or update the test file.
4. Builds and runs the eval test, iterating on the prompt if needed.

Requires existing eval infrastructure (`tests/evals/helpers/e2e-setup.ts`). If it doesn't exist, run `/build-evals` first.

### Advisory

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

* Creates a tool file with the correct structure (`inputSchema`, `outputSchema`, `slices`, `annotations`, `handler`)
* Uses the appropriate API helper function (`executeGetApiCall`, `executeVoidApiCall`, or manual handling)
* Wraps the export with `withStandardDecorators`
* Uses Zod schemas from the Orval-generated code

See [Tool Authoring](../sdk/tool-authoring.md) in the SDK documentation for the patterns used.

### mcp-tool-description-writer

Writes LLM-optimized tool descriptions. Focuses on making descriptions clear and actionable for AI assistants.

**Invoked by:** `/build-tools`

**What it does:**

* Writes descriptions using action verbs (Gets, Creates, Deletes).
* Includes parameter constraints and valid values.
* Specifies when not to use the tool.
* Keeps descriptions concise but informative.

### mcp-tool-reviewer

Reviews tools against an LLM-readiness checklist. The reviewer flags issues that would make tools difficult for an LLM to use effectively.

**Invoked by:** `/build-tools`

**Checklist items:**

| Category | What it checks |
|---|---|
| Schema simplification | Maximum 3-5 fields, no nested objects, no UUID generation expected from the LLM |
| Description quality | Action verbs, constraints, when not to use |
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

See [Testing and Evals](../sdk/testing.md) in the SDK documentation for the patterns used.

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

See [Testing and Evals](../sdk/testing.md) in the SDK documentation for the eval framework.

## Skills and Agents Summary

### Skills Reference

| Skill | Command | Phase | Purpose |
|---|---|---|---|
| build-tools | `/build-tools` | 4 | Generate tool collections from `.discover.json` |
| add-tool | `/add-tool` | 4 | Add a new tool to an existing collection |
| build-tools-tests | `/build-tools-tests` | 4 | Generate integration tests per collection |
| add-test | `/add-test` | 4 | Add an integration test for a specific tool |
| build-evals | `/build-evals` | 5 | Generate LLM eval tests per collection |
| add-eval | `/add-eval` | 5 | Add or update an eval test for a specific tool |
| discuss-mcp | `/discuss-mcp` | 5 | Advisory: trace optimization, chaining, coverage |

### Agents Reference

| Agent | Invoked By | Purpose |
|---|---|---|
| mcp-tool-creator | `/build-tools`, `/add-tool` | Creates tool files following SDK patterns |
| mcp-tool-description-writer | `/build-tools`, `/add-tool` | Writes LLM-optimized tool descriptions |
| mcp-tool-reviewer | `/build-tools`, `/add-tool` | Reviews tools for LLM-readiness |
| integration-test-creator | `/build-tools-tests`, `/add-test` | Creates integration tests |
| integration-test-validator | `/build-tools-tests`, `/add-test` | Validates test quality |
| test-builder-helper-creator | `/build-tools-tests` | Creates test builders and helpers |
| eval-test-creator | `/build-evals`, `/add-eval` | Creates LLM eval workflow tests |

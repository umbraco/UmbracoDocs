---
description: Unit testing utilities and LLM eval framework provided by the MCP Server SDK.
---

# Testing and Evals

The SDK provides two testing entry points: `@umbraco-cms/mcp-server-sdk/testing` for unit and integration tests, and `@umbraco-cms/mcp-server-sdk/evals` for LLM-based evaluation tests. 

This page is a reference for how the utilities work — in practice, the [Claude Code plugin](../create-umbraco-mcp-server/claude-code-plugin.md) skills handle creating tests and evals for you.

## Builders and Helpers

Each tool group has a builder and test helper. Builders use a fluent API for creating test data with sensible defaults, and helpers provide query, cleanup, and snapshot normalization utilities. The Claude Code plugin skills create and maintain these for you.

## Unit and Integration Testing

### setupTestEnvironment

Sets up the standard test environment by mocking `console.error` in each test to suppress expected error output:

```typescript
import { setupTestEnvironment } from "@umbraco-cms/mcp-server-sdk/testing";

describe("my-test", () => {
  setupTestEnvironment();

  it("should handle errors", async () => {
    // console.error is mocked here
  });
});
```

### setupMswServer

Sets up an MSW (Mock Service Worker) server for API mocking:

```typescript
import { setupMswServer } from "@umbraco-cms/mcp-server-sdk/testing";
import { server } from "./mocks/server.js";
import { resetStore } from "./mocks/store.js";

setupMswServer(server, resetStore);
```

This helper:

- Starts the MSW server before all tests.
- Resets handlers and optionally clears the store after each test.
- Closes the server after all tests.

### Testing Tool Handlers

Use `createMockRequestHandlerExtra` to create the mock context object required by tool handlers:

```typescript
import {
  createMockRequestHandlerExtra,
  getStructuredContent,
  validateStructuredContent,
  validateErrorResult,
  validateToolResponse,
} from "@umbraco-cms/mcp-server-sdk/testing";

const extra = createMockRequestHandlerExtra();
const result = await myTool.handler({ id: "abc" }, extra);

// Extract structured content
const data = getStructuredContent(result);

// Validate against a Zod schema
const parsed = validateStructuredContent(result, mySchema);

// Validate against the tool's own outputSchema
const validated = validateToolResponse(myTool, result);

// Validate error responses match ProblemDetails format
const error = validateErrorResult(result);
```

### Snapshot Helpers

Normalize dynamic values (IDs, dates, timestamps) for stable snapshot testing:

```typescript
import {
  createSnapshotResult,
  normalizeObject,
  normalizeErrorResponse,
  BLANK_UUID,
} from "@umbraco-cms/mcp-server-sdk/testing";

// Normalize a full tool result (handles structuredContent)
const normalized = createSnapshotResult(result, specificIdToReplace);
expect(normalized).toMatchSnapshot();

// Normalize a raw API response object
const normalizedObj = normalizeObject(apiResponse);

// Normalize error responses (handles traceId)
const normalizedError = normalizeErrorResponse(result);
```

The normalization replaces:

- **IDs** with `BLANK_UUID`
- **Dates** (`created`, `updateDate`, and so on) with `NORMALIZED_DATE`
- **Timestamps** in names and paths with `NORMALIZED_TIMESTAMP`
- **Email addresses** with normalized patterns
- **Avatar URLs** and **media paths** with normalized strings
- **Trace IDs** in error responses

## LLM Evals

The eval framework runs end-to-end tests using the Claude Agent SDK. The framework spawns your MCP server, sends prompts to an LLM, and verifies the tools called and results returned.

{% hint style="info" %}
Evals run against the **built output** of your MCP server (`dist/index.js`). You must rebuild your project before running evals, otherwise your changes will not be picked up. Run `npm run build` (or your configured build command) between code changes and eval runs.
{% endhint %}

### `configureEvals`

Configure the eval framework before running tests:

```typescript
import { configureEvals } from "@umbraco-cms/mcp-server-sdk/evals";
import path from "path";

configureEvals({
  mcpServerPath: path.resolve(process.cwd(), "dist/index.js"),
  mcpServerName: "umbraco-mcp",
  serverEnv: {
    UMBRACO_CLIENT_ID: process.env.UMBRACO_CLIENT_ID || "",
    UMBRACO_CLIENT_SECRET: process.env.UMBRACO_CLIENT_SECRET || "",
    UMBRACO_BASE_URL: process.env.UMBRACO_BASE_URL || "http://localhost:56472",
  },
});
```

### runScenarioTest

Creates a test body function from a scenario definition. Use it with Jest's `it()`:

```typescript
import { runScenarioTest } from "@umbraco-cms/mcp-server-sdk/evals";

describe("data-type tests", () => {
  it(
    "should create and delete a data type",
    runScenarioTest({
      prompt: `Complete these tasks:
        1. Create a data type called '_Test'
        2. Delete the data type
        3. Say 'The task has completed successfully'`,
      tools: ["create-data-type", "delete-data-type"],
      requiredTools: ["create-data-type", "delete-data-type"],
      successPattern: "task has completed successfully",
      verbose: true,
    }),
    120000
  );
});
```

### runAgentTest

Lower-level function for running an agent test. Use this when you need more control than `runScenarioTest` provides:

```typescript
import { runAgentTest, logTestResult } from "@umbraco-cms/mcp-server-sdk/evals";

const result = await runAgentTest(
  "List all data types and report their names",
  ["list-data-types"],
  { model: ClaudeModels.Haiku, maxTurns: 10 }
);

logTestResult(result);
```

### Verification Helpers

The evals module exports helpers for verifying test results. The most common is `assertTestPassed`, which checks that required tools were called and the agent completed successfully:

```typescript
import { assertTestPassed } from "@umbraco-cms/mcp-server-sdk/evals";

assertTestPassed(result, ["create-data-type", "delete-data-type"]);
```

Additional helpers are available for more granular checks: `verifyRequiredToolCalls`, `verifySuccessMessage`, `verifyMcpConnection`, `verifyToolsAvailable`, and `verifyToolCalledWithParams`.

### ClaudeModels

Pre-defined model identifiers for use in eval configuration:

```typescript
import { ClaudeModels } from "@umbraco-cms/mcp-server-sdk/evals";

configureEvals({
  defaultModel: ClaudeModels.Haiku,
});
```

Available models: `ClaudeModels.Haiku`, `ClaudeModels.Sonnet`, `ClaudeModels.Opus`.

### VerbosityLevel

```typescript
type VerbosityLevel = "quiet" | "normal" | "verbose";
```

- **Quiet**: Pass/fail per test, summary at end.
- **Normal**: Tools called, cost information.
- **Verbose**: Full conversation trace with all messages.

Set via the `E2E_VERBOSITY` environment variable or in test options.

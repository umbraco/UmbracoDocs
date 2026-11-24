---
description: Guide to authoring MCP tools using the Umbraco MCP Server SDK, including collections, tool definitions, decorators, and code examples.
---

# Tool Authoring

This guide covers how the Umbraco MCP tool system works, how to organize tools into collections, and how to create individual tool definitions.

## How the System Works

When the MCP server starts, it follows this sequence:

1. **Entry point** runs and calls `getServerConfig()` to load configuration.
2. **Configuration** is loaded from CLI flags, environment variables, and `.env` files.
3. **Collections** are imported. Each collection exports metadata and a `tools()` function.
4. **Filtering** is applied using modes, slices, and collection rules from the configuration.
5. **Registration** happens for each tool that passes the filter.
6. **Handler invocation** occurs when the LLM calls a registered tool.

## Collections

Collections group related tools with metadata. Each collection has a name, description, optional dependencies, and a `tools()` function that returns an array of `ToolDefinition` objects.

The `dependencies` field lists other collection names that are automatically included when this collection is enabled. Dependencies are resolved recursively, so if collection A depends on B and B depends on C, enabling A includes all three.

### Directory Structure

Each collection lives in its own directory:

```
src/umbraco-api/tools/
  data-type/
    index.ts              # Exports metadata + tools()
    get/
      get-data-type.ts
      list-data-types.ts
    post/
      create-data-type.ts
    put/
      update-data-type.ts
    delete/
      delete-data-type.ts
  document/
    index.ts
    get/
      get-document.ts
```

### Collection Structure

{% hint style="info" %}
The `/build-tools` skill generates collections automatically. This section explains the structure for reference.
{% endhint %}

Each collection has an `index.ts` that exports metadata and a `tools()` function. The `tools()` function receives user context, allowing you to conditionally include tools based on permissions.

```typescript
// src/umbraco-api/tools/data-type/index.ts
import type { ToolCollectionExport } from "@umbraco-cms/mcp-server-sdk";
import type { UserContext } from "../../auth/auth-policies.js";
import { AuthPolicies } from "../../auth/auth-policies.js";

// Import tools from their HTTP method subdirectories
import getDataTypeTool from "./get/get-data-type.js";
import deleteDataTypeTool from "./delete/delete-data-type.js";

const collection: ToolCollectionExport<UserContext> = {
  metadata: {
    // Unique key used in mode and slice registries
    name: "data-type",
    // Shown in tool listings and logs
    displayName: "Data Types",
    description: "Manage Umbraco data type definitions",
    // When this collection is enabled, "document" is included too
    dependencies: ["document"],
  },
  // Called at registration time with the authenticated user's context.
  // Use auth policies to filter tools based on the user's permissions.
  tools: (user) => {
    // Only include tools if the user has access to the Settings section
    if (!AuthPolicies.SectionAccessSettings(user)) {
      return [];
    }
    return [
      getDataTypeTool,
      deleteDataTypeTool,
    ];
  },
};

export default collection;
```

The `UserContext` type comes from the `auth-policies.ts` file in your project. The file defines auth policy functions based on group memberships and allowed sections. The user's permissions always determine which tools the MCP server exposes. With [Hosted MCP](../hosted-mcp/README.md), this is the authenticated backoffice user. With stdio transport, this is the configured API user.

## Adding a New Tool

### ToolDefinition Interface

Every tool is defined using the `ToolDefinition` interface:

```typescript
interface ToolDefinition<
  InputArgs extends undefined | ZodRawShape = undefined,
  OutputArgs extends undefined | ZodRawShape | ZodType = undefined,
  TUser = any
> {
  /** Unique tool name */
  name: string;
  /** Tool description for LLM understanding */
  description: string;
  /** Input parameter schema (Zod shape) */
  inputSchema?: InputArgs;
  /** Optional output schema for structured responses */
  outputSchema?: OutputArgs;
  /** Tool handler function */
  handler: ToolCallback<InputArgs>;
  /** Optional function to dynamically enable/disable based on user context */
  enabled?: (user: TUser) => boolean;
  /** Explicit slice assignment for categorization (empty array = always included) */
  slices: string[];
  /** Optional annotations for tool behavior hints */
  annotations?: Partial<ToolAnnotations>;
}
```

### Key Points

- **`inputSchema`** takes a Zod shape (`ZodRawShape`), not a `z.object()`. The SDK wraps it in `z.object()` for you.
- **slices** controls which filtering categories the tool belongs to. An empty array means the tool is always included.
- **annotations.openWorldHint** is always `true` for tools that call the Umbraco API. The `createToolAnnotations` helper enforces this.

## Returning Results

Use `createToolResult` to return structured data from your handler, and `createToolResultError` for error responses:

```typescript
import { createToolResult, createToolResultError } from "@umbraco-cms/mcp-server-sdk";

// Success — returns structured content to the LLM
return createToolResult({ name: "My Document", id: "abc-123" });

// Error — returned as an error result (isError: true)
return createToolResultError({ status: 404, title: "Not Found", detail: "Document not found" });
```

For most CRUD operations, the [API call helpers](./api-helpers.md) handle result creation for you. Use `createToolResult` directly when you need to transform or combine data before returning it.

## withStandardDecorators

Wrap every tool with `withStandardDecorators` to get pre-execution checks and error handling.

```typescript
import { withStandardDecorators } from "@umbraco-cms/mcp-server-sdk";

export default withStandardDecorators(myTool);
```

This applies two decorators in order:

1. **`withPreExecutionCheck`** — Runs a configurable hook before each tool call (for example, version checking).
2. **`withErrorHandling`** — Catches all errors and converts them to MCP tool error results.

### Error Handling Priority

The `withErrorHandling` decorator processes errors in this order:

1. **ToolValidationError** - business logic validation errors with context
2. **UmbracoApiError** - API errors with ProblemDetails (from helpers)
3. **Axios errors** - network/HTTP errors with response data
4. **Standard errors** - JavaScript errors with message
5. **Unknown errors** - anything else

### Custom Decorators

You can create your own decorators and combine them using `compose`. Decorators are applied right to left — the last decorator listed wraps the tool first.

```typescript
import { compose, withErrorHandling, withPreExecutionCheck } from "@umbraco-cms/mcp-server-sdk";

// A custom decorator that logs tool calls
function withLogging<Args, Output>(tool: ToolDefinition<Args, Output>): ToolDefinition<Args, Output> {
  return {
    ...tool,
    handler: async (args, extra) => {
      console.log(`Calling tool: ${tool.name}`);
      return tool.handler(args, extra);
    },
  };
}

// Compose standard decorators with your own
export default compose(withErrorHandling, withLogging, withPreExecutionCheck)(myTool);
```


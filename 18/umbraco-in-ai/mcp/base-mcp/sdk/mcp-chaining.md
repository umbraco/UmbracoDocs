---
description: MCP chaining patterns for proxying, delegation, and composite tools across MCP servers.
---

# MCP Chaining

MCP chaining embeds an MCP client inside your MCP server, allowing your server to call other MCP servers to access their tools.

All LLM interaction happens in the host application (for example, Claude Desktop or Cursor), not inside the MCP server. The embedded client calls chained servers directly without any LLM reasoning. Your server receives a tool call from the host, calls the chained server, and returns the result.

This enables three patterns:

* **Proxying** — Re-expose tools from another server alongside your own. The AI sees them directly. Proxied tools are prefixed with the server name (for example, `cms--get-document`) to avoid naming conflicts.
* **Delegation** — Make a single hidden call to a chained server from within your tool handler. The AI does not see the chained tool. Use this when your tool needs one piece of data from another server.
* **Composite tools** — Orchestrate multiple chained calls into one tool. Without this, the AI would need to make each call separately. Use this to reduce LLM round-trips for multi-step workflows.

For example, a commerce MCP server could chain to the Umbraco Developer MCP Server (`@umbraco-cms/mcp-dev`). This gives the AI assistant access to both commerce and content tools without requiring separate server configuration.

## Setup

### 1. Configure Servers

Define the MCP servers you want to chain to:

```typescript
import {
  createMcpClientManager,
  type McpServerConfig,
} from "@umbraco-cms/mcp-server-sdk";

const servers: McpServerConfig[] = [
  {
    name: "cms",
    command: "npx",
    args: ["-y", "@umbraco-cms/mcp-dev@17.1"],
    // Environment variables from the parent process are inherited automatically.
    // Only specify env here to override or add variables.
    proxyTools: true,
  },
];
```

### 2. Create Client Manager

```typescript
const mcpClientManager = createMcpClientManager({
  filterConfig: { slices: ["read", "list"] },
});

for (const server of servers) {
  mcpClientManager.registerServer(server);
}
```

### 3. Register Proxied Tools

```typescript
import { discoverProxiedTools } from "@umbraco-cms/mcp-server-sdk";

const proxiedTools = await discoverProxiedTools(mcpClientManager);
// Returns: [{ prefixedName: "cms--get-document", serverName: "cms", ... }]
```

### 4. Cleanup on Shutdown

```typescript
process.on("SIGINT", async () => {
  await mcpClientManager.disconnectAll();
  process.exit(0);
});
```

## Pattern 1: Proxying

Proxying exposes tools from a chained server to the LLM. Each proxied tool gets a prefix based on the server name (for example, `cms--get-document`).

When `proxyTools` is `true` (the default) on a server config, `discoverProxiedTools` connects to the server, lists its tools, and returns `ProxiedTool` objects.

The SDK also exports lower-level utilities (`parseProxiedToolName`, `createProxyHandler`, `proxiedToolsToDefinitions`) for fine-grained control over proxied tools if needed.

## Pattern 2: Delegation

Delegation makes a single call to a chained server from inside your tool handler. Unlike proxying, the chained tool is not exposed to the AI assistant. Use delegation when your tool needs one piece of data from another server. For example, you could fetch a document from the CMS to include in your response.

```typescript
import { createToolResult } from "@umbraco-cms/mcp-server-sdk";

const myTool = {
  name: "summarize-document",
  description: "Get a document and summarize its properties",
  inputSchema: {
    id: z.string().uuid(),
  },
  slices: ["read"],
  handler: async ({ id }) => {
    // Delegate to chained CMS server
    const result = await mcpClientManager.callTool(
      "cms",
      "get-document",
      { id }
    );

    if (result.isError) {
      return result;
    }

    // Process the result
    const doc = result.structuredContent;
    return createToolResult({
      name: doc.name,
      propertyCount: doc.values?.length ?? 0,
    });
  },
};
```

## Pattern 3: Composite Tools

Composite tools combine multiple chained calls into a single tool. Without a composite tool, the AI would need to make each call separately and reason about the results between steps. A composite tool handles the entire workflow in one invocation, reducing LLM round-trips.

```typescript
const syncContentTool = {
  name: "sync-content",
  description: "Copy content from source to target document",
  inputSchema: {
    sourceId: z.string().uuid().describe("Source document ID"),
    targetId: z.string().uuid().describe("Target document ID"),
  },
  slices: ["update"],
  handler: async ({ sourceId, targetId }) => {
    // Step 1: Get source document
    const sourceResult = await mcpClientManager.callTool(
      "cms",
      "get-document",
      { id: sourceId }
    );

    if (sourceResult.isError) {
      return sourceResult;
    }

    const source = sourceResult.structuredContent;

    // Step 2: Update target with source values
    const updateResult = await mcpClientManager.callTool(
      "cms",
      "update-document",
      {
        id: targetId,
        values: source.values,
      }
    );

    return updateResult;
  },
};
```

## Environment Variable Passthrough

All environment variables from the parent process flow through to chained servers automatically. Filtering configuration such as `UMBRACO_TOOL_MODES`, `UMBRACO_INCLUDE_SLICES`, `UMBRACO_READONLY`, and all other [tool filtering](./tool-filtering.md) variables are included. If your server is set to read-only mode, chained servers inherit that setting without additional configuration.

You can override specific variables per server using the `env` property in the server configuration. Any values you set there are merged on top of the inherited environment.

## Key Methods

| Method | Description |
|---|---|
| `callTool(serverName, toolName, args)` | Call a tool on a chained server |
| `listTools(serverName)` | List available tools on a chained server |
| `disconnectAll()` | Disconnect from all servers (call on shutdown) |


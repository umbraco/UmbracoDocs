---
description: Generate per-tool TypeScript types from your MCP server's collections so downstream MCPs can chain calls with full compile-time safety.
---

# Tool Types Codegen

Downstream MCPs that chain another MCP server's tools (via `mcpClientManager.callTool(...)`) usually want compile-time types for tool inputs and outputs. The SDK ships a CLI binary that walks your built collections and emits a single `.d.ts` registry covering every tool.

The boundary between two MCPs is type-safe at compile time. Renaming a tool, changing its input schema, or adding a required field surfaces as a TypeScript error in every consumer that imports the registry.

## How It Works

The codegen runs after your build:

1. Dynamic-imports your compiled `dist/collections.js`.
2. Walks every `collection.tools(user)` using a synthetic permissive user that passes any authorization check.
3. Runs each tool's input and output Zod schema through `z.toJSONSchema()`, then through `json-schema-to-typescript`.
4. Writes a single `.d.ts` file containing per-tool interfaces and a registry interface that maps tool names to `{ input, output }` pairs.

{% hint style="info" %}
Types are compile-time only. Runtime Zod validation inside each MCP remains authoritative — the codegen does not change runtime behaviour.
{% endhint %}

## Setup

Add the codegen as a `postbuild` script in your MCP package's `package.json`, and expose the generated `.d.ts` via a `./tool-types` export so consumers can import it:

```json
{
  "scripts": {
    "build": "tsup",
    "postbuild": "umbraco-mcp-generate-types --registry-name CmsTools"
  },
  "exports": {
    "./tool-types": { "types": "./dist/tool-types.d.ts" }
  }
}
```

That's the entire setup. Every `npm run build` regenerates the types.

## CLI Options

| Flag | Default | Purpose |
|---|---|---|
| `--collections <path>` | `./dist/collections.js` | Compiled module that exports a `collections` array (or default-exports one). |
| `--out <path>` | `./dist/tool-types.d.ts` | Output `.d.ts` path. Parent directories are created if missing. |
| `--registry-name <name>` | derived from `package.json` | Name of the emitted registry interface. Default strips the npm scope and PascalCases the package name (for example, `@umbraco-cms/mcp-cms` → `McpCmsTools`). |
| `--help`, `-h` | — | Show usage and exit. |

## Generated Output

A typical generated file looks like this:

```typescript
export interface GetDocumentByIdInput {
  id: string;
}

export interface GetDocumentByIdOutput {
  id: string;
  variants: { culture?: string | null; name: string }[];
  // ...
}

export interface CmsTools {
  "get-document-by-id": {
    input: GetDocumentByIdInput;
    output: GetDocumentByIdOutput;
  };
  // ... one entry per tool
}

export type CmsToolsName = keyof CmsTools;
```

## Consuming the Registry

A downstream MCP imports the registry to type its chained calls:

```typescript
import type {
  CmsTools,
  CmsToolsName,
} from "@umbraco-cms/mcp-cms/tool-types";

async function callCms<N extends CmsToolsName>(
  name: N,
  args: CmsTools[N]["input"],
): Promise<CmsTools[N]["output"]> {
  return mcpClientManager.callTool("cms", name, args) as Promise<
    CmsTools[N]["output"]
  >;
}
```

The TypeScript compiler now enforces:

* That `name` is a real tool exported by the chained server.
* That `args` matches the tool's input schema.
* That callers handle the tool's actual output shape.

For chaining patterns more broadly (proxying, delegation, composite tools), see [MCP Chaining](./mcp-chaining.md).

## Caveats

* **Schema conversion failures fall back gracefully.** If a single tool's input or output schema cannot be converted to a JSON Schema, the registry falls back to `Record<string, unknown>` for that input or `unknown` for that output. The build still succeeds, and the binary logs the skipped tools at the end.
* **Type-name collisions are detected.** Two tool names that PascalCase to the same identifier (for example, `get-document` and `getDocument`) cause the binary to fail with a clear error naming both colliding tools. Rename one before publishing.
* **Tools with no schema are generic.** A tool with neither `inputSchema` nor `outputSchema` produces `Record<string, unknown>` / `unknown` registry entries. This is intentional — the codegen has nothing to narrow the type to.

## Programmatic API

For tests or custom build pipelines that need to walk every tool with the same permissive user the CLI uses:

```typescript
import { createPermissiveCodegenUser } from "@umbraco-cms/mcp-server-sdk";

const tools = collections.flatMap((c) =>
  c.tools(createPermissiveCodegenUser()),
);
```

Pass the returned object only to `collection.tools(user)` — its properties are Proxy-backed and not safe to read directly (`user.id` is not a string).

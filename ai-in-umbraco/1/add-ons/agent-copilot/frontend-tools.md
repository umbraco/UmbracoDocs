---
description: >-
    Defining and handling frontend tools for agents.
---

# Frontend Tools

Frontend tools allow agents to perform actions in the browser. When an agent calls a tool, the frontend receives the call and executes the action.

## How Frontend Tools Work

```
┌────────────────────────────────────────────────────────────┐
│                    Frontend Tool Flow                      │
│                                                            │
│  Agent                    Frontend                         │
│    │                         │                             │
│    ├── tool_call_start ─────►│                             │
│    ├── tool_call_args ──────►│                             │
│    ├── tool_call_end ───────►│ Execute action              │
│    │                         │      │                      │
│    │◄── tool_call_result ────│◄─────┘                      │
│    │                         │                             │
│    └── Continue generation   │                             │
└────────────────────────────────────────────────────────────┘
```

## Defining Tools

Tools are defined when running the agent:

{% code title="FrontendToolDefinitions.cs" %}

```csharp
var frontendTools = new[]
{
    new AIFrontendToolDefinition
    {
        Name = "insert_content",
        Description = "Insert content at the current cursor position in the editor",
        Parameters = new JsonObject
        {
            ["type"] = "object",
            ["properties"] = new JsonObject
            {
                ["content"] = new JsonObject
                {
                    ["type"] = "string",
                    ["description"] = "The content to insert"
                }
            },
            ["required"] = new JsonArray { "content" }
        }
    },
    new AIFrontendToolDefinition
    {
        Name = "replace_selection",
        Description = "Replace the currently selected text",
        Parameters = new JsonObject
        {
            ["type"] = "object",
            ["properties"] = new JsonObject
            {
                ["newContent"] = new JsonObject
                {
                    ["type"] = "string",
                    ["description"] = "The replacement content"
                }
            },
            ["required"] = new JsonArray { "newContent" }
        }
    }
};

await foreach (var evt in _agentService.StreamAgentAsync(
    agentId,
    request,
    frontendTools))
{
    // Handle events
}
```

{% endcode %}

## Tool Schema

Tools use JSON Schema for parameter definitions:

{% code title="Tool Definition" %}

```json
{
    "name": "search_content",
    "description": "Search for content in the CMS",
    "parameters": {
        "type": "object",
        "properties": {
            "query": {
                "type": "string",
                "description": "Search query"
            },
            "contentType": {
                "type": "string",
                "enum": ["article", "page", "product"],
                "description": "Type of content to search"
            },
            "limit": {
                "type": "integer",
                "default": 10,
                "description": "Maximum results to return"
            }
        },
        "required": ["query"]
    }
}
```

{% endcode %}

## Handling Tool Calls

### Frontend Handler

{% code title="tool-handler.ts" %}

```typescript
interface ToolHandler {
    name: string;
    execute: (args: unknown) => Promise<unknown>;
}

const toolHandlers: ToolHandler[] = [
    {
        name: "insert_content",
        execute: async (args: { content: string }) => {
            const editor = getActiveEditor();
            editor.insertAtCursor(args.content);
            return { success: true, insertedLength: args.content.length };
        },
    },
    {
        name: "replace_selection",
        execute: async (args: { newContent: string }) => {
            const editor = getActiveEditor();
            const oldContent = editor.getSelection();
            editor.replaceSelection(args.newContent);
            return {
                success: true,
                replacedContent: oldContent,
                newContent: args.newContent,
            };
        },
    },
    {
        name: "search_content",
        execute: async (args: { query: string; contentType?: string; limit?: number }) => {
            const results = await searchApi.search({
                query: args.query,
                type: args.contentType,
                limit: args.limit || 10,
            });
            return { results };
        },
    },
];

function handleToolCall(toolName: string, args: unknown): Promise<unknown> {
    const handler = toolHandlers.find((h) => h.name === toolName);
    if (!handler) {
        return Promise.resolve({ error: `Unknown tool: ${toolName}` });
    }
    return handler.execute(args);
}
```

{% endcode %}

### Sending Results Back

Tool results may need to be sent back to continue the conversation:

{% code title="handle-agent-events.ts" %}

```typescript
async function handleAgentEvents(events: AsyncIterable<AgentEvent>) {
    for await (const event of events) {
        if (event.type === "tool_call_end") {
            const result = await handleToolCall(event.toolName, event.args);

            // If the protocol requires sending results back
            await sendToolResult(event.toolCallId, result);
        }
    }
}
```

{% endcode %}

## Common Tool Patterns

### Content Manipulation

```json
{
    "name": "insert_heading",
    "description": "Insert a heading at the cursor",
    "parameters": {
        "type": "object",
        "properties": {
            "level": { "type": "integer", "minimum": 1, "maximum": 6 },
            "text": { "type": "string" }
        },
        "required": ["level", "text"]
    }
}
```

### UI Actions

```json
{
    "name": "open_media_picker",
    "description": "Open the media picker dialog",
    "parameters": {
        "type": "object",
        "properties": {
            "allowedTypes": {
                "type": "array",
                "items": { "type": "string" }
            }
        }
    }
}
```

### Data Retrieval

```json
{
    "name": "get_linked_content",
    "description": "Get content linked from the current page",
    "parameters": {
        "type": "object",
        "properties": {
            "relationshipType": {
                "type": "string",
                "enum": ["parent", "children", "related"]
            }
        }
    }
}
```

## Best Practices

1. **Single responsibility** - Each tool does one thing
2. **Clear descriptions** - Help the model choose correctly
3. **Validate parameters** - Check inputs before execution
4. **Return meaningful results** - Help the model understand outcomes
5. **Handle errors gracefully** - Return error objects, don't throw

## Related

- [Copilot](copilot.md) - Using the chat interface
- [Concepts](../agent/concepts.md) - Agent and tool concepts
- [Streaming](../agent/streaming.md) - Event handling

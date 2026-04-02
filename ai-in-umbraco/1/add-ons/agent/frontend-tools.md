---
description: >-
    Defining and handling frontend tools for agents.
---

# Frontend Tools

{% hint style="warning" %}
Frontend tools are part of the [`Umbraco.AI.Agent.Copilot`](../agent-copilot/README.md) package. See the [Agent Copilot frontend tools documentation](../agent-copilot/frontend-tools.md) for full details.
{% endhint %}

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

## Related

- [Agent Copilot](../agent-copilot/README.md) - Full Copilot package documentation
- [Concepts](concepts.md) - Agent and tool concepts
- [Streaming](streaming.md) - Event handling

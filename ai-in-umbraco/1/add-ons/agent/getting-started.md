---
description: >-
    Get started with Agent Runtime.
---

# Getting Started with Agents

This guide walks you through creating and running your first AI agent.

## Prerequisites

Before starting, ensure you have:

- Umbraco.AI installed and configured
- At least one AI connection set up
- At least one chat profile created

## Step 1: Install the Package

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Agent
```

{% endcode %}

Restart your application to run database migrations.

## Step 2: Create an Agent in Backoffice

1. Navigate to the **AI** section > **Agents**
2. Click **Create Agent**
3. Fill in the details:

| Field        | Value                          |
| ------------ | ------------------------------ |
| Alias        | `writing-assistant`            |
| Name         | Writing Assistant              |
| Description  | Helps improve and edit content |
| Instructions | See below                      |
| Profile      | (select your chat profile)     |

**Instructions:**

```
You are a helpful writing assistant for a content management system.

Your capabilities:
- Improve grammar and clarity
- Suggest better word choices
- Help structure content
- Provide writing tips

Guidelines:
- Be concise and helpful
- Explain your suggestions
- Maintain the author's voice
- Ask clarifying questions when needed
```

4. Click **Save**

## Step 3: Create an API Endpoint

Create a controller to expose the agent:

{% code title="AgentController.cs" %}

```csharp
[ApiController]
[Route("api/agent")]
public class AgentController : ControllerBase
{
    private readonly IAIAgentService _agentService;

    public AgentController(IAIAgentService agentService)
    {
        _agentService = agentService;
    }

    [HttpPost("{alias}/run")]
    public async Task Run(string alias, [FromBody] AgentRunRequest request)
    {
        var agent = await _agentService.GetAgentByAliasAsync(alias);
        if (agent == null)
        {
            Response.StatusCode = 404;
            return;
        }

        Response.ContentType = "text/event-stream";
        Response.Headers.Add("Cache-Control", "no-cache");
        Response.Headers.Add("Connection", "keep-alive");

        await foreach (var evt in _agentService.StreamAgentAsync(
            agent.Id,
            new AIAgentRunRequest
            {
                Messages = request.Messages.Select(m => new AIAgentMessage
                {
                    Role = m.Role,
                    Content = m.Content
                }).ToList()
            }))
        {
            var json = JsonSerializer.Serialize(evt, new JsonSerializerOptions
            {
                PropertyNamingPolicy = JsonNamingPolicy.CamelCase
            });

            await Response.WriteAsync($"event: {evt.Type}\n");
            await Response.WriteAsync($"data: {json}\n\n");
            await Response.Body.FlushAsync();
        }
    }
}

public class AgentRunRequest
{
    public List<MessageDto> Messages { get; set; } = new();
}

public class MessageDto
{
    public string Role { get; set; } = "user";
    public string Content { get; set; } = "";
}
```

{% endcode %}

## Step 4: Create a Frontend Client

{% code title="agent-client.ts" %}

```typescript
interface AgentEvent {
    type: string;
    content?: string;
    error?: string;
}

async function runAgent(alias: string, messages: { role: string; content: string }[]) {
    const response = await fetch(`/api/agent/${alias}/run`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ messages }),
    });

    const reader = response.body!.getReader();
    const decoder = new TextDecoder();
    let buffer = "";

    while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });
        const lines = buffer.split("\n");
        buffer = lines.pop() || "";

        for (const line of lines) {
            if (line.startsWith("data: ")) {
                const event: AgentEvent = JSON.parse(line.slice(6));
                handleEvent(event);
            }
        }
    }
}

function handleEvent(event: AgentEvent) {
    switch (event.type) {
        case "text_message_content":
            console.log("Content:", event.content);
            break;
        case "run_finished":
            console.log("Agent finished");
            break;
        case "run_error":
            console.error("Error:", event.error);
            break;
    }
}

// Usage
runAgent("writing-assistant", [{ role: "user", content: "Help me improve this sentence: The quick brown fox jumps." }]);
```

{% endcode %}

## Step 5: Test the Agent

1. Open your browser's developer console
2. Run the client code
3. Watch the streaming response arrive

## Next Steps

- Configure [Instructions](instructions.md) for better agent behavior
- Create [Orchestrated Agents](workflows.md) with multi-agent workflows
- Learn about [Streaming](streaming.md) for advanced event handling
- Install [Agent Copilot](../agent-copilot/README.md) for the chat sidebar UI
- Add [Frontend Tools](../agent-copilot/frontend-tools.md) for interactive capabilities
- Review the [API Reference](api/README.md) for programmatic access

---
description: >-
    Agent Runtime add-on for configuring and running AI agents with streaming responses.
---

# Agent Runtime

The Agent Runtime add-on (`Umbraco.AI.Agent`) enables you to configure and run AI agents that can interact with users through streaming responses and execute frontend tools.

## Installation

{% code title="Package Manager Console" %}

```powershell
Install-Package Umbraco.AI.Agent
```

{% endcode %}

Or via .NET CLI:

{% code title="Terminal" %}

```bash
dotnet add package Umbraco.AI.Agent
```

{% endcode %}

## Features

- **Standard Agents** - Configure reusable AI agents with instructions and tool permissions
- **Orchestrated Agents** - Compose multiple agents into workflow pipelines
- **Custom Workflows** - Extensible workflow system for multi-agent orchestration
- **AG-UI Protocol** - Stream responses using the AG-UI event protocol
- **Profile Association** - Link agents to specific AI profiles
- **Context Injection** - Include AI Contexts for brand voice (standard agents)
- **Scopes** - Categorize agents for specific purposes (e.g., copilot)
- **Version History** - Track changes with full rollback support
- **Backoffice Management** - Full UI for managing agents
- **Management API** - RESTful API for agent operations

{% hint style="info" %}
For the **Copilot chat sidebar** with frontend tools and HITL approval, install the [Agent Copilot](../agent-copilot/README.md) add-on alongside this package.
{% endhint %}

## Quick Start

### 1. Create an Agent

In the backoffice, navigate to the **AI** section > **Agents** and create a new agent:

| Field        | Value                                                                        |
| ------------ | ---------------------------------------------------------------------------- |
| Alias        | `content-assistant`                                                          |
| Name         | Content Assistant                                                            |
| Instructions | `You are a helpful content assistant. Help users write and improve content.` |
| Profile      | (select your chat profile)                                                   |

### 2. Run the Agent

{% code title="AgentRunner.cs" %}

```csharp
public class AgentRunner
{
    private readonly IAIAgentService _agentService;

    public AgentRunner(IAIAgentService agentService)
    {
        _agentService = agentService;
    }

    public async Task RunAsync(HttpResponse response, CancellationToken cancellationToken)
    {
        var agent = await _agentService.GetAgentByAliasAsync("content-assistant", cancellationToken);

        response.ContentType = "text/event-stream";

        var request = new AGUIRunRequest
        {
            ThreadId = Guid.NewGuid().ToString(),
            RunId = Guid.NewGuid().ToString(),
            Messages =
            [
                new AGUIMessage
                {
                    Id = Guid.NewGuid().ToString(),
                    Role = AGUIMessageRole.User,
                    Content = "Help me write a blog post about AI"
                }
            ]
        };

        await foreach (var evt in _agentService.StreamAgentAGUIAsync(
            agent!.Id,
            request,
            frontendTools: null,
            cancellationToken))
        {
            // Write as a single SSE data line; the event type is embedded in the JSON payload.
            var json = JsonSerializer.Serialize(evt, typeof(BaseAGUIEvent));
            await response.WriteAsync($"data: {json}\n\n", cancellationToken);
            await response.Body.FlushAsync(cancellationToken);
        }
    }
}
```

{% endcode %}

### 3. Consume in Frontend

{% code title="agent-event-listener.ts" %}

```typescript
// AG-UI events arrive as a single SSE `data:` line each. The event type is
// embedded in the JSON payload as the `type` property.
const eventSource = new EventSource(
    "/umbraco/ai/management/api/v1/agents/content-assistant/stream-agui",
);

eventSource.addEventListener("message", (e) => {
    const evt = JSON.parse(e.data);
    switch (evt.type) {
        case "TEXT_MESSAGE_CONTENT":
            console.log("Content:", evt.delta);
            break;
        case "RUN_FINISHED":
            eventSource.close();
            break;
    }
});
```

{% endcode %}

## AG-UI Protocol

The Agent Runtime uses the AG-UI (Agent UI) protocol for streaming responses. The protocol defines event types for:

- **Lifecycle events** - `RUN_STARTED`, `RUN_FINISHED`, `RUN_ERROR`
- **Text streaming** - `TEXT_MESSAGE_START`, `TEXT_MESSAGE_CONTENT`, `TEXT_MESSAGE_END`
- **Tool calls** - `TOOL_CALL_START`, `TOOL_CALL_ARGS`, `TOOL_CALL_END`
- **State updates** - `STATE_SNAPSHOT`, `STATE_DELTA`

## Documentation

| Section                                            | Description                              |
| -------------------------------------------------- | ---------------------------------------- |
| [Concepts](concepts.md)                            | Agent types, architecture, AG-UI protocol |
| [Getting Started](getting-started.md)              | Step-by-step setup guide                 |
| [Instructions](instructions.md)                    | Standard agent instruction configuration |
| [Workflows](workflows.md)                          | Orchestrated agent workflows             |
| [Scopes](scopes.md)                                | Categorizing agents with scopes          |
| [Permissions](permissions.md)                      | Tool permissions and user group overrides |
| [Streaming](streaming.md)                          | SSE streaming and event handling         |
| [Frontend Client](frontend-client.md)              | UaiAgentClient for custom agent UIs      |
| [API Reference](api/README.md)                     | Management API endpoints                 |
| [Service Reference](reference/ai-agent-service.md) | IAIAgentService                          |

For Copilot-specific features:

| Section                                              | Description                     |
| ---------------------------------------------------- | ------------------------------- |
| [Copilot Overview](../agent-copilot/README.md)       | Chat sidebar and tool execution |
| [Frontend Tools](../agent-copilot/frontend-tools.md) | Browser-executable tools        |
| [Copilot Usage](../agent-copilot/copilot.md)         | Using the chat interface        |

## Related

- [Add-ons Overview](../README.md) - All add-on packages
- [AI Contexts](../../concepts/contexts.md) - Brand voice and guidelines
- [Profiles](../../concepts/profiles.md) - AI configuration

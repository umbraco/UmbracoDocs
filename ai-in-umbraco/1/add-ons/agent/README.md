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

    public async Task RunAsync(HttpResponse response)
    {
        var agent = await _agentService.GetAgentByAliasAsync("content-assistant");

        response.ContentType = "text/event-stream";

        await foreach (var evt in _agentService.StreamAgentAsync(
            agent!.Id,
            new AIAgentRunRequest
            {
                Messages = new[]
                {
                    new AIAgentMessage { Role = "user", Content = "Help me write a blog post about AI" }
                }
            }))
        {
            // Write SSE events
            await response.WriteAsync($"event: {evt.Type}\n");
            await response.WriteAsync($"data: {JsonSerializer.Serialize(evt)}\n\n");
            await response.Body.FlushAsync();
        }
    }
}
```

{% endcode %}

### 3. Consume in Frontend

{% code title="agent-event-listener.ts" %}

```typescript
const eventSource = new EventSource("/api/agent/content-assistant/run");

eventSource.addEventListener("text_message_content", (e) => {
    const data = JSON.parse(e.data);
    console.log("Content:", data.content);
});

eventSource.addEventListener("run_finished", () => {
    eventSource.close();
});
```

{% endcode %}

## AG-UI Protocol

The Agent Runtime uses the AG-UI (Agent UI) protocol for streaming responses. This protocol defines event types for:

- **Lifecycle events** - `run_started`, `run_finished`, `run_error`
- **Text streaming** - `text_message_start`, `text_message_content`, `text_message_end`
- **Tool calls** - `tool_call_start`, `tool_call_args`, `tool_call_end`
- **State updates** - `state_snapshot`, `state_delta`

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

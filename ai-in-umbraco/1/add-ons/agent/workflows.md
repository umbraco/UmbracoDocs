---
description: >-
    Create custom workflows for orchestrated agents.
---

# Agent Workflows

Workflows are code-based extension points that define how orchestrated agents compose multiple sub-agents into a pipeline. Each workflow is a C# class that builds a Microsoft Agents Framework (MAF) `Workflow` from an agent definition and optional settings.

## Overview

When you create an **orchestrated agent** in the backoffice, you select a registered workflow and optionally configure its settings. At runtime, the workflow builds a graph of sub-agents that collaborate to produce a response.

```
┌─────────────────────────────────────────────────────────────┐
│               Orchestrated Agent Execution                   │
│                                                              │
│  Agent Config ──► Workflow.BuildWorkflowAsync()              │
│                        │                                     │
│                        ▼                                     │
│              ┌─── MAF Workflow ───┐                          │
│              │  Agent A ──► Agent B ──► Agent C              │
│              └────────────────────┘                          │
│                        │                                     │
│                        ▼                                     │
│                  AG-UI Events (SSE)                          │
└─────────────────────────────────────────────────────────────┘
```

## Creating a Workflow

### Step 1: Define the Workflow Class

Create a class that extends `AIAgentWorkflowBase` and apply the `[AIAgentWorkflow]` attribute:

{% code title="SimpleSequentialWorkflow.cs" %}

```csharp
using Microsoft.Agents.AI;
using Microsoft.Agents.AI.Workflows;
using Umbraco.AI.Agent.Core.Chat;
using Umbraco.AI.Agent.Core.Workflows;
using Umbraco.AI.Core.Chat;
using Umbraco.AI.Core.Models;
using Umbraco.AI.Core.Profiles;
using UmbracoAIAgent = Umbraco.AI.Agent.Core.Agents.AIAgent;

[AIAgentWorkflow("research-and-summarize", "Research and Summarize",
    Description = "A researcher gathers information, then a summarizer condenses it.")]
public class ResearchAndSummarizeWorkflow : AIAgentWorkflowBase
{
    private readonly IAIChatClientFactory _chatClientFactory;
    private readonly IAIProfileService _profileService;

    public ResearchAndSummarizeWorkflow(
        IAIChatClientFactory chatClientFactory,
        IAIProfileService profileService)
    {
        _chatClientFactory = chatClientFactory;
        _profileService = profileService;
    }

    protected override async Task<Workflow> BuildWorkflowAsync(
        UmbracoAIAgent agent,
        JsonElement? settings,
        CancellationToken cancellationToken)
    {
        // Resolve the AI profile
        var profile = agent.ProfileId.HasValue
            ? await _profileService.GetProfileAsync(agent.ProfileId.Value, cancellationToken)
                ?? throw new InvalidOperationException($"Profile '{agent.ProfileId}' not found.")
            : await _profileService.GetDefaultProfileAsync(AICapability.Chat, cancellationToken);

        var chatClient = await _chatClientFactory.CreateClientAsync(profile, cancellationToken);

        // Create sub-agents
        var researcher = new ChatClientAgent(
            chatClient,
            instructions: "You are a researcher. Gather detailed information about the topic.",
            name: "Researcher");

        var summarizer = new ChatClientAgent(
            chatClient,
            instructions: "You are a summarizer. Condense the research into a clear, concise summary.",
            name: "Summarizer");

        // Build sequential workflow: researcher → summarizer
        return AgentWorkflowBuilder.BuildSequential("research-and-summarize", [researcher, summarizer]);
    }
}
```

{% endcode %}

The workflow is automatically discovered and registered at startup.

### Step 2: Create an Orchestrated Agent

In the backoffice, create a new agent:

1. Navigate to **AI** > **Agents** > **Create Agent**
2. Set the **Agent Type** to **Orchestrated**
3. Select the **Research and Summarize** workflow
4. Optionally select a profile
5. Save

Or via code:

{% code title="CreateOrchestratedAgent.cs" %}

```csharp
var agent = new AIAgent
{
    Alias = "research-summarize",
    Name = "Research and Summarize",
    AgentType = AIAgentType.Orchestrated,
    Config = new AIOrchestratedAgentConfig
    {
        WorkflowId = "research-and-summarize"
    },
    IsActive = true
};

await _agentService.SaveAgentAsync(agent);
```

{% endcode %}

## Workflows with Settings

Workflows can declare typed settings that are configurable in the backoffice. Define settings as a C# class with `[AIField]` attributes for UI generation.

### Step 1: Define the Settings Class

{% code title="WriteAndEditSettings.cs" %}

```csharp
using Umbraco.AI.Core.EditableModels;

public class WriteAndEditSettings
{
    [AIField(Label = "Writing Style",
        Description = "The writing style (e.g. formal, casual, technical)")]
    public string WritingStyle { get; set; } = "professional";

    [AIField(Label = "Editing Focus",
        Description = "What the editor should focus on (e.g. clarity, grammar)")]
    public string EditingFocus { get; set; } = "clarity and conciseness";
}
```

{% endcode %}

### Step 2: Create a Typed Workflow

Extend `AIAgentWorkflowBase<TSettings>` to receive strongly-typed settings:

{% code title="WriteAndEditWorkflow.cs" %}

```csharp
[AIAgentWorkflow("write-and-edit", "Write and Edit",
    Description = "A sequential pipeline: a writer drafts content, then an editor refines it.")]
public class WriteAndEditWorkflow : AIAgentWorkflowBase<WriteAndEditSettings>
{
    private readonly IAIChatClientFactory _chatClientFactory;
    private readonly IAIProfileService _profileService;

    public WriteAndEditWorkflow(
        IAIEditableModelSchemaBuilder schemaBuilder,
        IAIChatClientFactory chatClientFactory,
        IAIProfileService profileService)
        : base(schemaBuilder)
    {
        _chatClientFactory = chatClientFactory;
        _profileService = profileService;
    }

    protected override async Task<Workflow> BuildWorkflowAsync(
        AIAgent agent,
        WriteAndEditSettings settings,
        CancellationToken cancellationToken)
    {
        var profile = agent.ProfileId.HasValue
            ? await _profileService.GetProfileAsync(agent.ProfileId.Value, cancellationToken)
                ?? throw new InvalidOperationException($"Profile '{agent.ProfileId}' not found.")
            : await _profileService.GetDefaultProfileAsync(AICapability.Chat, cancellationToken);

        var chatClient = await _chatClientFactory.CreateClientAsync(profile, cancellationToken);

        var writer = new ChatClientAgent(
            chatClient,
            instructions: $"You are a writer. Write content in a {settings.WritingStyle} style.",
            name: "Writer");

        var editor = new ChatClientAgent(
            chatClient,
            instructions: $"You are an editor. Focus on {settings.EditingFocus}. " +
                          "Improve the text while preserving the original meaning.",
            name: "Editor");

        return AgentWorkflowBuilder.BuildSequential("write-and-edit", [writer, editor]);
    }
}
```

{% endcode %}

The `[AIField]` attributes on the settings class generate a dynamic form in the backoffice, allowing editors to configure the workflow without touching code.

### Step 3: Create Agent with Settings

{% code title="CreateAgentWithWorkflowSettings.cs" %}

```csharp
var agent = new AIAgent
{
    Alias = "write-and-edit",
    Name = "Write and Edit Pipeline",
    AgentType = AIAgentType.Orchestrated,
    Config = new AIOrchestratedAgentConfig
    {
        WorkflowId = "write-and-edit",
        Settings = JsonSerializer.SerializeToElement(new
        {
            writingStyle = "casual",
            editingFocus = "grammar and readability"
        })
    },
    IsActive = true
};
```

{% endcode %}

## Related

- [Agent Concepts](concepts.md) - Agent types overview
- [Getting Started](getting-started.md) - Creating your first agent
- [API Create](api/create.md) - Creating agents via API
- [AIAgent Reference](reference/ai-agent.md) - Model reference

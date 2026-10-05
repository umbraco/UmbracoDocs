---
description: >-
    Control which agent handles a request in Auto mode by writing and ordering custom agent selectors.
---

# Agent Selection

When a user chats with **Auto** selected, Umbraco.AI decides which agent handles each message. Both [Contextual Copilot](../add-ons/agent-copilot/copilot.md) and [Copilot Workspace](../add-ons/copilot-workspace/README.md) use the same selection chain.

You can add your own rules to the chain. For example, you can route requests from a specific section to a specialist agent, or keep the same agent for a whole conversation.

## How Auto Mode Works

Each Auto request goes through the following steps:

1. The surface's agents are filtered to the **candidates**: agents that are active and pass their scope rules for the current surface and context.
2. If there are no candidates, the request fails with a 404 error.
3. If there is exactly one candidate, it is used. No selector runs.
4. Otherwise, the registered selectors run in order. The first selector that returns a candidate wins, and later selectors do not run.
5. If no selector picks an agent, the first candidate is used.

The built-in `LLMAgentSelector` is the only selector registered by default. The selector asks a chat model to pick an agent based on each agent's name and description.

## Safety Guarantees

The selection chain protects scope rules and keeps running when a selector misbehaves:

- **Scope is never bypassed.** Candidate filtering runs before any selector. A selector can only choose from agents that are active and in scope for the current context.
- **Non-candidate results are ignored.** If a selector returns an agent that is not a candidate, the result is ignored, a warning is logged, and the next selector runs.
- **Throwing selectors are skipped.** If a selector throws, the error is logged and the next selector runs. Only a cancellation of the request itself stops the chain.
- **There is always a fallback.** When every selector returns `null` or is skipped, the first candidate is used.

## Creating a Selector

Implement `IAIAgentSelector` from the `Umbraco.AI.Agent.Core.Agents.Selection` namespace. Return an `AIAgentSelectionResult` to pick an agent, or `null` for "no opinion" so the next selector decides.

The following selector routes requests from the Media section to an agent with the alias `media-assistant`:

{% code title="MediaSectionAgentSelector.cs" %}

```csharp
using Umbraco.AI.Agent.Core.Agents.Selection;

namespace MyProject.AI;

public sealed class MediaSectionAgentSelector : IAIAgentSelector
{
    public Task<AIAgentSelectionResult?> SelectAgentAsync(
        AIAgentSelectionRequest request,
        CancellationToken cancellationToken = default)
    {
        if (request.AvailabilityContext.Section != "media")
        {
            // No opinion - let the next selector decide.
            return Task.FromResult<AIAgentSelectionResult?>(null);
        }

        // Only pick from the candidates. The agent may be inactive or out of scope.
        var agent = request.CandidateAgents.FirstOrDefault(a => a.Alias == "media-assistant");

        return Task.FromResult(agent is null
            ? null
            : new AIAgentSelectionResult(agent, "media-section", "User is in the Media section"));
    }
}
```

{% endcode %}

`AIAgentSelectionResult` takes three values:

| Parameter | Type | Description |
|-----------|------|-------------|
| `Agent` | `AIAgent` | The selected agent. Must be one of `CandidateAgents`. |
| `SelectorId` | `string` | A short, stable identifier for your selector, for example `media-section`. |
| `Reason` | `string?` | An optional, human-readable explanation for the pick. |

{% hint style="warning" %}
`SelectorId` and `Reason` are stored as-is in the agent run's audit log. They are also sent to the browser in the `agent_selected` event. Keep them short and free of personal or sensitive data.
{% endhint %}

Selectors are resolved from dependency injection as singletons. Inject singleton services into the constructor. To use a scoped service, inject `IServiceScopeFactory` and create a scope inside `SelectAgentAsync`.

## Registering and Ordering Selectors

Use the `AIAgentSelectors()` extension method on `IUmbracoBuilder` in a Composer. The extension method lives in the `Umbraco.AI.Agent.Extensions` namespace.

The collection is ordered. Use `InsertBefore` to run your selector ahead of the built-in `LLMAgentSelector`:

{% code title="AgentSelectionComposer.cs" %}

```csharp
using Umbraco.AI.Agent.Core.Agents.Selection;
using Umbraco.AI.Agent.Extensions;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace MyProject.AI;

public class AgentSelectionComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIAgentSelectors()
            .InsertBefore<LLMAgentSelector, MediaSectionAgentSelector>();
    }
}
```

{% endcode %}

Use `Append<T>()` to run your selector after the existing selectors instead. An appended selector only runs when `LLMAgentSelector` returns `null`, for example when no classifier profile is configured.

## What a Selector Receives

The `AIAgentSelectionRequest` exposes everything known about the request:

| Property | Type | Description |
|----------|------|-------------|
| `CandidateAgents` | `IReadOnlyList<AIAgent>` | Active, scope-available agents. Selectors can only return one of these. |
| `Messages` | `IReadOnlyList<ChatMessage>` | The messages sent with the request, including attachments. Contextual Copilot sends the full conversation. Copilot Workspace sends only the current turn. |
| `AvailabilityContext` | `AgentAvailabilityContext` | The `Surface`, `Section`, and `EntityType` the request came from. |
| `ContextItems` | `IReadOnlyList<AIRequestContextItem>` | All raw context items the frontend sent, such as the entity key. |
| `SurfaceId` | `string` | The surface the request was made from, for example `copilot`. |
| `UserGroupIds` | `IReadOnlyList<Guid>` | The current user's group IDs. Empty when there is no current user. |
| `FrontendTools` | `IReadOnlyList<AIFrontendTool>` | Tools the frontend offered for the request. |
| `PreviousAgent` | `AIAgent?` | The agent picked on the previous turn, if it is still a candidate. |

In Copilot Workspace, `ContextItems` is empty and `AvailabilityContext` only sets `Surface`.

## Built-in Selectors

| Selector | Selector ID | Registered by default | Behavior |
|----------|-------------|-----------------------|----------|
| `LLMAgentSelector` | `llm` | Yes | Sends the last user message and each candidate's name and description to the classifier chat profile. Returns `null` when no classifier or default chat profile is configured, or when the reply does not name a candidate. |
| `StickyAgentSelector` | `sticky` | No | Returns `PreviousAgent` when it is set, so the same agent handles the rest of the conversation. Returns `null` on the first turn. |

The classifier profile used by `LLMAgentSelector` is configured in [Settings](../concepts/settings.md#classifier-chat-profile).

### Keeping the Same Agent for a Conversation

By default, Auto mode picks an agent again for every message. To keep the first pick for the rest of the conversation, register `StickyAgentSelector` ahead of `LLMAgentSelector`:

{% code title="StickyAgentSelectionComposer.cs" %}

```csharp
using Umbraco.AI.Agent.Core.Agents.Selection;
using Umbraco.AI.Agent.Extensions;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace MyProject.AI;

public class StickyAgentSelectionComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        => builder.AIAgentSelectors().InsertBefore<LLMAgentSelector, StickyAgentSelector>();
}
```

{% endcode %}

## Built-in Selector IDs

The `AIAgentSelectorIds` class holds the built-in selector ID values. Use these constants in notification handlers and audit queries instead of copying the strings.

| Constant | Value | Recorded when |
|----------|-------|---------------|
| `AIAgentSelectorIds.Llm` | `llm` | `LLMAgentSelector` picked the agent |
| `AIAgentSelectorIds.Sticky` | `sticky` | `StickyAgentSelector` picked the agent |
| `AIAgentSelectorIds.OnlyCandidate` | `only-candidate` | Only one candidate was available, so no selector ran |
| `AIAgentSelectorIds.Fallback` | `fallback` | No selector picked an agent, so the first candidate was used |

Custom selectors choose their own ID. Use a short, stable, kebab-case value.

## The Previous Pick

`PreviousAgent` lets a selector take the previous turn into account. The two surfaces get the previous pick in different ways:

- **Contextual Copilot** sends the previous pick from the browser as `forwardedProps.previousAgentId`. Starting a new chat clears the value. For details, see [Stream Agent (AG-UI)](../add-ons/agent/api/stream-agui.md).
- **Copilot Workspace** reads the previous pick on the server, from the newest assistant message in the persisted conversation.

In both cases, the ID is resolved against the candidates. An ID that is missing, malformed, or no longer a candidate becomes `null`. A value sent by the browser is an untrusted hint and can never select an agent outside the candidates.

## Observing Selections

Every Auto pick publishes an `AIAgentSelectedNotification`, including `only-candidate` and `fallback` picks. The notification is published before the agent run starts and cannot be canceled.

The notification exposes:

- `Selection` (`AIAgentSelectionResult`): the picked agent, selector ID, and reason
- `Request` (`AIAgentSelectionRequest`): the request exactly as the selectors saw it
- `Messages` (`EventMessages`)

{% hint style="info" %}
Selected does not mean ran. `AIAgentExecutingNotification` is published afterwards and can still cancel the run.
{% endhint %}

For handler examples, see [Entity Lifecycle Notifications](notifications/entity-notifications.md#agent-selection-notifications).

## Migrating from SelectAgentForPromptAsync

`IAIAgentService.SelectAgentForPromptAsync` is obsolete and will be removed in v20. The obsolete method now runs the same selector chain and returns only the selected agent.

Use `IAIAgentSelectionService.SelectAgentAsync` instead. Pass the same values in an `AIAgentSelectionInput`, with the prompt as a user message. The method returns an `AIAgentSelectionResult`, so read the agent from its `Agent` property:

{% code title="AgentPicker.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Agent.Core.Agents;
using Umbraco.AI.Agent.Core.Agents.Selection;

namespace MyProject.AI;

public class AgentPicker
{
    private readonly IAIAgentSelectionService _agentSelectionService;

    public AgentPicker(IAIAgentSelectionService agentSelectionService)
        => _agentSelectionService = agentSelectionService;

    public async Task<AIAgent?> PickAgentAsync(
        string userPrompt,
        string surfaceId,
        AgentAvailabilityContext context,
        CancellationToken cancellationToken)
    {
        // Before: agentService.SelectAgentForPromptAsync(userPrompt, surfaceId, context, cancellationToken)
        AIAgentSelectionResult? result = await _agentSelectionService.SelectAgentAsync(
            new AIAgentSelectionInput
            {
                SurfaceId = surfaceId,
                AvailabilityContext = context,
                Messages = [new ChatMessage(ChatRole.User, userPrompt)],
                ContextItems = [],
            },
            cancellationToken);

        return result?.Agent;
    }
}
```

{% endcode %}

The result is `null` only when there are no candidates. The result also carries the `SelectorId` and `Reason`.

## Audit Log Metadata

For Auto runs, the agent run's audit log entry records the selection in its metadata:

| Key | Constant | Value |
|-----|----------|-------|
| `Umbraco.AI.Agent.SelectorId` | `Constants.ContextKeys.SelectorId` | The selector ID. Always set for Auto runs. |
| `Umbraco.AI.Agent.SelectionReason` | `Constants.ContextKeys.SelectionReason` | The reason. Only set when the selector gave a non-null reason. |

The constants are in the `Umbraco.AI.Agent.Core` namespace. Neither key is set for runs that name an agent explicitly.

## Related

{% content-ref url="../add-ons/agent-copilot/copilot.md" %}
[Contextual Copilot](../add-ons/agent-copilot/copilot.md)
{% endcontent-ref %}

{% content-ref url="notifications/README.md" %}
[Notifications](notifications/README.md)
{% endcontent-ref %}

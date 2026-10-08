---
description: >-
    Get structured, typed responses from chat completions using output schemas.
---

# Structured Output

Structured output constrains AI responses to match a specific JSON schema. This goes beyond the basic [JSON response format](advanced-options.md#requesting-json-output) by enforcing a schema at the provider level, producing predictable output you can deserialize directly.

## AIOutputSchema

`AIOutputSchema` defines the expected response structure. Create one from a .NET type or a raw JSON Schema document.

### From a Type

{% code title="FromType.cs" %}

```csharp
using Umbraco.AI.Core.Chat;

public class ContentSuggestion
{
    public string Title { get; set; } = string.Empty;
    public string Summary { get; set; } = string.Empty;
    public string[] Tags { get; set; } = [];
}

var schema = AIOutputSchema.FromType<ContentSuggestion>();
```

{% endcode %}

### From a JSON Schema

Use `FromJsonSchema` when the schema is defined at runtime (for example, from backoffice configuration or automation pipelines):

{% code title="FromJsonSchema.cs" %}

```csharp
using System.Text.Json;
using Umbraco.AI.Core.Chat;

var jsonSchema = """
{
    "type": "object",
    "properties": {
        "title": { "type": "string" },
        "summary": { "type": "string" },
        "tags": {
            "type": "array",
            "items": { "type": "string" }
        }
    },
    "required": ["title", "summary"]
}
""";

var schema = AIOutputSchema.FromJsonSchema(
    JsonDocument.Parse(jsonSchema).RootElement);
```

{% endcode %}

## Getting Structured Chat Responses

Use `.WithOutputSchema()` on the chat builder, then read the result with the `GetResult<T>()` extension method:

{% code title="StructuredChat.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Chat;
using Umbraco.AI.Extensions;

public class ContentAssistant
{
    private readonly IAIChatService _chatService;

    public ContentAssistant(IAIChatService chatService)
    {
        _chatService = chatService;
    }

    public async Task<ContentSuggestion> GetSuggestion(string topic)
    {
        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, $"Suggest a blog post about: {topic}")
        };

        var response = await _chatService.GetChatResponseAsync(
            chat => chat
                .WithAlias("content-suggestions")
                .WithOutputSchema(AIOutputSchema.FromType<ContentSuggestion>()),
            messages);

        return response.GetResult<ContentSuggestion>();
    }
}
```

{% endcode %}

### Reading Results

The `GetResult<T>()` and `TryGetResult<T>()` extension methods on `ChatResponse` handle parsing:

{% code title="ReadingResults.cs" %}

```csharp
using Umbraco.AI.Extensions;

// Throws if deserialization fails
var suggestion = response.GetResult<ContentSuggestion>();

// Safe version - returns false on failure
if (response.TryGetResult<ContentSuggestion>(out var result))
{
    Console.WriteLine(result.Title);
}

// Get raw JSON without deserializing to a type
JsonElement json = response.GetResult();
```

{% endcode %}

## Structured Agent Responses

Agents can also produce structured output. There are three ways to configure the output schema.

### Setting the Schema on the Agent Config

Set `OutputSchema` on a standard agent's configuration. The schema is stored as a JSON Schema document:

{% code title="AgentConfig.cs" %}

```csharp
using Umbraco.AI.Agent.Core.Agents;

var agent = new AIAgent
{
    Alias = "content-classifier",
    Name = "Content Classifier",
    AgentType = AIAgentType.Standard,
    Config = new AIStandardAgentConfig
    {
        Instructions = "Classify the given content into categories.",
        OutputSchema = JsonDocument.Parse("""
        {
            "type": "object",
            "properties": {
                "category": { "type": "string" },
                "confidence": { "type": "number" }
            },
            "required": ["category", "confidence"]
        }
        """).RootElement
    },
    IsActive = true
};

await _agentService.SaveAgentAsync(agent);
```

{% endcode %}

### Configuring in the Backoffice

In the agent detail view, the **Output Format** toggle switches between **Text** and **Structured**. When set to Structured, a JSON Schema editor appears where you define the expected response structure.

### Overriding at Runtime

Pass `OutputSchema` in `AIAgentExecutionOptions` to override the agent's configured schema at runtime:

{% code title="RuntimeOverride.cs" %}

```csharp
using Umbraco.AI.Agent.Core.Agents;
using Umbraco.AI.Core.Chat;

var options = new AIAgentExecutionOptions
{
    OutputSchema = AIOutputSchema.FromType<ClassificationResult>()
};
```

{% endcode %}

### Reading Agent Results

Use the `GetResult<T>()` extension method on `AgentResponse`:

{% code title="AgentResults.cs" %}

```csharp
using Umbraco.AI.Agent.Extensions;

// After running an agent that has an output schema configured
var classification = agentResponse.GetResult<ClassificationResult>();

// Safe version
if (agentResponse.TryGetResult<ClassificationResult>(out var result))
{
    Console.WriteLine(result.Category);
}
```

{% endcode %}

{% hint style="info" %}
Not all providers support structured output. When a provider does not support schema-constrained responses, the system falls back to standard text generation. Use `TryGetResult<T>()` when provider support is uncertain.
{% endhint %}

## When to Use Structured Output

| Scenario | Approach |
| --- | --- |
| Display AI text to users | Standard chat response |
| Parse AI output in code | `.WithOutputSchema()` + `GetResult<T>()` |
| Agent pipelines and automation | Agent `OutputSchema` config or runtime override |
| Basic JSON requests | `ChatResponseFormat.Json` (see [Advanced Options](advanced-options.md)) |

## Related

- [Advanced Options](advanced-options.md) - Basic JSON response format
- [IAIChatService](../../reference/services/ai-chat-service.md) - Chat service reference
- [Agent Concepts](../../add-ons/agent/concepts.md) - Agent types and configuration

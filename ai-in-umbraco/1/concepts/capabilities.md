---
description: >-
    Capabilities represent the types of AI operations that providers can support.
---

# Capabilities

A capability represents a type of AI operation. Providers implement capabilities to expose their features, and profiles are configured for a specific capability. Capabilities build on Microsoft.Extensions.AI (M.E.AI) interfaces.

## Available Capabilities

| Capability     | Description                                     | M.E.AI Interface                                |
| -------------- | ----------------------------------------------- | ----------------------------------------------- |
| **Chat**       | Conversational AI, text generation, completions | `IChatClient`                                   |
| **Embedding**  | Vector embeddings for semantic search           | `IEmbeddingGenerator<string, Embedding<float>>` |

## Chat Capability

The Chat capability provides conversational AI features:

- Text completion and generation
- Multi-turn conversations
- System prompts and instructions
- Streaming responses
- Tool/function calling

{% code title="Example.cs" %}

```csharp
var messages = new List<ChatMessage>
{
    new(ChatRole.System, "You are a helpful assistant."),
    new(ChatRole.User, "What is Umbraco?")
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat"),
    messages);
```

{% endcode %}

## Embedding Capability

The Embedding capability generates vector representations of text:

- Semantic search indexing
- Document similarity
- Clustering and classification
- Retrieval-augmented generation (RAG)

{% code title="Example.cs" %}

```csharp
var embedding = await _embeddingService.GenerateEmbeddingAsync(
    "Umbraco is a content management system");

// embedding.Vector contains the float array
```

{% endcode %}

## Capability and Profile Relationship

Each profile is configured for exactly one capability. This ensures type safety and appropriate settings:

```
Chat Profile
    ├── Capability: Chat
    ├── Connection: OpenAI Prod
    ├── Model: gpt-4o
    └── Settings: AIChatProfileSettings
            ├── Temperature: 0.7
            ├── MaxTokens: 2000
            └── SystemPrompt: "..."

Embedding Profile
    ├── Capability: Embedding
    ├── Connection: OpenAI Prod
    ├── Model: text-embedding-3-small
    └── Settings: AIEmbeddingProfileSettings
```

## Checking Provider Capabilities

Not all providers support all capabilities. You can check what a provider supports:

{% code title="Example.cs" %}

```csharp
var provider = _registry.GetProvider("openai");

if (provider.HasCapability<IAIChatCapability>())
{
    // Provider supports chat
}

if (provider.HasCapability<IAIEmbeddingCapability>())
{
    // Provider supports embeddings
}
```

{% endcode %}

## Capability Interfaces

Capabilities are defined by interfaces in `Umbraco.AI.Core`:

{% code title="IAIChatCapability.cs" %}

```csharp
public interface IAIChatCapability : IAICapability
{
    Task<IChatClient> CreateChatClientAsync(
        object settings,
        AIProfile profile,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

{% code title="IAIEmbeddingCapability.cs" %}

```csharp
public interface IAIEmbeddingCapability : IAICapability
{
    Task<IEmbeddingGenerator<string, Embedding<float>>> CreateEmbeddingGeneratorAsync(
        object settings,
        AIProfile profile,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Related

- [Providers](providers.md) - Implement capabilities
- [Profiles](profiles.md) - Configure capability-specific settings
- [Chat API](../using-the-api/chat/README.md) - Use the Chat capability
- [Embeddings API](../using-the-api/embeddings/README.md) - Use the Embedding capability

---
description: >-
    Capabilities represent the types of AI operations that providers can support.
---

# Capabilities

A capability represents a type of AI operation. Providers implement capabilities to expose their features, and profiles are configured for a specific capability. Capabilities build on Microsoft.Extensions.AI (M.E.AI) interfaces.

## Available Capabilities

| Capability          | Description                                     | M.E.AI Interface                                |
| ------------------- | ----------------------------------------------- | ----------------------------------------------- |
| **Chat**            | Conversational AI, text generation, completions | `IChatClient`                                   |
| **Embedding**       | Vector embeddings for semantic search           | `IEmbeddingGenerator<string, Embedding<float>>` |
| **Speech-to-Text**  | Audio transcription and voice input             | `ISpeechToTextClient`                           |
| **Decision**        | Typed yes/no, pick-one, and score answers (experimental) | None. Uses the Umbraco AI `IAIDecisionClient` |

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
    emb => emb.WithAlias("content-embedding"),
    "Umbraco is a content management system");

// embedding.Vector contains the float array
```

{% endcode %}

## Speech-to-Text Capability

The Speech-to-Text capability transcribes audio into text:

- Audio file transcription
- Real-time streaming transcription
- Language detection and hints
- Voice input for Contextual Copilot and Copilot Workspace

{% code title="Example.cs" %}

```csharp
var response = await _sttService.TranscribeAsync(
    stt => stt.WithAlias("voice-notes"),
    audioStream);

// response.Text contains the transcribed text
```

{% endcode %}

## Decision Capability

{% hint style="warning" %}
Decision is **experimental**. It is hidden unless the `Umbraco:AI:Experimental:Decision` feature flag is enabled. The C# API surface carries the `UMBRACOAI_DECISION` diagnostic, which consumers must suppress. See [Decision](../using-the-api/decision/README.md) for how to enable it.
{% endhint %}

The Decision capability answers a typed question instead of returning free text:

- Yes/no questions, answered with a probability
- Pick-one questions, answered with the key of one of 2 to 255 options
- Score questions, answered against 2 to 10 labelled levels

Microsoft.Extensions.AI has no abstraction for this kind of model. Decision uses the Umbraco AI `IAIDecisionClient` interface instead.

{% code title="Example.cs" %}

```csharp
#pragma warning disable UMBRACOAI_DECISION

var response = await _decisionService.AskAsync(
    new AIBinaryDecisionQuestion { Instructions = "Is this comment spam?" },
    commentText);

// response.Answer.TrueProbability is the chance of "yes"; IsTrue() applies a 0.5 threshold
bool isSpam = response.Answer.IsTrue();
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

Speech-to-Text Profile
    ├── Capability: Speech-to-Text
    ├── Connection: OpenAI Prod
    ├── Model: whisper-1
    └── Settings: AISpeechToTextProfileSettings

Decision Profile
    ├── Capability: Decision
    ├── Connection: TypeSafe AI
    ├── Model: jev-latest
    └── Settings: AIDecisionProfileSettings (no settings today)
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

if (provider.HasCapability<IAISpeechToTextCapability>())
{
    // Provider supports speech-to-text
}

if (provider.HasCapability<IAIDecisionCapability>())
{
    // Provider supports decisions (experimental, needs UMBRACOAI_DECISION suppressed)
}
```

{% endcode %}

Experimental capabilities can be switched off for a whole install. To find the capabilities enabled on the current install, call the `GET /umbraco/ai/management/api/v1/capabilities/enabled` endpoint. See [List Capabilities](../management-api/connections/capabilities.md#list-enabled-capabilities).

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

{% code title="IAISpeechToTextCapability.cs" %}

```csharp
public interface IAISpeechToTextCapability : IAICapability
{
    Task<ISpeechToTextClient> CreateSpeechToTextClientAsync(
        object settings,
        AIProfile profile,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

{% code title="IAIDecisionCapability.cs" %}

```csharp
[Experimental("UMBRACOAI_DECISION")]
public interface IAIDecisionCapability : IAICapability
{
    Task<IAIDecisionClient> CreateClientAsync(
        object? settings = null,
        string? modelId = null,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Related

- [Providers](providers.md) - Implement capabilities
- [Profiles](profiles.md) - Configure capability-specific settings
- [Chat API](../using-the-api/chat/README.md) - Use the Chat capability
- [Embeddings API](../using-the-api/embeddings/README.md) - Use the Embedding capability
- [Speech-to-Text API](../using-the-api/speech-to-text.md) - Use the Speech-to-Text capability
- [Decision API](../using-the-api/decision/README.md) - Use the Decision capability (experimental)

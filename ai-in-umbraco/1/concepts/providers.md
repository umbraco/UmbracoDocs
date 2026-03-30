---
description: >-
    Providers are installable plugins that connect Umbraco.AI to AI services.
---

# Providers

A provider is a NuGet package that enables Umbraco.AI to communicate with a specific AI service. Providers handle the details of API authentication, request formatting, and response parsing.

## How Providers Work

Providers are discovered automatically when you install their NuGet package. They register themselves using the `[AIProvider]` attribute and implement the `IAIProvider` interface.

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                                 Umbraco.AI                                      │
│    ┌─────────────────────────────────────────────────────────────────────────┐  │
│    │                          Provider Registry                              │  │
│    │  ┌──────────┐ ┌───────────┐ ┌──────────┐ ┌─────────┐ ┌───────────────┐  │  │
│    │  │  OpenAI  │ │ Anthropic │ │ Google   │ │ Amazon  │ │ MS AI Foundry │  │  │
│    │  │ Provider │ │  Provider │ │ Provider │ │ Bedrock │ │   Provider    │  │  │
│    │  └──────────┘ └───────────┘ └──────────┘ └─────────┘ └───────────────┘  │  │
│    └─────────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────────┘
```

## Available Providers

| Provider             | Package                       | Capabilities    |
| -------------------- | ----------------------------- | --------------- |
| OpenAI               | `Umbraco.AI.OpenAI`           | Chat, Embedding |
| Anthropic            | `Umbraco.AI.Anthropic`        | Chat            |
| Google Gemini        | `Umbraco.AI.Google`           | Chat            |
| Amazon Bedrock       | `Umbraco.AI.Amazon`           | Chat, Embedding |
| Microsoft AI Foundry | `Umbraco.AI.MicrosoftFoundry` | Chat, Embedding |

{% hint style="info" %}
For detailed configuration instructions for each provider, see the [Providers](../providers/README.md) section. You can also create custom providers.
{% endhint %}

## Provider Discovery

Providers are discovered at application startup through assembly scanning. Any class with the `[AIProvider]` attribute that implements `IAIProvider` is automatically registered.

{% code title="OpenAIProvider.cs" %}

```csharp
[AIProvider("openai", "OpenAI")]
public class OpenAIProvider : AIProviderBase<OpenAIProviderSettings>
{
    public OpenAIProvider(IAIProviderInfrastructure infrastructure)
        : base(infrastructure)
    {
        WithCapability<OpenAIChatCapability>();
        WithCapability<OpenAIEmbeddingCapability>();
    }
}
```

{% endcode %}

## Provider Settings

Each provider defines its own settings class. Common settings include:

| Setting      | Description                             |
| ------------ | --------------------------------------- |
| API Key      | Authentication credential               |
| Endpoint     | API URL (for custom endpoints)          |
| Organization | Organization identifier (if applicable) |

Settings are defined using the `[AISetting]` attribute:

{% code title="OpenAIProviderSettings.cs" %}

```csharp
public class OpenAIProviderSettings
{
    [AISetting(Label = "API Key", Description = "Your OpenAI API key")]
    public required string ApiKey { get; set; }

    [AISetting(Label = "Organization", Description = "Optional organization ID")]
    public string? Organization { get; set; }
}
```

{% endcode %}

## Provider Capabilities

A provider can support multiple capabilities:

- **Chat** - Conversational AI and text generation
- **Embedding** - Vector embeddings for semantic search
- **Media** - Image generation (future)
- **Moderation** - Content safety checks (future)

Each capability is implemented as a separate class and registered in the provider constructor.

## Accessing Providers in Code

You rarely need to interact with providers directly. The service layer handles provider resolution based on the profile's connection.

If you need to access provider information:

{% code title="Example.cs" %}

```csharp
public class ProviderInfo
{
    private readonly IAIRegistry _registry;

    public ProviderInfo(IAIRegistry registry)
    {
        _registry = registry;
    }

    public IEnumerable<string> GetAvailableProviders()
    {
        return _registry.GetProviders().Select(p => p.Name);
    }
}
```

{% endcode %}

## Creating Custom Providers

You can create providers for AI services not yet supported. See:

{% content-ref url="../extending/providers/README.md" %}
[Custom Providers](../extending/providers/README.md)
{% endcontent-ref %}

## Related

- [Connections](connections.md) - Store credentials for a provider
- [Capabilities](capabilities.md) - The operations a provider supports

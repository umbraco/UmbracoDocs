---
description: >-
    Implement the speech-to-text capability for your custom provider.
---

# Speech-to-Text Capability

The speech-to-text capability enables audio transcription. Implement it by extending `AISpeechToTextCapabilityBase<TSettings>`.

## Base Class

{% code title="AISpeechToTextCapabilityBase<TSettings>" %}

```csharp
public abstract class AISpeechToTextCapabilityBase<TSettings>(IAIProvider provider)
    : AICapabilityBase<TSettings>(provider), IAICapability<TSettings>, IAISpeechToTextCapability
    where TSettings : class
{
    // Override this (or CreateClientAsync) to create an ISpeechToTextClient
    protected virtual ISpeechToTextClient CreateClient(TSettings settings, string? modelId) { /* ... */ }

    // Override this for an async variant
    protected virtual Task<ISpeechToTextClient> CreateClientAsync(
        TSettings settings, string? modelId, CancellationToken cancellationToken = default) { /* ... */ }

    // Implement this: Return available models
    protected abstract Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        TSettings settings,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

{% hint style="info" %}
`ISpeechToTextClient` is marked as `[Experimental("MEAI001")]` in Microsoft.Extensions.AI. Add `#pragma warning disable MEAI001` to your implementation files.
{% endhint %}

## Basic Implementation

{% code title="MySpeechToTextCapability.cs" %}

```csharp
#pragma warning disable MEAI001

using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Models;
using Umbraco.AI.Core.Providers;

public class MySpeechToTextCapability : AISpeechToTextCapabilityBase<MyProviderSettings>
{
    public MySpeechToTextCapability(IAIProvider provider) : base(provider) { }

    protected override ISpeechToTextClient CreateClient(MyProviderSettings settings, string? modelId)
    {
        return new MySpeechToTextClient(settings, modelId ?? "default-stt-model");
    }

    protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        MyProviderSettings settings,
        CancellationToken cancellationToken = default)
    {
        var models = new List<AIModelDescriptor>
        {
            new(new AIModelRef(Provider.Id, "stt-standard"), "Standard Transcription"),
            new(new AIModelRef(Provider.Id, "stt-enhanced"), "Enhanced Transcription")
        };
        return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(models);
    }
}
```

{% endcode %}

## Register in Provider

Add the speech-to-text capability in your provider constructor:

{% code title="MyProvider.cs" %}

```csharp
[AIProvider("myprovider", "My AI Provider")]
public class MyProvider : AIProviderBase<MyProviderSettings>
{
    public MyProvider(IAIProviderInfrastructure infrastructure)
        : base(infrastructure)
    {
        WithCapability<MyChatCapability>();
        WithCapability<MyEmbeddingCapability>();
        WithCapability<MySpeechToTextCapability>();  // Add speech-to-text support
    }
}
```

{% endcode %}

## Using Existing `Microsoft.Extensions.AI` Clients

If your AI service has an existing `Microsoft.Extensions.AI` speech-to-text client, use it directly. For example, with OpenAI:

{% code title="Using OpenAI Client" %}

```csharp
#pragma warning disable MEAI001

using Microsoft.Extensions.AI;
using OpenAI;

public class MyOpenAICompatibleSTTCapability : AISpeechToTextCapabilityBase<MyProviderSettings>
{
    public MyOpenAICompatibleSTTCapability(IAIProvider provider) : base(provider) { }

    protected override ISpeechToTextClient CreateClient(MyProviderSettings settings, string? modelId)
    {
        var client = new OpenAIClient(new ApiKeyCredential(settings.ApiKey));
        return client.GetAudioClient(modelId ?? "whisper-1").AsISpeechToTextClient();
    }

    protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        MyProviderSettings settings,
        CancellationToken cancellationToken = default)
    {
        return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(new List<AIModelDescriptor>
        {
            new(new AIModelRef(Provider.Id, "whisper-1"), "Whisper"),
            new(new AIModelRef(Provider.Id, "gpt-4o-transcribe"), "GPT-4o Transcribe"),
            new(new AIModelRef(Provider.Id, "gpt-4o-mini-transcribe"), "GPT-4o Mini Transcribe")
        });
    }
}
```

{% endcode %}

## Related

- [Creating a Provider](creating-a-provider.md) - Provider setup
- [Chat Capability](chat-capability.md) - Chat capability implementation
- [Embedding Capability](embedding-capability.md) - Embedding capability implementation
- [Speech-to-Text API](../../using-the-api/speech-to-text.md) - Using the Speech-to-Text API

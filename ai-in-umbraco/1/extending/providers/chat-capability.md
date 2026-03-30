---
description: >-
    Implement the chat capability for your custom provider.
---

# Chat Capability

The chat capability enables conversational AI features. Implement it by extending `AIChatCapabilityBase<TSettings>`.

## Base Class

{% code title="AIChatCapabilityBase<TSettings>" %}

```csharp
public abstract class AIChatCapabilityBase<TSettings> : IAIChatCapability
    where TSettings : class
{
    // Implement this: Create an IChatClient
    protected abstract IChatClient CreateClient(TSettings settings, string? modelId);

    // Implement this: Return available models
    protected abstract Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        TSettings settings,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Basic Implementation

{% code title="MyChatCapability.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Models;
using Umbraco.AI.Core.Providers;

public class MyChatCapability : AIChatCapabilityBase<MyProviderSettings>
{
    public MyChatCapability(IAIProvider provider) : base(provider) { }

    protected override IChatClient CreateClient(MyProviderSettings settings, string? modelId)
    {
        return new MyChatClient(settings, modelId ?? "default-model");
    }

    protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        MyProviderSettings settings,
        CancellationToken cancellationToken = default)
    {
        var models = new List<AIModelDescriptor>
        {
            new("model-v1", "Model Version 1"),
            new("model-v2", "Model Version 2")
        };
        return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(models);
    }
}
```

{% endcode %}

## Implementing IChatClient

The `IChatClient` interface from Microsoft.Extensions.AI:

{% code title="IChatClient Interface" %}

```csharp
public interface IChatClient : IDisposable
{
    ChatClientMetadata Metadata { get; }

    Task<ChatResponse> GetResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<ChatResponseUpdate> GetStreamingResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default);

    object? GetService(Type serviceType, object? serviceKey = null);
}
```

{% endcode %}

## Complete IChatClient Example

{% code title="MyChatClient.cs" %}

```csharp
using System.Runtime.CompilerServices;
using System.Text.Json;
using Microsoft.Extensions.AI;

public class MyChatClient : IChatClient
{
    private readonly HttpClient _httpClient;
    private readonly string _modelId;

    public MyChatClient(MyProviderSettings settings, string modelId)
    {
        _modelId = modelId;
        _httpClient = new HttpClient
        {
            BaseAddress = new Uri(settings.BaseUrl ?? "https://api.myprovider.com")
        };
        _httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {settings.ApiKey}");
    }

    public ChatClientMetadata Metadata => new(
        providerName: "MyProvider",
        providerUri: new Uri("https://myprovider.com"),
        modelId: _modelId);

    public async Task<ChatResponse> GetResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        var request = BuildRequest(messages, options, stream: false);

        var response = await _httpClient.PostAsJsonAsync(
            "/v1/chat/completions",
            request,
            cancellationToken);

        response.EnsureSuccessStatusCode();

        var result = await response.Content.ReadFromJsonAsync<ApiResponse>(
            cancellationToken: cancellationToken);

        return new ChatResponse(
            new ChatMessage(ChatRole.Assistant, result!.Choices[0].Message.Content))
        {
            ModelId = result.Model,
            FinishReason = MapFinishReason(result.Choices[0].FinishReason),
            Usage = new UsageDetails
            {
                InputTokenCount = result.Usage.PromptTokens,
                OutputTokenCount = result.Usage.CompletionTokens,
                TotalTokenCount = result.Usage.TotalTokens
            }
        };
    }

    public async IAsyncEnumerable<ChatResponseUpdate> GetStreamingResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        [EnumeratorCancellation] CancellationToken cancellationToken = default)
    {
        var request = BuildRequest(messages, options, stream: true);

        using var httpRequest = new HttpRequestMessage(HttpMethod.Post, "/v1/chat/completions")
        {
            Content = JsonContent.Create(request)
        };

        using var response = await _httpClient.SendAsync(
            httpRequest,
            HttpCompletionOption.ResponseHeadersRead,
            cancellationToken);

        response.EnsureSuccessStatusCode();

        await using var stream = await response.Content.ReadAsStreamAsync(cancellationToken);
        using var reader = new StreamReader(stream);

        while (!reader.EndOfStream)
        {
            var line = await reader.ReadLineAsync(cancellationToken);

            if (string.IsNullOrEmpty(line) || !line.StartsWith("data: "))
                continue;

            var data = line[6..];
            if (data == "[DONE]")
                yield break;

            var chunk = JsonSerializer.Deserialize<StreamChunk>(data);
            if (chunk?.Choices[0].Delta.Content is { } content)
            {
                yield return new ChatResponseUpdate
                {
                    Role = ChatRole.Assistant,
                    Text = content
                };
            }

            if (chunk?.Choices[0].FinishReason is { } reason)
            {
                yield return new ChatResponseUpdate
                {
                    FinishReason = MapFinishReason(reason)
                };
            }
        }
    }

    public object? GetService(Type serviceType, object? serviceKey = null) => null;

    public void Dispose() => _httpClient.Dispose();

    private object BuildRequest(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options,
        bool stream)
    {
        return new
        {
            model = _modelId,
            messages = messages.Select(m => new
            {
                role = m.Role.Value,
                content = m.Text
            }),
            temperature = options?.Temperature,
            max_tokens = options?.MaxOutputTokens,
            stream
        };
    }

    private static ChatFinishReason? MapFinishReason(string? reason) => reason switch
    {
        "stop" => ChatFinishReason.Stop,
        "length" => ChatFinishReason.Length,
        "content_filter" => ChatFinishReason.ContentFilter,
        _ => null
    };
}

// API response models
internal class ApiResponse
{
    public string Model { get; set; } = "";
    public List<Choice> Choices { get; set; } = new();
    public Usage Usage { get; set; } = new();
}

internal class Choice
{
    public MessageContent Message { get; set; } = new();
    public string? FinishReason { get; set; }
}

internal class MessageContent
{
    public string Content { get; set; } = "";
}

internal class Usage
{
    public int PromptTokens { get; set; }
    public int CompletionTokens { get; set; }
    public int TotalTokens { get; set; }
}

internal class StreamChunk
{
    public List<StreamChoice> Choices { get; set; } = new();
}

internal class StreamChoice
{
    public DeltaContent Delta { get; set; } = new();
    public string? FinishReason { get; set; }
}

internal class DeltaContent
{
    public string? Content { get; set; }
}
```

{% endcode %}

## Using Existing M.E.AI Clients

If your AI service already has a Microsoft.Extensions.AI (M.E.AI) client, use it directly:

{% code title="Using Existing Client" %}

```csharp
using Microsoft.Extensions.AI;
using OpenAI;

public class MyOpenAICompatibleCapability : AIChatCapabilityBase<MyProviderSettings>
{
    public MyOpenAICompatibleCapability(IAIProvider provider) : base(provider) { }

    protected override IChatClient CreateClient(MyProviderSettings settings, string? modelId)
    {
        // Use the OpenAI client with a custom endpoint
        var client = new OpenAIClient(new ApiKeyCredential(settings.ApiKey), new OpenAIClientOptions
        {
            Endpoint = new Uri(settings.BaseUrl!)
        });

        return client.AsChatClient(modelId ?? "gpt-4o");
    }

    protected override Task<IReadOnlyList<AIModelDescriptor>> GetModelsAsync(
        MyProviderSettings settings,
        CancellationToken cancellationToken = default)
    {
        // Return models available through your service
        return Task.FromResult<IReadOnlyList<AIModelDescriptor>>(new List<AIModelDescriptor>
        {
            new("gpt-4o", "GPT-4o"),
            new("gpt-4o-mini", "GPT-4o Mini")
        });
    }
}
```

{% endcode %}

## Handling ChatOptions

Profile settings and request options are merged into `ChatOptions`:

{% code title="Using ChatOptions" %}

```csharp
protected override IChatClient CreateClient(MyProviderSettings settings, string? modelId)
{
    // The client receives ChatOptions in GetResponseAsync
    // Profile settings (temperature, max tokens) are passed through options
    return new MyChatClient(settings, modelId);
}

// In your client:
public async Task<ChatResponse> GetResponseAsync(
    IEnumerable<ChatMessage> messages,
    ChatOptions? options = null,
    CancellationToken cancellationToken = default)
{
    var request = new
    {
        model = _modelId,
        messages = messages.Select(m => new { role = m.Role.Value, content = m.Text }),
        temperature = options?.Temperature,      // From profile or request
        max_tokens = options?.MaxOutputTokens,   // From profile or request
        stop = options?.StopSequences?.ToArray()
    };

    // Send request...
}
```

{% endcode %}

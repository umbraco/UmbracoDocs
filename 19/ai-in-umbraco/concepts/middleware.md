---
description: >-
    Middleware provides an extensible pipeline for adding cross-cutting concerns to AI requests.
---

# Middleware

Middleware wraps AI clients to add functionality like logging, caching, rate limiting, and custom behavior. Every request passes through the middleware pipeline before reaching the AI provider.

## How Middleware Works

Middleware uses the decorator pattern. Each middleware wraps the client and can:

- Modify requests before they're sent.
- Modify responses before they're returned.
- Add side effects (logging, metrics).
- Short-circuit requests (caching).

```mermaid
sequenceDiagram
    participant Request
    participant M1 as Middleware 1
    participant M2 as Middleware 2
    participant M3 as Middleware 3
    participant Provider
    Request->>M1: 
    M1->>M2: 
    M2->>M3: 
    M3->>Provider: 
    Provider-->>M3: 
    M3-->>M2: 
    M2-->>M1: 
    M1-->>Request: Response
```

## Middleware Types

### Chat Middleware

Wraps `IChatClient` instances:

{% code title="IAIChatMiddleware.cs" %}

```csharp
public interface IAIChatMiddleware
{
    IChatClient Apply(IChatClient client);
}
```

{% endcode %}

### Embedding Middleware

Wraps `IEmbeddingGenerator<string, Embedding<float>>` instances:

{% code title="IAIEmbeddingMiddleware.cs" %}

```csharp
public interface IAIEmbeddingMiddleware
{
    IEmbeddingGenerator<string, Embedding<float>> Apply(
        IEmbeddingGenerator<string, Embedding<float>> generator);
}
```

{% endcode %}

## Example: Logging Middleware

{% code title="LoggingChatMiddleware.cs" %}

```csharp
public class LoggingChatMiddleware : IAIChatMiddleware
{
    private readonly ILogger<LoggingChatMiddleware> _logger;

    public LoggingChatMiddleware(ILogger<LoggingChatMiddleware> logger)
    {
        _logger = logger;
    }

    public IChatClient Apply(IChatClient client)
    {
        return new LoggingChatClient(client, _logger);
    }
}

public class LoggingChatClient : DelegatingChatClient
{
    private readonly ILogger _logger;

    public LoggingChatClient(IChatClient inner, ILogger logger)
        : base(inner)
    {
        _logger = logger;
    }

    public override async Task<ChatResponse> GetResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        _logger.LogInformation("Chat request started");

        var response = await base.GetResponseAsync(messages, options, cancellationToken);

        _logger.LogInformation("Chat request completed: {Tokens} tokens",
            response.Usage?.TotalTokenCount);

        return response;
    }
}
```

{% endcode %}

## Registering Middleware

Register middleware in a Composer using the collection builder:

{% code title="AIComposer.cs" %}

```csharp
using Umbraco.AI.Extensions;
using Umbraco.Cms.Core.Composing;

public class AIComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIChatMiddleware()
            .Append<LoggingChatMiddleware>();
    }
}
```

{% endcode %}

## Middleware Ordering

Middleware executes in the order it's registered. Use collection builder methods to control order:

{% code title="Example.cs" %}

```csharp
builder.AIChatMiddleware()
    .Append<LoggingMiddleware>()           // Added first
    .Append<CachingMiddleware>()           // Added second
    .InsertBefore<LoggingMiddleware, TracingMiddleware>()  // Before logging
    .InsertAfter<CachingMiddleware, MetricsMiddleware>();  // After caching
```

{% endcode %}

Resulting order:

1. TracingMiddleware
2. LoggingMiddleware
3. CachingMiddleware
4. MetricsMiddleware

## M.E.AI Built-in Middleware

Microsoft.Extensions.AI provides middleware you can use:

- `OpenTelemetryChatClient` - Distributed tracing
- `LoggingChatClient` - Structured logging
- `FunctionInvokingChatClient` - Tool/function calling

{% code title="Example.cs" %}

```csharp
public class OpenTelemetryMiddleware : IAIChatMiddleware
{
    public IChatClient Apply(IChatClient client)
    {
        return client.AsBuilder()
            .UseOpenTelemetry(_loggerFactory)
            .Build();
    }
}
```

{% endcode %}

## Creating Custom Middleware

See the extending guide for detailed instructions:

{% content-ref url="../extending/middleware/README.md" %}
[Middleware](../extending/middleware/README.md)
{% endcontent-ref %}

## Related

- [Chat API](../using-the-api/chat/README.md) - How middleware affects chat requests
- [Creating Chat Middleware](../extending/middleware/chat-middleware.md) - Build custom middleware

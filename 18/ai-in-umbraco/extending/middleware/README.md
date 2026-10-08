---
description: >-
    Add cross-cutting concerns to AI operations with middleware.
---

# Custom Middleware

Middleware lets you wrap AI client operations to add cross-cutting concerns like logging, caching, rate limiting, and telemetry. Middleware is applied to all AI requests without modifying application code.

## How Middleware Works

Middleware wraps the underlying AI client, intercepting requests and responses:

```mermaid
graph LR
    A[Your Code] --> M1["Middleware 1\nLogging"]
    M1 --> M2["Middleware 2\nCaching"]
    M2 --> C["AI Client\nProvider"]
    C --> D[AI Service]
```

Each middleware receives a client and returns a wrapped client with additional behavior.

## Middleware Types

| Type      | Interface                | Wraps                                           |
| --------- | ------------------------ | ----------------------------------------------- |
| Chat      | `IAIChatMiddleware`      | `IChatClient`                                   |
| Embedding | `IAIEmbeddingMiddleware` | `IEmbeddingGenerator<string, Embedding<float>>` |

## Quick Example

{% code title="LoggingMiddleware.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Microsoft.Extensions.Logging;
using Umbraco.AI.Core.Chat;

public class LoggingChatMiddleware : IAIChatMiddleware
{
    private readonly ILoggerFactory _loggerFactory;

    public LoggingChatMiddleware(ILoggerFactory loggerFactory)
    {
        _loggerFactory = loggerFactory;
    }

    public IChatClient Apply(IChatClient client)
    {
        return client.AsBuilder()
            .UseLogging(_loggerFactory)
            .Build();
    }
}
```

{% endcode %}

{% code title="MyComposer.cs" %}

```csharp
using Umbraco.AI.Extensions;
using Umbraco.Cms.Core.Composing;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIChatMiddleware()
            .Append<LoggingChatMiddleware>();
    }
}
```

{% endcode %}

## Key Concepts

### Middleware Order Matters

Middleware is applied to the client in registration order. The first registered middleware wraps the underlying client (innermost), the second wraps that, and so on. As a result, the **last** registered middleware is the **outermost** wrapper and sees requests first.

```csharp
builder.AIChatMiddleware()
    .Append<LoggingMiddleware>()     // Innermost (wraps raw client first)
    .Append<CachingMiddleware>()     // Wraps Logging
    .Append<TracingMiddleware>();    // Outermost (sees requests first)
```

### Middleware Receives Dependencies

Middleware classes support constructor injection:

```csharp
public class MyMiddleware : IAIChatMiddleware
{
    private readonly ILogger<MyMiddleware> _logger;
    private readonly IMyService _myService;

    public MyMiddleware(ILogger<MyMiddleware> logger, IMyService myService)
    {
        _logger = logger;
        _myService = myService;
    }

    public IChatClient Apply(IChatClient client)
    {
        // Use injected services
    }
}
```

### Using M.E.AI Middleware

Microsoft.Extensions.AI includes built-in middleware. Use the `AsBuilder()` extension to apply them:

```csharp
public IChatClient Apply(IChatClient client)
{
    return client.AsBuilder()
        .UseLogging(_loggerFactory)           // Built-in logging
        .UseOpenTelemetry(_loggerFactory)     // OpenTelemetry tracing
        .UseFunctionInvocation()              // Tool calling support
        .Build();
}
```

## In This Section

{% content-ref url="chat-middleware.md" %}
[Chat Middleware](chat-middleware.md)
{% endcontent-ref %}

{% content-ref url="embedding-middleware.md" %}
[Embedding Middleware](embedding-middleware.md)
{% endcontent-ref %}

{% content-ref url="middleware-ordering.md" %}
[Middleware Ordering](middleware-ordering.md)
{% endcontent-ref %}

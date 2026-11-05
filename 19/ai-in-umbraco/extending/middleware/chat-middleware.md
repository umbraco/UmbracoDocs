---
description: >-
    Create middleware to intercept and modify chat operations.
---

# Chat Middleware

Chat middleware wraps `IChatClient` instances to add behavior to chat completions. Implement `IAIChatMiddleware` to create custom middleware.

## Interface

{% code title="IAIChatMiddleware" %}

```csharp
public interface IAIChatMiddleware
{
    IChatClient Apply(IChatClient client);
}
```

{% endcode %}

The `Apply` method receives the current client and returns a wrapped client.

## Basic Implementation

{% code title="SimpleChatMiddleware.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Chat;

public class SimpleChatMiddleware : IAIChatMiddleware
{
    public IChatClient Apply(IChatClient client)
    {
        return new SimpleChatClientWrapper(client);
    }
}
```

{% endcode %}

## Creating a Custom Wrapper

To implement custom behavior, create a class that delegates to the inner client. The recommended approach is to derive from `DelegatingChatClient` (provided by `Microsoft.Extensions.AI`), which handles pass-through for any members you don't override:

{% code title="MetricsChatMiddleware.cs" %}

```csharp
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Microsoft.Extensions.AI;
using Microsoft.Extensions.Logging;
using Umbraco.AI.Core.Chat;

public class MetricsChatMiddleware : IAIChatMiddleware
{
    private readonly ILogger<MetricsChatMiddleware> _logger;

    public MetricsChatMiddleware(ILogger<MetricsChatMiddleware> logger)
    {
        _logger = logger;
    }

    public IChatClient Apply(IChatClient client)
    {
        return new MetricsChatClient(client, _logger);
    }
}

internal sealed class MetricsChatClient : DelegatingChatClient
{
    private readonly ILogger _logger;

    public MetricsChatClient(IChatClient innerClient, ILogger logger)
        : base(innerClient)
    {
        _logger = logger;
    }

    public override async Task<ChatResponse> GetResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default)
    {
        var stopwatch = Stopwatch.StartNew();

        try
        {
            var response = await base.GetResponseAsync(messages, options, cancellationToken);
            stopwatch.Stop();

            _logger.LogInformation(
                "Chat completed in {ElapsedMs}ms. Tokens: {Input}/{Output}",
                stopwatch.ElapsedMilliseconds,
                response.Usage?.InputTokenCount,
                response.Usage?.OutputTokenCount);

            return response;
        }
        catch (Exception ex)
        {
            stopwatch.Stop();
            _logger.LogError(ex, "Chat failed after {ElapsedMs}ms", stopwatch.ElapsedMilliseconds);
            throw;
        }
    }

    public override async IAsyncEnumerable<ChatResponseUpdate> GetStreamingResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        [EnumeratorCancellation] CancellationToken cancellationToken = default)
    {
        var stopwatch = Stopwatch.StartNew();
        var updateCount = 0;

        await foreach (var update in base.GetStreamingResponseAsync(messages, options, cancellationToken))
        {
            updateCount++;
            yield return update;
        }

        stopwatch.Stop();
        _logger.LogInformation(
            "Streaming completed in {ElapsedMs}ms. Updates: {Count}",
            stopwatch.ElapsedMilliseconds,
            updateCount);
    }
}
```

{% endcode %}

## Using M.E.AI Built-in Middleware

Microsoft.Extensions.AI (M.E.AI) provides built-in middleware options. Use the builder pattern:

{% code title="Using Built-in Middleware" %}

```csharp
using Microsoft.Extensions.AI;
using Microsoft.Extensions.Logging;

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

### Available M.E.AI Middleware

| Method                    | Purpose                      |
| ------------------------- | ---------------------------- |
| `UseLogging()`            | Log requests and responses   |
| `UseOpenTelemetry()`      | Add OpenTelemetry tracing    |
| `UseFunctionInvocation()` | Enable tool/function calling |
| `UseDistributedCache()`   | Cache responses              |

## Registering Chat Middleware

Register middleware in a Composer:

{% code title="MyComposer.cs" %}

```csharp
using Umbraco.AI.Extensions;
using Umbraco.Cms.Core.Composing;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIChatMiddleware()
            .Append<MetricsChatMiddleware>();
    }
}
```

{% endcode %}


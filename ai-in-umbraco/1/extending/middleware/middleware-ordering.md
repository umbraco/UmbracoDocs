---
description: >-
    Control the execution order of middleware in the pipeline.
---

# Middleware Ordering

Middleware execution order is controlled through the collection builder. The order determines which middleware runs first and how they wrap each other.

## Understanding Order

Middleware is applied in registration order, creating nested wrappers:

```
Registration order: A, B, C

Result: A wraps (B wraps (C wraps Client))

Execution flow:
  Request  → A → B → C → Client → Response
  Response ← A ← B ← C ← Client ←
```

The **first** registered middleware is the **outermost** wrapper and sees requests first.

## Builder Methods

The collection builder provides methods to control ordering:

| Method                       | Description                         |
| ---------------------------- | ----------------------------------- |
| `Append<T>()`                | Add middleware at the end           |
| `InsertBefore<TBefore, T>()` | Insert before a specific middleware |
| `InsertAfter<TAfter, T>()`   | Insert after a specific middleware  |
| `Remove<T>()`                | Remove a middleware                 |

## Basic Ordering

{% code title="MyComposer.cs" %}

```csharp
using Umbraco.AI.Extensions;
using Umbraco.Cms.Core.Composing;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIChatMiddleware()
            .Append<TracingMiddleware>()      // Runs first
            .Append<LoggingMiddleware>()      // Runs second
            .Append<CachingMiddleware>();     // Runs third
    }
}
```

{% endcode %}

## Inserting Relative to Others

When extending existing middleware pipelines:

{% code title="Inserting Middleware" %}

```csharp
public class ExtendingComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Insert metrics before logging (so metrics include logging time)
        builder.AIChatMiddleware()
            .InsertBefore<LoggingMiddleware, MetricsMiddleware>();

        // Insert rate limiting after authentication
        builder.AIChatMiddleware()
            .InsertAfter<AuthMiddleware, RateLimitMiddleware>();
    }
}
```

{% endcode %}

## Removing Middleware

Remove middleware added by other composers:

{% code title="Removing Middleware" %}

```csharp
public class CustomComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIChatMiddleware()
            .Remove<DefaultLoggingMiddleware>()
            .Append<MyCustomLoggingMiddleware>();
    }
}
```

{% endcode %}

## Embedding Middleware Ordering

The same methods work for embedding middleware:

{% code title="Embedding Ordering" %}

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIEmbeddingMiddleware()
            .Append<MetricsEmbeddingMiddleware>()
            .Append<CachingEmbeddingMiddleware>()
            .Append<NormalizationEmbeddingMiddleware>();
    }
}
```

{% endcode %}

## Common Patterns

### Logging Should Be Outer

Put logging middleware early so it captures the full request lifecycle:

```csharp
builder.AIChatMiddleware()
    .Append<LoggingMiddleware>()       // First - logs everything
    .Append<RetryMiddleware>()         // Second - logging sees retries
    .Append<CachingMiddleware>();      // Third - logging sees cache hits
```

### Caching Should Be Inner

Put caching close to the client so cached responses skip other middleware:

```csharp
builder.AIChatMiddleware()
    .Append<MetricsMiddleware>()       // First - tracks all requests
    .Append<RateLimitMiddleware>()     // Second - applies rate limiting
    .Append<CachingMiddleware>();      // Third - cache hits skip rate limiting
```

### Error Handling Should Be Outer

Put error handling early to catch exceptions from all middleware:

```csharp
builder.AIChatMiddleware()
    .Append<ErrorHandlingMiddleware>() // First - catches all errors
    .Append<LoggingMiddleware>()       // Second
    .Append<BusinessLogicMiddleware>();// Third
```

## Multiple Composers

When multiple composers add middleware, they combine in composer execution order:

{% code title="ComposerA.cs" %}

```csharp
[ComposeAfter(typeof(UmbracoAIComposer))]
public class ComposerA : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIChatMiddleware()
            .Append<MiddlewareA>();
    }
}
```

{% endcode %}

{% code title="ComposerB.cs" %}

```csharp
[ComposeAfter(typeof(ComposerA))]
public class ComposerB : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AIChatMiddleware()
            .Append<MiddlewareB>()
            .InsertBefore<MiddlewareA, MiddlewareC>(); // Insert before A
    }
}
```

{% endcode %}

Use `[ComposeBefore]` and `[ComposeAfter]` attributes to control composer order.

## Debugging Order

To inspect the current middleware order:

{% code title="Debugging" %}

```csharp
public class DebugComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // After building, the collection contains middleware in order
        // You can log or inspect during development
    }
}
```

{% endcode %}

{% hint style="info" %}
Middleware order is set at application startup and cannot change at runtime.
{% endhint %}

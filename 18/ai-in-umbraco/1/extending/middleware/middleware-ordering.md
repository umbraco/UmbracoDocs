---
description: >-
    Control the execution order of middleware in the pipeline.
---

# Middleware Ordering

Middleware execution order is controlled through the collection builder. The order determines which middleware runs first and how they wrap each other.

## Understanding Order

Middleware is applied in registration order, creating nested wrappers. Each middleware's `Apply` method is called on the current client, so the first registered middleware wraps the underlying client, and the last registered middleware wraps everything else:

```
Registration order: A, B, C

Result: C wraps (B wraps (A wraps Client))

Execution flow:
  Request  → C → B → A → Client → Response
  Response ← C ← B ← A ← Client ←
```

The **last** registered middleware is the **outermost** wrapper and sees requests first.

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
            .Append<LoggingMiddleware>()      // Innermost (wraps client first)
            .Append<CachingMiddleware>()      // Wraps Logging
            .Append<TracingMiddleware>();     // Outermost (sees requests first)
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
        // Insert metrics just inside logging (so metrics see the call after logging)
        builder.AIChatMiddleware()
            .InsertBefore<LoggingMiddleware, MetricsMiddleware>();

        // Insert rate limiting just outside authentication
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

As a rule of thumb, place logging and error handling middleware last (outermost) so they capture the full request lifecycle, and place caching middleware first (innermost) so cached responses skip other middleware.

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

{% hint style="info" %}
Middleware order is set at application startup and cannot change at runtime.
{% endhint %}

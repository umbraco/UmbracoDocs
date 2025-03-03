---
description: Learn how to configure Umbraco UI Builder in your project using two different approaches.
---

# Configuration

You can configure Umbraco UI Builder either via a Composer or the `AddUIBuilder` extension method in `Program.cs`.

## Option 1: Configuring via a Composer

A Composer is a common approach for registering and configuring services in Umbraco during application startup.

To configure Umbraco UI Builder via a Composer:

1. Create a file called `UIBuilderComposer.cs` in your project.
2. Implement the `IComposer` interface and add the configuration inside the `Compose` method:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.UIBuilder.Extensions;

public class UIBuilderComposer : IComposer
{
   public void Compose(IUmbracoBuilder builder)
    {
       builder.AddUIBuilder(cfg =>
        {
           // Apply your configuration here
        });
    }
}
```

## Option 2: Configuring via `Program.cs`

You can also configure Umbraco UI Builder directly in `Program.cs` using the `AddUIBuilder` extension method.

To configure Umbraco UI Builder:

1. Open the `Program.cs` file in your project.
2. Locate the `CreateUmbracoBuilder()` method.
3. Add `AddUIBuilder` before `AddComposers()`.

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddUIBuilder(cfg => {
       // Apply your configuration here
    })
    .AddDeliveryApi()
    .AddComposers()
    .Build();
```

## Example Configuration

For a complete sample configuration, see the [Creating your First Integration](../guides/creating-your-first-integration.md) article.

The `AddUIBuilder` method accepts a delegate function, allowing you to configure your solution using fluent APIs.

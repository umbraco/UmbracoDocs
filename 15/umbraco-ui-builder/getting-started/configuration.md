---
description: Learn how to configure Umbraco UI Builder using the extension method.
---

# Configuration

You can configure Umbraco UI Builder using the `AddUIBuilder` extension method in `Program.cs`.

## Using `AddUIBuilder`

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

{% hint style="info" %}
If you want an example configuration, see the **Configure Umbraco UI Builder** section in the [Creating your First Integration](../guides/creating-your-first-integration.md) article.
{% endhint %}

The `AddUIBuilder` method accepts a delegate function, allowing you to configure your solution using fluent APIs.

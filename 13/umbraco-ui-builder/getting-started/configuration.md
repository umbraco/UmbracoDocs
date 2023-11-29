---
description: Configuring Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Configuration

Umbraco UI Builder can be configured directly via the `AddUIBuilder` extension method on `IUmbracoBuilder`.

## AddUIBuilder

To configure Umbraco UI Builder via the `AddUIBuilder` extension method, You can look in the `Program.cs` file in the root of your web project. From within this file, before the call to `AddComposers()` we can add our `AddUIBuilder` configuration.

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

The `AddUIBuilder` extension method accepts a single parameter, a delegate function with one of the Umbraco UI Builder configuration builder arguments. With this, you can then call the relevant fluent APIs to define your solution.

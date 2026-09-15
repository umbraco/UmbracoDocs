---
description: Configuring Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Configuration

Umbraco UI Builder can be configured directly via the `AddUIBuilder` extension method on `IUmbracoBuilder`.

## AddUIBuilder

To configure Umbraco UI Builder via the `AddUIBuilder` extension method, you can look at the `Program.cs` file at the root of your web project. From within this file, before the call to `AddComposers()` you can add the `AddUIBuilder` configuration.

Alternatively, if your project is upgraded from earlier versions, you can add the configuration to the `Startup.cs` file.

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

The `AddUIBuilder` extension method accepts a single parameter, a delegate function with one of the Umbraco UI Builder configuration builder arguments. With this, you can call the relevant fluent APIs to define your solution.

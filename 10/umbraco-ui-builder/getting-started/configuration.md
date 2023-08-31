---
description: Configuring Umbraco UI Builder, the backoffice UI builder for Umbraco.
---

# Configuration

Umbraco UI Builder can be configured in two ways. Either directly via the `AddKonstrukt` extension method on `IUmbracoBuilder`, or via an `IKonstruktConfigurator` component registered with the DI container.

## AddKonstrukt

To configure Umbraco UI Builder via the `AddKonstrukt` extension method, you can extend the `ConfigureServices` method found in the `Startup.cs` file in the root of your web project. From within this method, before the call to `AddComposers()` we can add our `AddKonstrukt` configuration.

```csharp
public class Startup
{
    ...
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddUmbraco(_env, _config)
            .AddBackOffice()
            .AddWebsite()
            .AddKonstrukt(cfg => {
                // Apply your configuration here
            })
            .AddComposers()
            .Build();
    }
    ...
}

```

The `AddKonstrukt` extension method accepts a single parameter, a delegate function with one of the Umbraco UI Builder configuration builder arguments. With this, you can then call the relevant fluent APIs to define your solution.

## IKonstruktConfigurator

To configure Umbraco UI Builder via a `IKonstruktConfigurator` you can create a class anywhere in your project that inherits from the `IKonstruktConfigurator` interface. Then Umbraco UI Builder will automatically find them and register their configurations with the DI container.

```csharp
public class MyKonstruktConfigurator : IKonstruktConfigurator
{
    public void Configure(KonstruktConfigBuilder builder)
    {
        // Apply your configuration here
    }
}
```

The `IKonstruktConfigurator` has a single `Configure` method with a single Umbraco UI Builder configuration builder argument. With this, you can then call the relevant fluent APIs to define your solution.

---
description: Learn more about the different options for configured Vendr.
---

# Vendr Builder

When it comes to configuring and extending Vendr, such as by registering your own event handlers, we achieve this with the `IVendrBuilder` interface that can be accessed via a delegate function passed into the `AddVendr()` extension method called on the `IUmbracoBuilder` interface when explicitly registering Vendr.

```csharp
public class Startup
{
    ...
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddUmbraco(_env, _config)
            .AddBackOffice()
            .AddWebsite()
            .AddVendr(vendrBuilder => {
                // Configure Vendr here
            })
            .AddComposers()
            .Build();
    }
    ...
}

```

## Registering Dependencies

The `IVendrBuilder` interface gives you access to the current `IServiceCollection` and `IConfiguration` to allow you to register dependencies like you would with the [`IUmbracoBuilder` interface](dependency-injection.md#registering-dependencies) but its primary use case would be to access Vendr's own collection builders, such as for registering validation or notification events, and any other Vendr-specific configuration APIs.

```csharp
...
.AddVendr(vendrBuilder => {
    
    // Register validation events
    vendrBuilder.WithValidationEvent<ValidateOrderProductAdd>()
            .RegisterHandler<MyOrderProductAddValidationHandler>();

})
...
```

As per the [Dependency Injection docs](dependency-injection.md), whilst you can register your dependencies directly within this configuration delegate, you may prefer to group your dependencies registration code into an extension method.

```csharp
public static class VendrBuilderExtensions
{
    public static IVendrBuilder AddMyDependencies(this IVendrBuilder builder)
    {
        // Register my dependencies here via the builder parameter
        ...

        // Return the builder to continue the chain
        return builder;
    }
}
```

```csharp
...
.AddVendr(vendrBuilder => {
    
    vendrBuilder.AddMyDependencies();

})
...
```

---
description: Learn more about the different options for configured Umbraco Commerce.
---

# Umbraco Commerce Builder

When it comes to configuring and extending Umbraco Commerce, such as by registering your own event handlers, we achieve this with the `IUmbracoCommerceBuilder` interface that can be accessed via a delegate function passed into the `AddUmbracoCommerce()` extension method called on the `IUmbracoBuilder` interface when explicitly registering Umbraco Commerce.

```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddUmbracoCommerce(umbracoCommerceBuilder => {
    // Configure Umbraco Commerce here
    })
    .AddDeliveryApi()
    .AddComposers()
    .Build();

```

## Registering Dependencies

The `IUmbracoCommerceBuilder` interface gives you access to the current `IServiceCollection` and `IConfiguration` to allow you to register dependencies like you would with the [`IUmbracoBuilder` interface](dependency-injection.md#registering-dependencies) but its primary use case would be to access Umbraco Commerce's own collection builders, such as for registering validation or notification events, and any other Umbraco Commerce-specific configuration APIs.

```csharp
...
.AddUmbracoCommerce(umbracoCommerceBuilder => {

    // Register validation events
    umbracoCommerceBuilder.WithValidationEvent<ValidateOrderProductAdd>()
            .RegisterHandler<MyOrderProductAddValidationHandler>();

})
...
```

As per the [Dependency Injection docs](dependency-injection.md), whilst you can register your dependencies directly within this configuration delegate, you may prefer to group your dependencies registration code into an extension method.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyDependencies(this IUmbracoCommerceBuilder builder)
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
.AddUmbracoCommerce(umbracoCommerceBuilder => {

    umbracoCommerceBuilder.AddMyDependencies();

})
...
```

{% hint style="info" %}
If using a composer to register `IUmbracoCommerceBuilder` extensions and their dependencies, the composer needs to run before `UmbracoCommerceComposer` otherwise it will use the default configuration.
{% endhint %}

```csharp
public static class StoreBuilderExtensions
{
	public static IUmbracoBuilder AddMyStore(this IUmbracoBuilder umbracoBuilder)
	{
		umbracoBuilder.AddUmbracoCommerce(v =>
		{
			...
		});

		return umbracoBuilder;
	}
}
```

```csharp
[ComposeBefore(typeof(UmbracoCommerceComposer))]
public class StoreComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.AddMyStore();
    }
}
```

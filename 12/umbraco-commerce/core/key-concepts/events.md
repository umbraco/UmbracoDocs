---
description: Listening for changes within Umbraco Commerce.
---

# Events

Much like the standard events in .NET, Umbraco Commerce has an events system to notify you when certain things happen within the application. However, Umbraco Commerce differs slightly in the types of events that are fired and how you register your event handlers.

Events in Umbraco Commerce are registered via the [`IUmbracoCommerceBuilder`](umbraco-commerce-builder.md) interface, rather than via static event delegates. This has a number of advantages, such as being able to control the order of when event handlers are fired. It also allows us to inject dependencies into the event handlers making it a much more decoupled approach to eventing.

In Umbraco Commerce, there are two main types of events you can create handlers for. Both are explained in detail below.

## Validation events

Validation events are events that fire immediately before a change is about to be made to an entity. These events allow you to inject your own logic to decide whether an action should be possible or not. We already have a number of validation handlers built in to maintain the consistency of your data. Validation events allow you to extend this behavior with your own rules.

### Example: Validation event handler

An example of a Validation event handler would look something like this:

```csharp
public class MyOrderProductAddValidationHandler : ValidationEventHandlerBase<ValidateOrderProductAdd>
{
    public override void Validate(ValidateOrderProductAdd evt)
    {
        if (evt.ProductReference == "MyProductRef" && evt.Quantity % 10 != 0)
            evt.Fail("This product can only be purchased in increments of 10");
    }
}

```

All Validation event handlers inherit from a base class `ValidationEventHandlerBase<TEvent>` where `TEvent` is the Type of the event the handler is for. They then have a `Validate` method that accepts an instance of the event type, and inside which you can perform your custom logic. If the event fails the validation logic, you can call `evt.Fail("Your message here")` to block the related action from happening and have a `ValidationException` be thrown. This can then be captured in the front end to display a friendly error message.

### Registering a Validation event handler

Validation event handlers are [registered via the IUmbracoCommerceBuilder](umbraco-commerce-builder.md) interface using the `WithValidationEvent<TEvent>()` builder extension method. This is done to identify the event you want to handle and then call the `RegisterHandler<THandler>()` method to register your handler(s) for that event.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyEventHandlers(IUmbracoCommerceBuilder builder)
    {
        // Register my event handlers
        builder.WithValidationEvent<ValidateOrderProductAdd>()
            .RegisterHandler<MyOrderProductAddValidationHandler>();

        // Return the builder to continue the chain
        return builder;
    }
}
```

You can control the order of when Validation event handlers run, before or after another Validation event handler. This is done by registering them via the `RegisterHandlerBefore<THandler>()` or `RegisterHandlerAfter<THandler>()` methods respectively.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyEventHandlers(IUmbracoCommerceBuilder builder)
    {
        // Register MyOrderProductAddValidationHandler to execute before the SomeOtherValidationHandler handler
        builder.WithValidationEvent<ValidateOrderProductAdd>()
            .RegisterHandlerBefore<SomeOtherValidationHandler, MyOrderProductAddValidationHandler>();

        // Register MyOrderProductAddValidationHandler to execute after the SomeOtherValidationHandler handler
        builder.WithValidationEvent<ValidateOrderProductAdd>()
            .RegisterHandlerAfter<SomeOtherValidationHandler, MyOrderProductAddValidationHandler>();

        // Return the builder to continue the chain
        return builder;
    }
}
```

## Notification events

Notification events are events that fire, often immediately before or after an action is executed. It provides you the ability to run custom logic to react to that action occurring. This is useful for scenarios such as sending emails when an Order is finalized or allowing you to synchronize stock updates with an external system.

Notification events won't allow you to change the behavior of how Umbraco Commerce runs. They provide you with an effective means of reacting when changes occur.

### Example: Notification event handler

An example of a Notification event handler would look something like this:

```csharp
public class MyOrderFinalizedHandler : NotificationEventHandlerBase<OrderFinalizedNotification>
{
    public override void Handle(OrderFinalizedNotification evt)
    {
        // Implement your custom logic here
    }
}

```

All Notification event handlers inherit from a base class `NotificationEventHandlerBase<TEvent>` where `TEvent` is the Type of the event the handler is for. They then have a `Handle` method that accepts an instance of the event type, and inside which you can perform your custom logic.

### Registering a Notification event handler

Notification event handlers are [registered via the IUmbracoCommerceBuilder](umbraco-commerce-builder.md) interface using the `WithNotificationEvent<TEvent>()` builder extension method. This is used to identify the event you want to handle and then call the `RegisterHandler<THandler>()` method to register your handler(s) for that event.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyEventHandlers(IUmbracoCommerceBuilder builder)
    {
        // Register my event handlers
        builder.WithNotificationEvent<OrderFinalizedNotification>()
            .RegisterHandler<MyOrderFinalizedHandler>();

        // Return the builder to continue the chain
        return builder;
    }
}
```

You can also control the order of when Notification event handlers run by registering them via the `RegisterHandlerBefore<THandler>()` or `RegisterHandlerAfter<THandler>()` methods respectively.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddMyEventHandlers(IUmbracoCommerceBuilder builder)
    {
        // Register MyOrderFinalizedHandler to execute before the SomeOtherNotificationHandler handler
        builder.WithNotificationEvent<OrderFinalizedNotification>()
            .RegisterHandlerBefore<SomeOtherNotificationHandler, MyOrderFinalizedHandler>();

        // Register MyOrderFinalizedHandler to execute after the SomeOtherNotificationHandler handler
        builder.WithNotificationEvent<OrderFinalizedNotification>()
            .RegisterHandlerAfter<SomeOtherNotificationHandler, MyOrderFinalizedHandler>();

        // Return the builder to continue the chain
        return builder;
    }
}
```

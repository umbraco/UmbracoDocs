---
versionFrom: 8.0.0
meta.Title: "Handling application startup events in Umbraco"
meta.Description: "How to handle application startup events in Umbraco"
meta.RedirectLink: "/umbraco-cms/reference/notifications/umbracoapplicationlifetime-notifications"
---

# Application startup

The `ApplicationEventHandler` approach for registering events has been removed in Umbraco 8.

The new approach for registering custom code at the `ApplicationStarting` and `ApplicationStarted` events uses a combination of 'Composers' and 'Components'. You can find a basic example below and more detailed ones on the [Composing](../../Implementation/Composing) page.

Core developer Stephan also has a series of blog posts about the changes:

- [Composing Umbraco v8](https://www.zpqrtbnk.net/posts/composing-umbraco-v8/)
- [Composing Umbraco v8 Collections](https://www.zpqrtbnk.net/posts/composing-umbraco-v8-collections/)
- [Composing Umbraco v8 Components](https://www.zpqrtbnk.net/posts/composing-umbraco-v8-components/)

## Example - Getting started

The following code uses a `ComponentComposer<T>` to add the `ApplicationComponent`. You can override the `Compose()` method if you want to compose more than only adding the component. Make sure to keep the call to the base method, as the component isn't added otherwise.

```csharp
public class ApplicationComposer : ComponentComposer<ApplicationComponent>, IUserComposer
{
    public override void Compose(Composition composition)
    {
        // ApplicationStarting event in V7: add IContentFinders, register custom services and more here

        base.Compose(composition);
    }
}

public class ApplicationComponent : IComponent
{
    public void Initialize()
    {
        // ApplicationStarted event in V7: add your events here
    }

    public void Terminate()
    { }
}
```

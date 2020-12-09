---
versionFrom: 8.0.0
---

# Controller & Action selection

_Once the published content request has been created, and MVC is the selected rendering engine, it's time to execute an MVC Controller's Action._

## Defaults

By default, Umbraco will execute every request via its built in default controller: `Umbraco.Web.Mvc.RenderMvcController`.
The MVC Action that executes by default for every request is the `Index` action on the `RenderMvcController`.

## Changing the default

It is possible to use a custom Controller and Action to be executed during the Umbraco request pipeline.
A default Controller can be set during composition by creating a c# class which implements `IUserComposer`, for example:

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Web;
using Umbraco.Web.Mvc;

namespace Umbraco8.Composers
{
    public class SetDefaultRenderMvcControllerComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.SetDefaultRenderMvcController<CustomMvcController>();
        }
    }
}
```

It is a requirement that your custom controller inherit from `Umbraco.Web.MVC.RenderMvcController`.
You can override the `Index` method to perform any customisations that you require.

## Custom controller selection

Custom controllers can be created to execute for different Umbraco Document Types and Templates. This is termed 'Hijacking Umbraco Routes'.
For full details on how this process works, see [Custom Controllers](../../../Reference/Routing/custom-controllers.md).

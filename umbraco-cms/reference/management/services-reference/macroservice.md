# MacroService

Defines the MacroService, which is an access to operations involving `IMacro`.

[Browse the API documentation for IMacroService interface](https://apidocs.umbraco.com/v10/csharp/api/Umbraco.Cms.Core.Services.IMacroService.html).

* **Namespace:** `Umbraco.Cms.Core.Services`
* **Assembly:** `Umbraco.Core.dll`

All samples in this document will require references to the following dll:

* Umbraco.Core.dll

```csharp
using Umbraco.Cms.Core.Services;
```

For Razor views:

```csharp
@using Umbraco.Cms.Core.Services
```

## Getting the service

### Dependency Injection

If you wish to use the macro service in a class, you need to specify the `IMacroService` interface in your constructor:

```csharp
public class MyClass
{
    private IMacroService _macroService;

    public MyClass(IMacroService macroService)
    {
        _macroService = macroService;
    }
}
```

In Razor views, you can access the macro service through the `@inject` directive:

```csharp
@inject IMacroService MacroService
```

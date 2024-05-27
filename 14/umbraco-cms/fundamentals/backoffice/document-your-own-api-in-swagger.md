# Documenting your own API in swagger
When you open swagger, you are met by a list of 3 APIs:
![Default list of apis](images/DefaultListOfAPi.png)
If we implement the API from the [Creating your own API](./create-your-own-api.md) article, it is originally under the `Management API` section. If we want to move that, we can replace the `ManagementApiBaseController` attribute with a `Controller` attribute.
```csharp
[ApiController]
[VersionedApiBackOfficeRoute("my/item")]
[ApiExplorerSettings(GroupName = "My item API")]
public class MyItemApiController : Controller
```
When you open swagger, it will show up under the `Default API` section.
![Now it's under default API](images/DefaultListOfAPi.png)
It's great if you only have 1 API, however, if you have multiple, you might want to organize these as well as their own separate silos.

## Adding to the list of APIs
To add to the list of APIs, we need to configure the `SwaggerGenOptions`, we can do this using the `IConfigureOptions` pattern.

```csharp
public class ConfigureSwaggerGenOptions : IConfigureOptions<SwaggerGenOptions>
{
    public void Configure(SwaggerGenOptions options)
    {
        options.SwaggerDoc(
            "myItem",
            new OpenApiInfo
            {
                Title = "My Item Api",
                Version = "Latest",
                Description = "This is my awesome API",
            });
    }
}
```

We then need to register this with the DI container, we can do this by creating a composer and calling `ConfigureOptions` on the `IUmbracoBuilder`.

```csharp
using Umbraco.Cms.Core.Composing;

namespace Umbraco.Cms.Web.UI;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder) => builder.Services.ConfigureOptions<ConfigureSwaggerGenOptions>();
}

```

We then need to use the `MapToApi` attribute to map the controller to the API we just created.

```csharp
[ApiController]
[VersionedApiBackOfficeRoute("my/item")]
[ApiExplorerSettings(GroupName = "My item API")]
[MapToApi("myItem")]
public class MyItemApiController : Controller
```

Now when you open swagger, you will see the new API in the list of APIs.

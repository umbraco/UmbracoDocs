# Documenting your own API in swagger
When you open swagger, you are met by a list of 3 APIs:
![Default list of apis](images/DefaultListOfAPi.png)
If we implement the api from the [Creating your own API](./create-your-own-api.md) article, it is originally under the `Management API` section. If we want to hove that, we can replace the `ManagementApiBaseController` attribute with a `Controller` attribute.
```csharp
[ApiController]
[VersionedApiBackOfficeRoute("my/item")]
[ApiExplorerSettings(GroupName = "My item API")]
public class MyItemApiController : Controller
```
When you open swagger, it will show up under the `Default API` section.
![Now it's under default API](images/DefaultListOfAPi.png)
This is great if you only have 1 API, but if you have multiple, you might want to organise these as well as their own separate silos.

## Adding to the list of APIs
To add to the list of APIs, we need to configure the `SwaggerGenOptions`

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

```csharp
using Umbraco.Cms.Core.Composing;

namespace Umbraco.Cms.Web.UI;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder) => builder.Services.ConfigureOptions<ConfigureSwaggerGenOptions>();
}

```


```csharp
[ApiController]
[VersionedApiBackOfficeRoute("my/item")]
[ApiExplorerSettings(GroupName = "My item API")]
[MapToApi("myItem")]
public class MyItemApiController : Controller
```

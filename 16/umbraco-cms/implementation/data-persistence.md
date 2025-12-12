# Data Persistence (CRUD)

_The Umbraco Services layer is used to query and manipulate Umbraco stored in the database_.

## Dependency injection

All services are available using their interfaces in the dependency injection container. ASP.NET Core supports dependency injection in almost every scenario.

### Constructors in classes

```csharp
    public class MyClass
    {
        private readonly IContentService _contentService;

        public MyClass(IContentService contentService)
        {
            _contentService = contentService;
        }
    }
```

### Constructors in views

```cshtml
    @inject IContentService ContentService
```

## Services

There is a service for each type of data in Umbraco.

[See here For a full list of services available (external)](https://apidocs.umbraco.com/v16/csharp/api/Umbraco.Cms.Core.Services.html)

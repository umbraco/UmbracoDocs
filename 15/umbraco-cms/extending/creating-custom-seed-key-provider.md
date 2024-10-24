---
description: A guide to creating a custom seed key provider for Umbraco
---

# Creating a Custom Seed Key Provider

From version 15 and onwards Umbraco uses a lazy loaded cache, this means content is loaded into the cache on an as-needed basis.
However, you may some specific content to always be in the cache, to achieve this you can implement your own custom seed key providers.

There is two types of seed key providers: `IDocumentSeedKeyProvider` for documents and `IMediaSeedKeyProvider` for media,
these interfaces are identical so only `IDocumentSeedKeyProvider` is demonstrated here.

{% hint style="warning" %}
Seed keys are themselves cached and only calculated once, this means that any documents created after the site has started won't be included in the seed keys untill ther server has restarted.
{% endhint %}

## Implementation

This example implements a `IDocumentSeedKeyProvider` which seeds all the children of a node, in this case blog posts.

First we'll create a class called `BlogSeedKeyProvider` that implements `IDocumentSeedKeyProvider`.

```csharp
using Umbraco.Cms.Infrastructure.HybridCache;

namespace MySite.SeedKeyProviders;

public class BlogSeedKeyProvider : IDocumentSeedKeyProvider
{
    public ISet<Guid> GetSeedKeys()
    {
    }
}
```

Next we'll inject the `IDocumentNavigationQueryService` in order to get the children of the blog node.

```csharp
using Umbraco.Cms.Core.Services.Navigation;
using Umbraco.Cms.Infrastructure.HybridCache;

namespace MySite.SeedKeyProviders;

public class BlogSeedKeyProvider : IDocumentSeedKeyProvider
{
    private readonly IDocumentNavigationQueryService _documentNavigationQueryService;

    public BlogSeedKeyProvider(IDocumentNavigationQueryService documentNavigationQueryService)
        => _documentNavigationQueryService = documentNavigationQueryService;

{...}
```

Now we can parse a hardcoded string to a guid and use the `IDocumentNavigationQueryService` to get the children of the blog node and return their keys as a `HashSet`.

```csharp
public ISet<Guid> GetSeedKeys()
{
    var blogRoot = Guid.Parse("a5fdb22d-b7f2-4a59-8c4e-46ed86bde56c");

    if (_documentNavigationQueryService.TryGetChildrenKeys(blogRoot, out IEnumerable<Guid> blogPostKeys))
    {
        return new HashSet<Guid>(blogPostKeys);
    }

    return new HashSet<Guid>();
}
```
We since we're returning it as a set, and all the sets gets unioned, we don't have to worry about duplicates.

The final class looks like this:

```csharp
using Umbraco.Cms.Core.Services.Navigation;
using Umbraco.Cms.Infrastructure.HybridCache;

namespace MySite.SeedKeyProviders;

public class BlogSeedKeyProvider : IDocumentSeedKeyProvider
{
    private readonly IDocumentNavigationQueryService _documentNavigationQueryService;

    public BlogSeedKeyProvider(IDocumentNavigationQueryService documentNavigationQueryService)
        => _documentNavigationQueryService = documentNavigationQueryService;

    public ISet<Guid> GetSeedKeys()
    {
        var blogRoot = Guid.Parse("a5fdb22d-b7f2-4a59-8c4e-46ed86bde56c");

        if (_documentNavigationQueryService.TryGetChildrenKeys(blogRoot, out IEnumerable<Guid> blogPostKeys))
        {
            return new HashSet<Guid>(blogPostKeys);
        }

        return new HashSet<Guid>();
    }
}
```

### Registering the Seed Key Provider

Now that we have implemented the `BlogSeedKeyProvider` we need to register it in the `Startup` class.

```csharp
using MySite.SeedKeyProviders;
using Umbraco.Cms.Infrastructure.DependencyInjection;
using Umbraco.Cms.Infrastructure.HybridCache;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<IDocumentSeedKeyProvider, BlogSeedKeyProvider>();
{...}
```

Now all our blogpost will be seeded into the cache on startup, and will always be present in the cache.

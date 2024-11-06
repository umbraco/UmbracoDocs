---
description: A guide to creating a custom seed key provider for Umbraco
---

# Creating a Custom Seed Key Provider

Umbraco uses a lazy loaded cache, which means that content is loaded into the cache on an as-needed basis. However, you may need specific content to always be in the cache. To achieve this you can implement your own custom seed key providers.

There are two types of seed key providers: `IDocumentSeedKeyProvider` for documents and `IMediaSeedKeyProvider` for media. As these interfaces are identical only `IDocumentSeedKeyProvider` is demonstrated in this article.

{% hint style="warning" %}
Seed keys are cached and calculated once. Any documents created after the site has started will not be included in the seed keys until after a server restart.
{% endhint %}

## Implementation

This example implements a `IDocumentSeedKeyProvider` which seeds all the children of a node, in this case blog posts.

1. Create a new class called `BlogSeedKeyProvider` that implements `IDocumentSeedKeyProvider`.

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

3. Parse a hardcoded string to a GUID.
4. Use the `IDocumentNavigationQueryService` to get the children of the blog node.
5. Return their keys as a `HashSet`.

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
Since this returns it as a set, and all the sets get unioned, we do not have to worry about duplicates.

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

Now that the `BlogSeedKeyProvider` is implemented, it must be registered in the `Startup` class.

```csharp
using MySite.SeedKeyProviders;
using Umbraco.Cms.Infrastructure.DependencyInjection;
using Umbraco.Cms.Infrastructure.HybridCache;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<IDocumentSeedKeyProvider, BlogSeedKeyProvider>();
{...}
```

All blogpost will now be seeded into the cache on startup, and will always be present in the cache.

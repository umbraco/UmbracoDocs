---
description: "Information on how to insert and delete from the runtime cache"
---

# Working with caching

This article will show you how to insert and delete from the runtime cache.

## Scenario

For this example we're working with tags. On my site I have two tag properties:

1) One on every page using the tag group `default`

2) One on my blog posts using the tag group `blog`

We're going to expose an endpoint that allows us to get the tags from each group.

The tags from the `default` should be cached for a minute. The `blog` tags will be cached until site restart or if you publish a blog post node in the Backoffice.

## Example

Why work with tags? Because they're not cached by default.. which makes them ideal for demo purposes :)

### TagService

First we want to create our `CacheTagService`. In this example it's a basic class with one method (`GetAll`) that wraps Umbraco's `TagQuery.GetAllTags()`.

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Models;
using Umbraco.Cms.Core.PublishedCache;
using Umbraco.Extensions;

namespace Doccers.Core.Services.Implement;

public class CacheTagService : ICacheTagService
{
    private readonly ITagQuery _tagQuery;
    private readonly IAppPolicyCache _runtimeCache;

    public CacheTagService(ITagQuery tagQuery, AppCaches appCaches)
    {
        _tagQuery = tagQuery;
        // Get the RuntimeCache from appCaches
        // and assign to our private field.
        _runtimeCache = appCaches.RuntimeCache;
    }

    public IEnumerable<TagModel> GetAll(
        string group,
        string cacheKey,
        TimeSpan? timeout = null)
    {
        // GetCacheItem will automatically insert the object
        // into cache if it doesn't exist.
        return _runtimeCache.GetCacheItem(cacheKey, () =>
        {
            return _tagQuery.GetAllTags(group);
        }, timeout);
    }
}
```

As you can see we inherit from the `ICacheTagService` interface. All that has is:

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Cms.Core.Models;

namespace Doccers.Core.Services;

public interface ICacheTagService
{
    IEnumerable<TagModel> GetAll(
        string group,
        string cacheKey,
        TimeSpan? timeout = null);
}
```

The interface was created to better register it so we can use dependency injection. You can register your own classes like so:

```csharp
using Doccers.Core.Services;
using Doccers.Core.Services.Implement;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Microsoft.Extensions.DependencyInjection;

namespace Doccers.Core;

public class Composer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddScoped<ICacheTagService, CacheTagService>();
    }
}
```

Now you can inject `ICacheTagService` in any constructor in your project - wohooo!

### API

Now that we have our service it's time to create an endpoint where we can fetch the (cached) tags.

```csharp
using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using Doccers.Core.Services;
using Umbraco.Cms.Core.Models;

namespace Doccers.Core.Controllers.Api;

[ApiController]
[Route("/umbraco/api/tags")]
public class TagsController : Controller
{
    private readonly ICacheTagService _cacheTagService;

    // Dependency injection rocks!
    public TagsController(ICacheTagService cacheTagService)
    {
        _cacheTagService = cacheTagService;
    }

    [HttpGet("getdefaulttags")]
    public IEnumerable<TagModel> GetDefaultTags()
    {
        // As mentioned earlier we want tags from "default"
        // group to be cached for a minute.
        return _cacheTagService.GetAll("default", "defaultTags",
            TimeSpan.FromMinutes(1));
    }

    [HttpGet("getblogtags")]
    public IEnumerable<TagModel> GetBlogTags()
    {
        // If you don't specify a TimeSpan the object(s)
        // will be cached until manually removed or
        // if the site restarts.
        return _cacheTagService.GetAll("blog", "blogTags");
    }
}
```

`/umbraco/api/tags/getblogtags`

![Result](images/response.png)

`/umbraco/api/tags/getdefaulttags`

![Result](images/response-2.png)

Everything should now work as expected when it comes to getting tags. However, if I go to my Backoffice and add a new tag to the `blog` group the changes aren't shown on the endpoint. Let's fix that.

### Clearing cache on publish

To clear the cache we need a notification handler in which we register to the `ContentPublishedNotification` event on the `ContentService`. This allows us to run a piece of code whenever you publish a node.

```csharp
using System.Linq;
using Umbraco.Cms.Core.Cache;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace Doccers.Core;

public class Notification : INotificationHandler<ContentPublishedNotification>
{

    private readonly IAppPolicyCache _runtimeCache;

    public Notification(AppCaches appCaches)
    {
        _runtimeCache = appCaches.RuntimeCache;
    }

    public void Handle(ContentPublishedNotification notification)
    {

        if (notification.PublishedEntities.Any(x => x.ContentType.Alias == "blogPost"))
        {
            _runtimeCache.ClearByKey("blogTags");
        }
    }
}
```

Now that we have our notification we also need to register it. Add `builder.AddNotificationHandler<ContentPublishedNotification, Notification>();` to the `Compose` method in the `Composer` class so it becomes:

```csharp
public void Compose(IUmbracoBuilder builder)
{
    builder.Services.AddScoped<ICacheTagService, CacheTagService>();

    builder.AddNotificationHandler<ContentPublishedNotification, Notification>();

}
```

Awesome! Now we have set up caching on our tags - making the site a bit faster.

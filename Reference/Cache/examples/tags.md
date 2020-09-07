---
versionFrom: 8.0.0
meta.Title: "Working with the runtime cache in Umbraco"
meta.Description: "Information on how to insert and delete from the runtime cache"
---

# Working with caching

This article will show you how to insert and delete from the runtime cache.

## Scenario

For this example we're working with tags. On my site I have two tag properties:

1) One on every page using the tag group `default`

2) One on my blog posts using the tag group `blog`

We're going to expose an endpoint that allows us to get the tags from each group.

The tags from the `default` should be cached for a minute and the `blog` tags will be cached until site restart or if you publish a blog post node in the Backoffice.

## Example

Why work with tags? Because they're not cached by default.. which makes them ideal for demo purposes :)

### TagService

First we want to create our `TagService`. In this example it's a basic class with one method (`GetAll`) that wraps Umbraco's `TagQuery.GetAllTags()`.

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Core.Cache;
using Umbraco.Web;
using Umbraco.Web.Models;

namespace Doccers.Core.Services.Implement
{
    public class TagService : ITagService
    {
        private readonly ITagQuery _tagQuery;
        private readonly IAppPolicyCache _runtimeCache;

        public TagService(ITagQuery tagQuery, AppCaches appCaches)
        {
            _tagQuery = tagQuery;
            // Grap RuntimeCache from appCaches
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
}
```

As you can see we inherit from the `ITagService` interface. All that has is:

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Web.Models;

namespace Doccers.Core.Services
{
    public interface ITagService
    {
        IEnumerable<TagModel> GetAll(
            string group,
            string cacheKey,
            TimeSpan? timeout = null);
    }
}
```

The interface was created to better register it so we can use dependency injection. You can register your own classes like so:

```csharp
using Doccers.Core.Services;
using Doccers.Core.Services.Implement;
using Umbraco.Core;
using Umbraco.Core.Composing;

namespace Doccers.Core
{
    public class Composer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.Register<ITagService, TagService>();
        }
    }
}
```

Now you can inject `ITagService` in any constructor in your project - wohooo!

### API

Now that we have our service it's time to create an endpoint where we can fetch the (cached) tags.

```csharp
using Doccers.Core.Services;
using System;
using System.Collections.Generic;
using System.Web.Http;
using Umbraco.Web.Models;
using Umbraco.Web.WebApi;

namespace Doccers.Core.Controllers.Api
{
    public class TagsController : UmbracoApiController
    {
        private readonly ITagService _tagService;

        // Dependency injection rocks!
        public TagsController(ITagService tagService)
        {
            _tagService = tagService;
        }

        [HttpGet]
        public IEnumerable<TagModel> GetDefaultTags()
        {
            // As mentioned earlier we want tags from "default"
            // group to be cached for a minute.
            return _tagService.GetAll("default", "defaultTags",
                TimeSpan.FromMinutes(1));
        }

        [HttpGet]
        public IEnumerable<TagModel> GetBlogTags()
        {
            // If you don't specify a TimeSpan the object(s)
            // will be cached until manually removed or
            // if the site restarts.
            return _tagService.GetAll("blog", "blogTags");
        }
    }
}
```

`/umbraco/api/tags/getblogtags`:

![Result](images/response.png)

`/umbraco/api/tags/getdefaulttags`:

![Result](images/response-2.png)

Everything should now work as expected when it comes to getting tags. However, if I go to my Backoffice and add a new tag to the `blog` group the changes aren't shown on the endpoint. Let's fix that.

### Clearing cache on publish

To clear the cache we need a component in which we register to the `Published` event on the `ContentService`. This allows us to run a piece of code whenever you publish a node.

```csharp
using System.Linq;
using Umbraco.Core.Cache;
using Umbraco.Core.Composing;
using Umbraco.Core.Events;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Implement;

namespace Doccers.Core
{
    public class Component : IComponent
    {
        private readonly IAppPolicyCache _runtimeCache;

        public Component(AppCaches appCaches)
        {
            // Again we can just grab RuntimeCache from AppCaches.
            _runtimeCache = appCaches.RuntimeCache;
        }

        public void Initialize()
        {
            ContentService.Published += ContentService_Published;
        }

        private void ContentService_Published(IContentService sender,
            ContentPublishedEventArgs e)
        {
            // We only want to clear the blogTags cache
            // if we're publishing a blog post.
            if (e.PublishedEntities
                .Where(x => x.ContentType.Alias == "blogPost").Any())
            {
                _runtimeCache.ClearByKey("blogTags");
            }
        }

        public void Terminate() {
            //unsubscribe during shutdown
            ContentService.Published -= ContentService_Published;
 }
    }
}
```

Now that we have our component we also need to register it. Add `composition.Components().Append<Component>();` to the `Compose` method in the `Composer` class so it becomes:

```csharp
public void Compose(Composition composition)
{
    composition.Register<ITagService, TagService>();

    composition.Components().Append<Component>();
}
```

Awesome! Now we have set up caching on our tags - making the site a bit faster. :)

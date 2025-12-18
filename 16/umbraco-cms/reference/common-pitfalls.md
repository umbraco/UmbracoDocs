---
description: Information on common Pitfalls and Anti-Patterns in Umbraco
---

# Common Pitfalls & Anti-Patterns

This section highlights common pitfalls that developers often encounter. Some of the anti-patterns discussed here can lead to memory leaks, instability, or poor performance on your site. Reading this section could save your site.

## Usage of Singletons and Statics

Generally speaking, if you are writing software these days you should be using Dependency Injection (DI) principles. If you do this, you probably are not using [Singletons](https://en.wikipedia.org/wiki/Singleton_pattern) or [Statics](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/static-classes-and-static-class-members), and for the most part you should not be.

Since Umbraco comes with dependency injection out of the box, there really is no reason to use singletons or statics. It makes your code difficult to test and hard to manage. Furthermore, the APIs become leaky and you will end up with more problems than when you started.

Dependency injection is available everywhere, and you can register your own services as well. Additionally, some resources are available through properties on certain base classes. For example, all Razor views that Umbraco creates expose an `UmbracoHelper` property you can access through `@Umbraco`. The other base classes expose some things you might need like `UmbracoContext`, and things like `SurfaceController`. Even here the services are initially obtained through DI, and you can inject further Umbraco and custom services that you might need.

For more information about consuming and registering your own dependencies have a look at the [Dependency Injection](using-ioc.md) documentation.

### Example of using base class properties gotten through DI

```csharp
public class ContactFormSurfaceController : SurfaceController
{
    // The services are injected with DI and passed to the parent class
    public ContactFormSurfaceController(
        IUmbracoContextAccessor umbracoContextAccessor,
        IUmbracoDatabaseFactory databaseFactory,
        ServiceContext services,
        AppCaches appCaches,
        IProfilingLogger profilingLogger,
        IPublishedUrlProvider publishedUrlProvider)
        : base(umbracoContextAccessor, databaseFactory, services, appCaches, profilingLogger, publishedUrlProvider)
    {
    }

    [HttpPost]
    public IActionResult SubmitForm(ContactFormModel model)
    {
        // All normal form processing logic is left out of this example for brevity.
        // You can access all of these properties because they are properties of the base class. 
        // If you need something else you can inject it in the constructor.
        
        //Profiling logger
        using (ProfilingLogger.TraceDuration<ContactFormSurfaceController>("Start", "stop"))
        {
            // UmbracoContext
            UmbracoContext.Content.GetById(1234);
        }

        return Ok();
    }
}
```

## Static references to scoped instances such as `UmbracoHelper`

### Example 1

```csharp
public class BadApiController : Controller
{
    // Note that this is static, that's bad
    private static UmbracoHelper _umbracoHelper;
    
    public BadApiController(IUmbracoHelperAccessor umbracoHelperAccessor)
    {
        // Don't do this, this is bad
        if (_umbracoHelper is null)
        {
            umbracoHelperAccessor.TryGetUmbracoHelper(out UmbracoHelper umbracoHelper);
            _umbracoHelper = umbracoHelper;
        }
    }
}
```

This practice can cause memory leaks along with inconsistent data results when using this `_umbracoHelper` instance.

It is important to understand the difference between an object with Request-based scope and Singleton/Application-based scope.

* **Application scope**: If an object has a singleton/application scope, that single object instance will exist for the lifetime of the application. The single instance will be shared by every thread that accesses it. Static variables will always exist for the lifespan of the application.
* **Request scope**: The web world is made up of requests and each request has its own thread. When an object is in the scope of a Request it only survives as long as the web request survives. At the end of the web request, the object may either be disposed of or cleared from memory by the garbage collector. Request scoped object instances are not accessed by every other thread in the application unless you do something like the above.

An example of a request-scoped instance is the `HttpContext`. This object exists for a single request and it cannot be shared between other threads, especially not other request threads. This is because the object's thread is where the security information for a given user is handled. The `UmbracoContext` is also a request-scoped object. In fact, it relies directly on an instance of `HttpContext`. The `UmbracoHelper` is request-scoped as well.

In the example above, the `UmbracoHelper`, which has a request-scoped lifetime, will be statically assigned to a variable. This request-scoped object is now bound to an Application-scope lifetime and will exist after the request has ended. This could mean that under certain circumstances an entire Umbraco cache copy is stuck in memory. It could also mean that the `Security` property of the context will be accessed by multiple threads. These threads may now contain the security information for a user from another request.

Additionally there is never really any reason to use static references. Instead, you should always inject your required resources, and let the DI container handle the lifetimes of the objects.

## Querying with Descendants using DescendantsOrSelf

When using queries like this, you need to understand the implications. Here is a particularly bad scenario:

You have 10,000 content items in your tree and your tree structure is something like this:

```none
- Root
-- Home
-- Blog (Collection with 9495 nodes)
-- Office Locations (Collection with 500 nodes)
-- About Us
-- Contact Us
```

You create a menu on your Home page like:

```csharp
<ul>
 <li><a href="@Model.Root().Url()">@Model.Root().Name</a></li>
 @foreach (var node in Model.Root().DescendantsOrSelf().Where(x => x.Level == 2))
 {
  <li><a href="@node.Url()">@node.Name</a></li>
 }
</ul>
```

The query above renders out: _Root, Home, Blog, Office Locations, About Us, Contact Us_

This is going to iterate over every single node in Umbraco, all 10,000 of them. This will have a negative effect on the site's general performance.

Instead of using the snippet above, something similar to the snippet below can be used:

```csharp
<ul>
 <li><a href="@Model.Root().Url()">@Model.Root().Name</a></li>
 @foreach (var node in Model.Root().Children)
 {
  <li><a href="@node.Url()">@node.Name</a></li>
 }
</ul>
```

In many cases, you might know that there is only ever going to be a small number of Descendants. If so, using Descendants or DescendantsOrSelf will not have a negative effect on the site's performance. It is important to always be aware of the implications of what you are writing.

## Too much querying ("Over querying")

Querying and traversing content is not free. Anytime you make a query or resolve a property value there is overhead involved. Think about every query you make as an SQL call; too many requests can have a negative effect on the site's performance.

Here is a common pitfall in relation to this:

Following the example above, the menu is going to be rendered using the current page's root node:

```csharp
<ul>
 <li><a href="@Model.Root().Url()">@Model.Root().Name</a></li>
 @foreach (var node in Model.Root().Children)
 {
  <li><a href="@node.Url()">@node.Name</a></li>
 }
</ul>
```

The `@Model.Root()` syntax is shorthand for doing this: `Model.AncestorOrSelf(1)`. This will traverse up the tree until it reaches an ancestor node with a level of one. As mentioned above, traversing costs resources and in this example, there are 3x traversals being done for the same value.

Consider writing something similar to the example below:

```csharp
@{
 var root = Model.Root();
}
<ul>
 <li><a href="@root.Url()">@root.Name</a></li>
 @foreach (var node in root.Children)
 {
  <li><a href="@node.Url()">@node.Name</a></li>
 }
</ul>
```

## Using the Services layer in your views

The Services layer of Umbraco is for manipulating the business logic of Umbraco directly to/from the database. None of these methods should be used within your views and can have a negative impact on the performance and stability of your application.

Your views should rely only on the read-only data services such as `UmbracoHelper`, `ITagQuery` and `IMemberManager` and the properties and methods they expose. This ensures that the data being queried comes from the cache and that you are not inadvertently making database changes.

For example, when retrieving a content item in your views:

```csharp
@using Umbraco.Cms.Core.Services
@inject IContentService _contentService

@{
 // Services access in your views :(
 var dontDoThis = _contentService.GetById(1234);
 
 // Content cache access in your views
 var doThis = Umbraco.Content(1234);
}
```

If you are using services in your views, you should figure out why this is being done and, in most cases, remove this logic.

## Using Umbraco content items for volatile data

This is one of the anti-patterns that could have the most negative impact on your site's performance.

Umbraco content should not be used for volatile data. The Umbraco APIs, and the way Umbraco data is persisted, was not designed for this. When you need to store, write or track data that changes a lot, use a custom database table or another service. Do not use Umbraco content nodes for this.

Some examples of what not to do, and what to do instead:

| What not to do                                                       | Alternative                                                             |
| -------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Hit counters to track the number of times your page has been viewed. | Use something like Google Analytics or a custom database table instead. |
| Creating new nodes for form submissions.                             | This should be stored in a custom database table.                       |
| Importing lots of data into Umbraco content nodes.                   | Import the data into custom database tables instead.                    |

## Processing during startup

Umbraco allows you to run some initialization code during startup by using `UmbracoApplicationStartingNotification`. This code can have a negative impact on the application startup process. This is especially true for Package developers as your code could end up impacting many websites.

In many cases, [initialization code can be done lazily instead of eagerly](https://msdn.microsoft.com/en-us/library/dd997286\(v=vs.110\).aspx). Instead of initialization everything you need as soon as the application starts, you could execute your initialization code only when it is required. This can be achieved in different ways, such as:

* Using [`Lazy<T>`](https://msdn.microsoft.com/en-us/library/dd642331\(v=vs.110\).aspx) and putting the initialization logic in its callback.
* Using [`LazyInitializer`](https://msdn.microsoft.com/en-us/library/system.threading.lazyinitializer\(v=vs.110\).aspx?f=255\&MSPPError=-2147217396).
* Putting logic in a property getter with a lock and setting a flag when it is processed.
* Putting logic in a method with a lock and setting a flag when it is processed.

It is important to ensure that the initialization logic executes only once for the lifetime of the application, even when your app domain is restarted. If your initialization logic creates a database table that should only be executed one time, set a persistence flag. A persistence flag will indicate to your own logic that the initialization code has already been executed and does not need to be done again.

## Rebuilding indexes

Rebuilding examine indexes can have a negative effect of the sites performance and is not a recommended practice. It is recommeded to ensure you are running the latest Umbraco and Examine versions if you are having trouble with out-of-sync index data.

The primary reasons your data will become out of sync are:

* Old version of Umbraco.
* Rebuilding indexes and restarting your app domain at the same time.

It is not recommended to rebuild your indexes unless you absolutely need to. If you need to do this often then it is advised to determine why and to try to resolve the underlying problem.

## Performing lookups and logic in Examine events

There are a couple of well-known Examine events: `TransformingIndexValues` and `DocumentWriting`. Both of these events allow the developer to modify the data that is going into the Lucene index. We often see developers performing service lookups in these methods. For example, using `IContentService.GetById(e.NodeId)` inside of these events could cause an `N + 1` problem. This is because these events are executed for every single document being indexed. If you are rebuilding an index, this will mean that this logic will fire for every single document and media item going into each index. That could mean a large number of lookups, which can negatively impact on the site's performance.

Similarly, if you are executing inefficient logic in these events, anytime you save or publish content or media that logic will slow the process down. If you rebuild an index, any slow code running in these events will cause the indexing to go even slower.

## RenderTemplateAsync

The API method called `RenderTemplateAsync` allows you to render a particular content item's template and get a `IHtmlEncodedString` in response. This could be useful if you want to send an email based on a content item and its template. However, you must be careful not to use this for purposes it is not meant to be used for.

Do not use this method for rendering content as this could cause severe performance problems. For you are rendering normal content of module type data from another content item, you should use Partial Views instead.

## Do not put logic inside your constructors

Constructors should generally not perform any logic. They should set parameter values, perform null checks and perhaps validate data.

There are a few reasons why this can become a performance problem:

* The consumer of an API does not expect that by creating an object they should be worried about performance.
* Creating an object can inadvertently happen many times, especially when using Language Integrated Query (LINQ).

Here is an example of how this can go wrong.

Your tree structure is something like this:

```none
- Root
-- Home
--- Recipes (node id = 3251, Collection with 5000 nodes)
--- About Us
--- Contact Us
```

You have a custom model that looks like this:

```csharp
public class RecipeModel : PublishedContentWrapped
{
    public RecipeModel(IPublishedContent content, IPublishedValueFallback publishedValueFallback) : base(content, publishedValueFallback)
    {
        RelatedRecipes = content
            .Parent
            .Children<RecipeModel>()
            .Where(x => x.Value<IEnumerable<int>>("related")
                .Contains(content.Id));

        Votes = content.Value<int>("votes");
    }
    
    public int Votes { get; private set; }
    
    public IEnumerable<RecipeModel> RelatedRecipes { get; private set; }
}
}
```

You run the following code to show the favorites:

```csharp
@var recipeNode = Umbraco.TypedContent(3251);
@{
 var recipeNode = Umbraco.Content(1234);
}

<ul>
 @foreach (var recipe in recipeNode.Children
  .Select(x => new RecipeModel(x, _publishedValueFallback))
  .OrderByDescending(x => x.Votes)
  .Take(10))
 {
  <li><a href="@recipe.Url()">@recipe.Name</a></li>
 } 
</ul>
```

To show the top 10 voted recipes, this code will end up doing the following:

* Iterate over all 5000 Recipes.
* Create and allocate 5000 instances of `RecipeModel`.
* For each `RecipeModel` created, it will traverse upwards, iterate all 5000 recipes then resolve property data for 2 properties.

This means that there is now an additional 5,000 new objects created and allocated in memory. The number of traversals/visits to each of these objects is now `5000 x 5000 = 25,000,000`.

The other problem is that the logic used to lookup related recipes is inefficient. Instead, each recipe should have a picker to choose its related recipes, and then each of those can be looked up by their ID.

## Do not eager load data, lazy load it instead

The above example could be rewritten like this:

```csharp
    public class RecipeModel : PublishedContentWrapped
    {
        public RecipeModel(IPublishedContent content, IPublishedValueFallback publishedValueFallback) : base(content, publishedValueFallback)
        {}

        private int? _votes;
        public int Votes
        {
            get
            {
                // Lazy load the property value and ensure it's not re-resolved once it's loaded
                return _votes ??= this.Value<int>("votes");
            }
        }

        // Just return the Ids, they can be resolved to IPublishedContent instances in the view or elsewhere,
        // doesn't need to be in the model - this would also be bad if the model was cached since all of the
        // related entities would end up in the cache too.
        private List<int> _related;

        public IEnumerable<int> RelatedRecipes => _related ??= this.Value<IEnumerable<int>>("related").ToList();
    }
```

The code will still iterate over all Recipes meaning that the number of traversals/visits to each of these objects will be 5000.

There really is not much reason to create a `RecipeModel`. Instead, it could be written like:

```csharp
@{
 var recipeNode = Umbraco.Content(1234);
}

<ul>
 @foreach (var recipe in recipeNode.Children
  .OrderByDescending(x => x.Value<int>("votes"))
  .Take(10))
 {
  <li><a href="@recipe.Url()">@recipe.Name</a></li>
 }
</ul>
```

## Not caching expensive lookups

Based on the above two points, you can see that iterating content with the traversal APIs ends up being expensive in terms of performance.

How to solve performance issues will always depend on the specific scenario. One thing to consider is to cache the IDs of the content you need in your critical code. Then you could retrieve the content from the cache by ID.

When you need to render the same four pieces of content for your navigation, we recommend caching, or hardcoding, the IDs of those content items. You can retrieve the content from their IDs using `Umbraco.Content`. This will always be faster than trying to traverse your content tree and finding the content programmatically. It will do a direct lookup in the cache, meaning that your code does not have to do many traversals to get your content.

## Be mindful about memory

When memory is used, for instance creating 5,000 recipe models with a `Select` statement, [Garbage Collection](https://learn.microsoft.com/en-us/dotnet/standard/garbage-collection/) needs to occur. This turnover can cause performance problems. The more objects created, the more items allocated in memory, the harder the job is for the Garbage Collector, resulting in more performance problems.

Even worse is when you allocate a lot of large items in memory. These items will remain in memory for a long time, ending up in "[Generation 3](https://learn.microsoft.com/en-us/dotnet/standard/garbage-collection/fundamentals#generations)" which the Garbage Collector ignores for as long as possible. It does so because it knows it is going to take a lot of resources to clean up.

## Best practices when using Models Builder

Extending models should be used to add stateless, local features to models. It should not be used to transform content models into view models or manage trees of content.\
You can read more about this in the [Understanding and Extending Models Builder documentation](templating/modelsbuilder/understand-and-extend.md)

## Multi-Site URL Handling

### Introduction

Hosting multiple sites in one Umbraco instance is powerful, but routing complexity can cause subtle issues. This guide outlines common pitfalls and solutions.

**Key principle:** Always use domain-aware APIs. Never assume content tree structure maps
to URL structure in multi-site setups.

### Recommended APIs

Use these APIs for correct multi-site URL handling:

* IPublishedUrlProvider.GetUrl(id, UrlMode.Absolute) – Re-resolves URLs with current domain context
* content.Url(mode: UrlMode.Absolute) – Extension method for IPublishedContent
* IDomainService.GetAll() – Retrieves all configured domains with their RootContentId
* IUmbracoContextAccessor – Access to current Umbraco context for content resolution

### Problem 1: Using Link.Url Directly

#### The Issue

The Link model from Multi URL Picker stores a pre-resolved URL string. This value is
cached at save time and does not re-evaluate the domain context at render time.

**Impact:** In multi-site setups, Link.Url may return a URL pointing to the wrong domain,
causing cross-site linking issues.

#### The Fix

Always re-resolve content links using IPublishedUrlProvider. Check if the link has a Udi
(indicating an internal content link), then fetch the content and generate a fresh URL:

```csharp
if (link.Udi != null)
{
var content = umbracoContext.Content?.GetById(link.Udi);
var url = _publishedUrlProvider.GetUrl(content.Id, UrlMode.Absolute);
}
```

### Problem 2: Walking the Content Tree to Find Home

#### The Issue

A common pattern is walking up the content tree using Parent or AncestorOrSelf() to findhe "home" node. This approach ignores domain assignments entirely.

**Impact:** After a cache rebuild, the first "home" node found in memory may belong to the
wrong site. This is non-deterministic and can cause Site B to serve Site A's configuration.

#### The Fix
Use IDomainService to look up the correct root node based on the current request's domain.
Match the request's Uri.Authority against configured domains and use the RootContentId
to fetch the correct home node.

### Problem 3: Non-Domain-Aware Resolution in Routing Handlers

#### The Issue

When implementing `INotificationHandler<RoutingRequestNotification>` or custom
content finders, using tree-walking methods to find configuration nodes is dangerous.

**Why This Is Critical**

* Runs on **every request** during Umbraco's routing phase
* After system reboot, cache rebuild order is non-deterministic
* May always return Site 1's home node, causing Site 2 to serve Site 1's content
* Affects entire site rendering, not only specific components

#### The Fix

Inject IDomainService and IUmbracoContextAccessor into your handler. Match the current
request's host against configured domains:

```csharp
var allDomains = _domainService.GetAll(true).ToList();
var currentHost = requestBuilder.Uri.Authority;
var matchingDomain = allDomains.FirstOrDefault(d =>
d.DomainName == currentHost ||
d.DomainName == $"https://{currentHost}" ||
d.DomainName == $"http://{currentHost}");
var homeNode = umbracoContext.Content?.GetById(matchingDomain.RootContentId.Value);
```

**Key benefit:** This approach is deterministic – it always returns the correct home node
regardless of cache order or rebuild timing.

### Problem 4: Link Picker URLs in Multi-Site Setups

This extends Problem 1 to all link picker usage patterns. The Link model's Url property is a
cached string that may point to the wrong domain.

#### Complete Solution Pattern

Create a helper method that handles all link types correctly:

* **External URLs** (starting with http:// or https://) – return as-is
* **Content links with Udi** – re-resolve using IPublishedUrlProvider
* **Relative URLs** – prepend current domain if needed

### Recommended WebRouting Configuration

Add this configuration to your appsettings.json for optimal multi-site routing:

```
{
"Umbraco": {
"CMS": {
"WebRouting": {
"TryMatchingEndpointsForAllPages": false,
"DisableRedirectUrlTracking": false,
"UrlProviderMode": "Auto"
}
}
}
}
```

#### Configuration Notes

* TryMatchingEndpointsForAllPages: false – This is the default. Ensures Umbraco doesn't attempt endpoint matching across all sites before the dynamic router.
* UrlProviderMode: "Auto" – Lets Umbraco determine whether to return relative or absolute URLs based on context.
* DisableRedirectUrlTracking: false – Keeps redirect tracking enabled for moved/renamed content.


---
meta.Title: Common Pitfalls and Anti-Patterns in Umbraco
description: Information on common Pitfalls and Anti-Patterns in Umbraco
---

# Common Pitfalls & Anti-Patterns

This section describes many common pitfalls that developers fall into. Some of the anti-patterns mentioned here can bring your site to a grinding halt, cause memory leaks, or make your site unstable or perform poorly. Make sure you read this section - it might save your site.

## Usage of Singletons and Statics

Generally speaking, if you are writing software these days you should be using Dependency Injection principles. If you do this, you probably aren't using [Singletons](https://en.wikipedia.org/wiki/Singleton_pattern) or [Statics](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/static-classes-and-static-class-members) (and for the most part you shouldn't be!). Since Umbraco 9 comes with dependency injection out of the box, there really isn't any reason to use singletons or statics. It makes your code very difficult to test but more importantly using Singletons and Statics in your code makes it very hard to manage, APIs become leaky, and ultimately you'll end up with more problems than when you started.

Dependency injection is available everywhere, and you can register your own services as well, additionally, some resources are available through properties on certain base classes. For example, all Razor views that Umbraco creates expose an `UmbracoHelper` property you can access through `@Umbraco`, as well as a `SmidgeHelper` property. The other base classes that expose some things you might need like `UmbracoContext` are things like `SurfaceController`, but even here the services are initially gotten through DI, and you can inject further Umbraco and custom services that you might need.

For more information about consuming and registering your own dependencies have a look at the [Dependency Injection](using-ioc.md) documentation

**Example of using base class properties gotten through DI:**

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
        // All normal form processing logic is left out of this example for brevity
        // You can access all of these because they are properties of the base class, 
        // if you need something else you can inject it in the constructor.
        
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

So next time you are using a singleton pattern or a static, think "Why am I doing this?", "I'm using Dependency Injection, I should be injecting this instance into my class."

## Static references to scoped instances (such as `UmbracoHelper`)

**Example 1:**

```csharp
public class BadApiController : UmbracoApiController
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

**Why?**

It's important to understand the difference between an object that has a Request based scope/lifespan and an object that has a Singleton/Application based scope/lifespan ... here's the gist:

* Application scope - if an object has a singleton/application scope/lifespan, that means that this single object instance will exist for the lifetime of the application. The single instance will be shared by every thread that accesses it. Static variables will always be application lifespan.
* Request scope - The web world is made up of requests and each request has its own thread. When an object is in the scope of a Request it only survives as long as the web request survives. At the end of the web request, it may either be disposed of or cleared from memory by the garbage collector. Request scoped object instances are not accessed by every other thread in the application - **unless you do something like the above!**

An example of a request-scoped instance is the `HttpContext`. This object exists for a single request and it definitely cannot be shared between other threads and especially not other request threads. This is because it is where the security information for a given user is stored! The `UmbracoContext` is also a request-scoped object - in fact, it relies directly on an instance of `HttpContext`. The `UmbracoHelper` is request-scoped as well.

So... in the above example, the `UmbracoHelper` which has a request-scoped lifetime, will now be statically assigned to a variable, which means that this particular request-scoped object is now bound to an Application scope lifetime and will never go away. This could mean that under certain circumstances that an entire Umbraco cache copy is stuck in memory, or that the `Security` property of the context will be accessed by multiple threads but this now contains the security information for a user for another request!

Additionally, since V9 comes with dependency injection out of the box, there's never really any reason to use static references, instead, you should always use inject your required resources, and let the DI container handle the lifetimes of the objects.

## Querying with Descendants, DescendantsOrSelf

It's not 100% bad that you use these queries, you need to understand the implications. Here's a particularly bad scenario:

You have 10,000 content items in your tree and your tree structure is something like this:

```
- Root
-- Home
-- Blog (list view with 9495 nodes)
-- Office Locations (list view with 500 nodes)
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

Which renders out: _Root, Home, Blog, Office Locations, About Us, Contact Us_

BUT!... this is going to perform most horribly. This is going to iterate over every single node in Umbraco, all 10,000 of them!

This can be re-written as:

```csharp
<ul>
	<li><a href="@Model.Root().Url()">@Model.Root().Name</a></li>
	@foreach (var node in Model.Root().Children)
	{
		<li><a href="@node.Url()">@node.Name</a></li>
	}
</ul>
```

In many cases, you might know that there is only ever going to be a small number of Descendants. If so then go nuts and use Descendants or DescendantsOrSelf. It's important to be aware of the implications of what you are writing.

## Too much querying (Over querying)

Querying content is not Free! Anytime you make a query or resolve a property value be aware that there is overhead involved. You could try to think about every query you make as an SQL call - you don't want to make too many otherwise the performance of your website is going to suffer.

Here's a common pitfall that is seen. Let's continue the menu example, in this example, the menu is going to be rendered using the current page's root node:

```csharp
<ul>
	<li><a href="@Model.Root().Url()">@Model.Root().Name</a></li>
	@foreach (var node in Model.Root().Children)
	{
		<li><a href="@node.Url()">@node.Name</a></li>
	}
</ul>
```

The syntax `@Model.Root()` is shorthand for doing this: `Model.AncestorOrSelf(1)` which means it is going to traverse up the tree until it reaches an ancestor node with a level of one. As mentioned above, traversing costs resources and in this example, there are 3x traversals being done for the same value. Instead, this can be rewritten as:

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

The Services layer of Umbraco is for manipulating the business logic of Umbraco directly to/from the database. None of these methods should be used within your views and can have a very large impact on the performance and stability of your application.

Your views should rely only on the read-only data services such as `UmbracoHelper`, `ITagQuery` and `IMemberManager` and the properties/methods that they expose. This ensures that the data being queried is fast (comes from cache) and that you aren't inadvertently making database changes.

**For example**, when retrieving a content item in your views:

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

This is one of the worst Umbraco anti-patterns and could very well cause your site to perform ultra poorly.

Umbraco's content should not be used for volatile data, Umbraco's APIs and the way Umbraco's data is persisted was never designed for this. If you need to store/write/track data that changes a lot you should use a custom database table or another service but not Umbraco content nodes.

Some examples of what not to do are:

* Hit counters to track the number of times your page has been viewed - use something like Google Analytics for this or a custom database table
* Creating new nodes for form submissions - this should be stored in a custom database table
* Importing lots of data into Umbraco content nodes that could be stored in a custom database table (i.e. it's not going to be edited). In some cases, this might be ok but many times we've seen bulk imports occur on an hourly/daily schedule which is generally unnecessary.

## Processing during startup

Umbraco allows you to run some initialization code during startup by using `UmbracoApplicationStartingNotification` or `UmbracoApplicationMainDomAcquiredNotification`, however, great care should be used to ensure that you are not slowing down application startup. You should be especially careful as a Package developer that you are not slowing down application startup since your package may end up being used for thousands of websites.

In many cases, [initialization code can be done lazily instead of eagerly](https://msdn.microsoft.com/en-us/library/dd997286\(v=vs.110\).aspx). Instead of initialization everything you need as soon as the application starts you could execute your initialization code only when it is required. This can be achieved in various ways such as:

* Using [`Lazy<T>`](https://msdn.microsoft.com/en-us/library/dd642331\(v=vs.110\).aspx) and put the initialization logic in its callback
* Using [`LazyInitializer`](https://msdn.microsoft.com/en-us/library/system.threading.lazyinitializer\(v=vs.110\).aspx?f=255\&MSPPError=-2147217396)
* Putting logic in a property getter with a lock and setting a flag that it's processed
* Putting logic in a method with a lock and setting a flag that it's processed
* (there's plenty of ways)

Even more important is that you ensure that the initialization logic only executes one time for the lifetime of the application even when your app domain is restarted. If your initialization logic creates a database table or something similar to that, where it should only be executed one time only. Then you should set a persistent flag (such as a file) to indicate to your own logic that the initialization code has already been executed and doesn't need to be done again.

## Rebuilding indexes

Far too often we've seen code in people's solutions that rebuild the Examine indexes (we've even seen this done on every request!). Rebuilding indexes can cause severe performance penalties and is not a recommended practice. Umbraco's and Examine's index management, index stability, and synchronization of the data in the index get better with every release. You should always ensure you are running the latest Umbraco and Examine versions if you are having trouble with your index data becoming out of sync with your Umbraco data.

The primary reasons your data will become out of sync are:

* Old version of Umbraco
* Rebuilding indexes and restarting your app domain at the same time (try to avoid this scenario!)

It is not recommended to rebuild your indexes unless you absolutely need to and if you need to do this often then it is advised to determine why and to try to resolve the underlying problem.

## Performing lookups and logic in Examine events

There's a couple well known Examine events: `TransformingIndexValues` and `DocumentWriting`. Both of these events allow the developer to modify the data that is going into the Lucene index but many times we see developers Performing Service lookups in these methods. For example, using `IContentService.GetById(e.NodeId)` inside of these events could cause an `N + 1` problem. This is because these events are executed for every single document being indexed and if you are rebuilding an index, this will mean this logic will fire for every single document and media item going into each index ... That could mean a tremendous number of lookups and performance drain.

Similarly, if you are executing other logic in these events that perform poorly, then anytime you save or publish content or media it will slow that process down. And if you rebuild an index then any slow code running in these events will cause the indexing to go ultra slow.

## RenderTemplateAsync

There is an API in Umbraco that should never be used unless you really know what you are doing. This API method is called `RenderTemplateAsync`. It allows you to be able to render a particular content item's template and get a `IHtmlEncodedString` in response. In some cases, this may be useful. Perhaps you want to send an email based on a content item and its template, but you must be very careful not to use this for purposes it is not meant to be used for.

Generally speaking, this method should not be used for the normal rendering of content. If abused this could cause severe performance problems. For normal content rendering of module type data from another content item, you should use Partial Views instead.

## Don't put logic inside your constructors

Constructors should generally not perform any logic, they should set some parameter values, perform some null checks and perhaps validate some data but in most cases, they should not perform any logic.

There are a few reasons why this can become a huge performance problem:

* The consumer of an API doesn't expect that by creating an object that they should be worried about performance
* Creating an object can inadvertently happen a vast number of times, especially when using LINQ

Here's an example of how this can go wrong very quickly: Your tree structure is something like this:

```
- Root
-- Home
--- Recipes (node id = 3251, list view with 5000 nodes)
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

You then run the following code to show to show the favorites

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

**Ouch!** To show the top 10 voted recipes's this will end up doing the following:

* This will iterate over all 5000 Recipes
* This will create and allocate 5000 instances of `RecipeModel`
* For each `RecipeModel` created, this will traverse upwards, iterate all 5000 recipes then resolve property data for 2 properties

This means that there is now an additional **5,000** new objects created and allocated in memory. The number of traversals/visits to each of these objects is now 5000 x 5000 = **25,000,000 (25 MILLION TIMES!)**

_Side note: The other problem is the logic used to lookup related recipes is incredibly inefficient. Instead, each recipe should have a picker to choose its related recipe's and then each of those can be looked up by their ID. (There's probably a few other ways to achieve this too!)_

This leads us on to the next anti-pattern...

## Don't eager load data, lazy load it instead

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

This is slightly better. but will still iterate over all Recipes so the number of traversals/visits to each of these objects is now **5000**.

This is still not great though. There really isn't much reason to create a `RecipeModel`. This could be written like:

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

Based on the above 2 points, you can see that iterating content with the traversal APIs ends up being very expensive.

So what can we do to mitigate this? Unfortunately, there is no silver bullet that will solve all your performance issues, it will always depend on your specific scenario. One great tip though is to cache the IDs of the content you need in your critical code and then retrieve it from the cache by ID. For instance, if you need to render the same four pieces of content for your nav, then cache, or simply hardcode, the IDs of the content items and retrieve them with the ID using `Umbraco.Content`, this will always be much, much faster than trying to traverse your content tree and finding the content programmatically, since it will do a direct lookup in the cache, meaning that your code don't have to do thousands of traversals to get your content.

## Be mindful about memory

When memory is used, for instance creating 5,000 recipe models with a `Select` statement, Garbage Collection needs to occur and this turnover can cause performance problems. The more objects created, the more items allocated in memory, the harder the job is for the Garbage Collector == more performance problems. Even worse is when you allocate tons of items in memory and/or really large items in memory. They will remain in memory for a long time because they'll end up in something called "Generation 3" which the GC tries to ignore for as long as possible. It does so because it knows it's going to take a lot of resources to clean up!

## Best practices when using Models Builder

Extending models should be used to add stateless, local features to models. It should not be used to transform content models into view models or manage trees of content. You can read more about this in the [Understanding and Extending Models Builder documentation](templating/modelsbuilder/understand-and-extend.md).

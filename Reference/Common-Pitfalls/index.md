# Common Pitfalls & Anti-Patterns

_This section is ultra important! It will describe many common pitfalls that developers fall in to. 
Some of the anti-patterns mentioned here can bring your site to a grinding halt, cause memory leaks, or just make your site unstable or perform poorly.
Make sure you read this section - it might just save your site!_

## Usage of Singletons and Statics

Generally speaking if you are writing software these days you should be using Dependency Injection principles. 
If you do this, you probably aren't using Singletons or Statics (and for the most part you shouldn't be!), 
however since Umbraco itself is not built with an IoC container to use out of the box you may find yourself 
using Umbraco's built in Singleton accessors like: 
`ApplicationContext.Current` or `UmbracoContext.Current`. In most cases you shouldn't be using these Singleton accessors, 
it makes your code very difficult to test but more importantly using Singletons and Statics in your code make it very hard 
to manage, APIs become leaky and ultimately you'll end up with more problems than when you started.

In all Umbraco base classes that you'll normally use, these object are already exposed as properties, so please use these instead!
For example, all Razor views that Umbraco creates expose an `Umbraco` property which is the UmbracoContext, they expose an `ApplicationContext` 
property which is Umbraco's `ApplicationContext`. The other base classes that expose all the instances you need are things like `SurfaceController`,
`UmbracoApiController`, `UmbracoController`, `RenderMvcController`, `UmbracoUserControl`, `UmbracoPage`, `UmbracoHttpHandler`, and the list goes on...

So next time you are using `ApplicationContext.Current` or `UmbracoContext.Current` think "Why am I doing this?", 
"Is this already exposed as a property of the base class that I'm using?", "I'm using Dependency Injection, I should be injecting this instance into my class."


## Static references to web request instances (such as `UmbracoHelper`)

__Example 1:__

```csharp
private static _umbracoHelper = new UmbracoHelper(UmbracoContext.Current); 
```

This practice can cause memory leaks along with inconsistent data results when using this `_umbracoHelper` instance. 

__Why?__

It's important to understand the difference between an object that has a Request based scope/lifespan and 
an object that has an Application based scope/lifespan ... here's the gist:

* Application scope - if an object has an Application scope/lifespan, that means that this single object
instance will exist for the lifetime of the application. The single instance will be shared by every thread that
accesses it. Static variables will always be Appplication scope/lifespan.
* Request scope - The web world is made up of requests and each request is it's own thread. When an object is has a Request scope
it only survives as long as the web request survives, at the end of the web request, it may either be disposed or cleared from memory
by the garbage collector. Request scoped object instances are not accessed by every other thread in the application - __unless you do something like the above!__

An example of an application scoped instance is Umbraco's `ApplicationContext`, this single instance is shared by all threads and exists for the lifetime of
the application. 

An example of a request scoped instance is the `HttpContext`, this object exists for a single request, it definitely cannot be shared between other threads and especially
not other request threads because this is where the security information for a given user is stored! The `UmbracoContext` is also a request scoped object - in fact it 
relies directly on an instance of `HttpContext`. The `UmbracoHelper` is a request scoped object - as you can see above, it requires an instance of an `UmbracoContext`.

So... in the above example, the `UmbracoHelper` which relies on an `UmbracoContext` which relies on an `HttpContext` will now be statically assigned to a variable, which means
that these particular request scoped objects are now bound to an Application scope lifetime and will never go away. This could mean that under certain circumstances that an entire Umbraco
cache copy is stuck in memory, or that the `Security` property of the context will be accessed by multiple threads but this now contains the security information for a user for another request!

__Other Examples:__

```csharp
private static _umbracoContext = UmbracoContext.Current;
```

```csharp
//MembershipHelper is also a request scoped instance - it relies either on an UmbracoContext or an HttpContext
private static _membershipHelper = new MembershipHelper(UmbracoContext.Current);
```

```csharp
private static _request = HttpContext.Current.Request;
```

## Querying with Descendants, DescendantsOrSelf

It's not 100% bad that you use these queries, you just need to understand the implications. 
Here's a particularly bad scenario:

* You have 10,000 content items in your tree
* Your tree structure is something like this:
```
- Root
-- Home
--- Blog (list view with 9495 nodes)
--- Office Locations (list view with 500 nodes)
--- About Us
--- Contact Us
```

You create a menu on your Home page like:

```
<ul>
@foreach(var node in Model.Content.DescendantsOrSelf().Where(x => x.Level == 1)) 
{
    <li><a href="@node.Url">@node.Name</a></li>
}
</ul>
```

Which just renders out: _Home, Blog, Office Locations, About Us, Contact Us_

BUT! ...  this is going to perform most horribly. This is going to iterate over every single node in Umbraco, all 10,000 of them. Further more, 
this means it is going to allocate 10,000 `IPublishedContent` instances in memory just in order to check it's `Level` value. 

This can easily be re-written as:

```
<ul>
<li><a href="@Model.Content.Url">@Model.Content.Name</a></li>
@foreach(var node in Model.Content.Children) 
{
    <li><a href="@node.Url">@node.Name</a></li>
}
</ul>
```

In many cases you might know that there is only ever going to be a small number of Descendants and if so then go nuts and use Descendants or DescendantsOrSelf, 
it's just important to be aware of the implications of what you are writing. Similarly, if you were on 

## Over querying

Querying content is not Free! Anytime you make a query or resolve a property value be aware that there is overhead involved. 
You could try to think about every query you make as an SQL call - you don't want to make too many otherwise the performance of 
your website is going to suffer.

Here's a common pitfall that is seen. Let's continue the menu example, in this example the menu is going to be rendered
using the current page's root node:

```
<ul>
<li><a href="@CurrentPage.Site().Url">@CurrentPage.Site().Name</a></li>
@foreach(var node in CurrentPage.Site().Children) 
{
    <li><a href="@node.Url">@node.Name</a></li>
}
</ul>
```

This is using Dynamics (more on that below), but what `@CurrentPage.Site()` is actually doing is:
`Model.Content.AncestorsOrSelf(1)` which means it is going to traverse up the tree until it reaches an ancestor node
with a level of one. As mentioned above, traversing costs resources and in this example there is 3x traversals being done
for the same value. Instead this can be rewritten as:

```
@{
    var site = @CurrentPage.Site();
}
<ul>
<li><a href="@site.Url">@site.Name</a></li>
@foreach(var node in site.Children) 
{
    <li><a href="@node.Url">@node.Name</a></li>
}
</ul>
```

## Dynamics

_TODO:...._

## Too much Linq - XPath is still your friend

_TODO:...._
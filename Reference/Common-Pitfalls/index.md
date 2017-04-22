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
For example, all Razor views that Umbraco creates expose an `UmbracoContext` property which is the UmbracoContext, they expose an `ApplicationContext` 
property which is Umbraco's `ApplicationContext`. The other base classes that expose all the instances you need are things like `SurfaceController`,
`UmbracoApiController`, `UmbracoController`, `RenderMvcController`, `UmbracoUserControl`, `UmbracoPage`, `UmbracoHttpHandler`, and the list goes on...

__Example of using base class properties instead of Singleton accessors:__

_This example shows how you can access all sorts of Umbraco services in a `SurfaceController` without
relying on Singletons. These same properties exist on all of Umbraco's base clases that you commonly use
including razor views._ 


    public class ContactFormSurfaceController: SurfaceController
    {
        [HttpPost]
        public ActionResult SubmitForm(ContactFormModel model)
        {        
            //TODO: All normal form processing logic is left out of this example for brevity

            //You can access all of these because they are properties of the base class,
            // notice there is no Singleton accessors used!

            //ProfilingLogger:
            using (ProfilingLogger.TraceDuration<ContactFormSurfaceController>("start", "stop"))
            {
                //Logger:
                Logger.Warn<ContactFormSurfaceController>("warning!");
                
                //MembershipHelper:
                Members.CurrentUserName;
                
                //ServiceContext:
                Services.ContentService.GetById(1234);
                
                //ApplicationContext:
                ApplicationContext.ApplicationCache.RuntimeCache.GetCacheItem("myKey", () => "hello world");
                
                //UmbracoContext:
                UmbracoContext.UrlProvider.GetUrl(4321);
                
                //DatabaseContext:
                DatabaseContext.Database.ExecuteScalar<int>("SELECT COUNT(*) FROM umbracoNode");   
            }        
        }
    }

So next time you are using `ApplicationContext.Current` or `UmbracoContext.Current` think "Why am I doing this?", 
"Is this already exposed as a property of the base class that I'm using?", "I'm using Dependency Injection, I should be injecting this instance into my class."



## Static references to web request instances (such as `UmbracoHelper`)

__Example 1:__

`private static _umbracoHelper = new UmbracoHelper(UmbracoContext.Current);`

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

    private static _umbracoContext = UmbracoContext.Current;

    //MembershipHelper is also a request scoped instance - it relies either on an UmbracoContext or an HttpContext
    private static _membershipHelper = new MembershipHelper(UmbracoContext.Current);

    private static _request = HttpContext.Current.Request;

## Querying with Descendants, DescendantsOrSelf

It's not 100% bad that you use these queries, you just need to understand the implications. 
Here's a particularly bad scenario:

You have 10,000 content items in your tree and your tree structure is something like this:

    - Root
    -- Home
    --- Blog (list view with 9495 nodes)
    --- Office Locations (list view with 500 nodes)
    --- About Us
    --- Contact Us

You create a menu on your Home page like:

    <ul>
        <li><a href="@Model.Content.Site().Url">@Model.Content.Site().Name</a></li>
        @foreach(var node in Model.Content.Site().DescendantsOrSelf().Where(x => x.Level == 2)) 
        {
            <li><a href="@node.Url">@node.Name</a></li>
        }
    </ul>


Which just renders out: _Home, Blog, Office Locations, About Us, Contact Us_

BUT! ...  this is going to perform most horribly. This is going to iterate over every single node in Umbraco, all 10,000 of them. Further more, 
this means it is going to allocate 10,000 `IPublishedContent` instances in memory just in order to check it's `Level` value. 

This can easily be re-written as:

    <ul>
        <li><a href="@Model.Content.Site().Url">@Model.Content.Site().Name</a></li>
        @foreach(var node in Model.Content.Site().Children) 
        {
            <li><a href="@node.Url">@node.Name</a></li>
        }
    </ul>

In many cases you might know that there is only ever going to be a small number of Descendants and if so then go nuts and use Descendants or DescendantsOrSelf, 
it's just important to be aware of the implications of what you are writing.  

## Too much querying (Over querying)

Querying content is not Free! Anytime you make a query or resolve a property value be aware that there is overhead involved. 
You could try to think about every query you make as an SQL call - you don't want to make too many otherwise the performance of 
your website is going to suffer.

Here's a common pitfall that is seen. Let's continue the menu example, in this example the menu is going to be rendered
using the current page's root node::

    <ul>
        <li><a href="@Model.Content.Site().Url">@Model.Content.Site().Name</a></li>
        @foreach(var node in Model.Content.Site().Children) 
        {
            <li><a href="@node.Url">@node.Name</a></li>
        }
    </ul>

The syntax `@Model.Content.Site()` is actually shorthand for doing this:
`Model.Content.AncestorsOrSelf(1)` which means it is going to traverse up the tree until it reaches an ancestor node
with a level of one. As mentioned above, traversing costs resources and in this example there is 3x traversals being done
for the same value. Instead this can be rewritten as:

    @{
        var site = @Model.Content.Site();
    }
    <ul>
        <li><a href="@site.Url">@site.Name</a></li>
        @foreach(var node in site.Children) 
        {
            <li><a href="@node.Url">@node.Name</a></li>
        }
    </ul>

## Dynamics

In Umbraco version 8+ dynamic support for access to IPublishedContent will be removed. 
There are a few reasons for this:

* Dynamics are much slower than their strongly typed equivalent
* The codebase for Dynamics is difficult to maintain and it's massive
* Many querying concepts in Dynamics are difficult to understand and need to be memorize due to all of the string syntax required
* It is much harder to debug and to know if there are errors since the syntax is not typed or compiled
* No intellisense is possible inside Visual Studio
* ModelsBuilder is part of the Umbraco Core and provides much nicer and strongly typed access to property accessors and querying in your views

How do you know if you are using Dynamics?

* If you are using `@CurrentPage` then __you are__ using dynamics
* If you are using the UmbracoHelper query methods like `@Umbraco.Content` or `@Umbraco.Media` instead of the typed methods like `@Umbraco.TypedContent` and `@Umbraco.TypedMedia` then __you are__ using dynamics

It is strongly advised that you use the strongly typed `@Model.Content` instead of `@CurrentPage` models in your views,  
this will actually perform much better and you'll be forward compatible with Umbraco v8+ with regards to querying `IPublishedContent`. 

A large problem with the performance of dynamics is having to parse string syntax such as:
`@CurrentPage.Children.Where("DocumentTypeAlias == \"DatatypesFolder\" && Visible")` and turn that into something that is compilable when 
instead it can just be written as something that compiles

__NOTE about the Query Builder:__ _We are aware that the Query Builder in the template editor of the back office currently 
uses dynamics. We will eventually replace the query logic in this dialog with strongly typed model (Models Builder) syntax to follow
these best practices. In the meantime if you are concerned about performance and have a large site then we'd recommend if you use the 
Query Builder to update it's results with strongly typed syntax._

## Using the Services layer in your views

The Services layer of Umbraco is for manipulating the business logic of Umbraco directly to/from the database. 
None of these methods should be used within your views and can have a very large impact on performance and stability of 
your application.

Your views should rely only on the readonly data access of the `UmbracoHelper` and the properties/methods that it exposes. This ensures
that the data being queried is fast (comes from cache) and that you aren't inadvertently making database changes.

__For example__ when retrieving a content item in your views:

    //Services access in your views :(
    var dontDoThis = ApplicationContext.Services.ContentService.GetById(123);

    //Content cache access in your views :)
    var doThis = Umbraco.TypedContent(123);

If you are using `Application.Services...` in your views, you should figure out why this is being done and in most cases remove this logic.   

## Using UmbracoContext to access ApplicationContext

You should not access the `ApplicationContext` via the `UmbracoContext`. 

For example: `UmbracoContext.Current.Application` _<-- this is now deprecated/obsolete_

If you need access to both the `UmbracoContext` and the `ApplicationContext`, you should do one of the following:

* Access these services via the properties exposed on the Umbraco base class you are using (i.e. Controllers, views, controls, http handler, etc...)
* or inject these services into the services you are using 
* or access each of these services from their own singleton constructs: `UmbracoContext.Current` and `ApplicationContext.Current`.

The reason why this is bad practice is because it has caused confusion and problems in the past. In some cases developers would always
access the `ApplicationContext` from the `UmbracoContext` but as we now know, this won't always work because the `UmbracoContext` is a request
scoped instances which isn't going to be available when executing code in a non-request scope (i.e. background thread).

## Using Umbraco content items for volatile data 

This is one of the worst Umbraco anti-patterns and could very well cause your site to perform ultra poorly. 

Umbraco's content should not be used for volatile data, Umbraco's APIs and the way Umbraco's data is persisted
was never designed for this. If you need to store/write/track data that changes a lot you should use a 
custom database table or another service but not Umbraco content nodes.

Some examples of what not to do are:

* Hit counters to track the number of times your page has been viewed - use something like Google Analytics for this or a custom database table
* Creating new nodes for form submissions - this should be stored in a custom database table
* Importing lots of data into Umbraco content nodes that could easily just be stored in a custom database table (i.e. it's not going to be edited).
In some cases this might be ok but many times we've seen bulk imports occur on a hourly/daily schedule which is generally unecessary.

## Processing during startup

Umbraco allows you to run some initialization code during startup by using `ApplicationEventHandler`, however great
care should be used to ensure that you are not slowing down application startup. You should be especially careful
as a Package developer that you are not slowing down application startup since your package may end up being used for
thousands of websites.

In many cases, [initialization code can be done lazily instead of eagerly](https://msdn.microsoft.com/en-us/library/dd997286(v=vs.110).aspx). 
Instead of initialization everything you need as soon as the application starts you could execute your initialization code only when it is required. 
This can be achieved in various ways such as:

* Using [`Lazy<T>`](https://msdn.microsoft.com/en-us/library/dd642331(v=vs.110).aspx) and put the initialization logic in it's callback
* Using [`LazyInitializer`](https://msdn.microsoft.com/en-us/library/system.threading.lazyinitializer%28v=vs.110%29.aspx?f=255&MSPPError=-2147217396)
* Putting logic in a property getter with a lock and setting a flag that it's processed
* Putting logic in a method with a lock and setting a flag that it's processed
* (there's plenty of ways)

Even more important is that you ensure that the initialization logic only executes one time for the lifetime of the 
application even when your app domain is restarted. If your initialization logic creates a database table or something
similar to that where it should only be executed one time only, then you should set a persistent flag (such as a file) to 
indicate to your own logic that the initialization code has already executed and doesn't need to be done again.

## Rebuilding indexes

Far too often we've seen code in people's solutions that rebuild the Examine indexes 
(we've even seen this done on every request!). Rebuilding indexes can cause severe
performance penalties and is not a recommended practice. Umbraco's and Examine's index management, index stability and 
synchronization of the data in the index gets better with every release. You should always ensure you are running the latest
Umbraco and Examine versions if you are having trouble with your index data becoming out of sync with your Umbraco data.

The primary reasons your data will become out of sync are:

* Old version of Umbraco
* Rebuilding indexes and restarting your app domain at the same time (try to avoid this scenario!)

It is not recommended to rebuild your indexes unless you absolutely need to and if you need to do this often then it is 
advised to determine why and to try to resolve the underlying problem.

## Performing lookups and logic in Examine events

There's a couple well known Examine events: `GatheringNodeData` and `DocumentWriting`. Both of these events
allow the developer to modify the data that is going into the Lucene index but many times we see developers Performing
Service lookups in these methods. For example, using `ApplicationContext.Current.Services.ContentService.GetById(e.NodeId)`
inside of these events could cause an `N + 1` problem. This is because these events are executed for every single document
being indexed and if you are rebuilding an index, this will mean this logic will fire for every single document and media item
going into each index ... That could mean a tremendous amount of lookups and performance drain. 

Similarly if you are executing other logic in these events that perform poorly, then anytime you save or publish content or media
it will slow that process down. And of course if you rebuild an index then any slow code running in these events will cause the indexing
to go ultra slow.

## RenderTemplate

There is an API in Umbraco that should never be used unless you really really know what you are doing. This API method
is called `RenderTemplate`. It allows you to be able to render a particular content item's template and get a `string` 
in response. In some cases this may be useful, perhaps you want to send an email based on a content item and it's template, but
you must be very careful not to use this for purposes it is not meant to be used for.

Generally speaking this method should not be used for the normal rendering of content. If abused this could cause severe
performance problems. For normal content rendering of module type data from another content item, you should use Partial Views instead. 

## Don't put logic inside your constructors

Constructors should generally not perform any logic, they should set some parameter values, perform some null checks and perhaps validate
some data but in most cases they should not perform any logic.

There's a few reasons why this can become a huge performance problem:

* The consumer of an API doesn't expect that by creating an object that they should be worried about performance
* Creating an object can inadvertently happen a vast number of times, expecially when using Linq

Here's an example of how this can go wrong very quickly:
Your tree structure is something like this:

    - Root
    -- Home
    --- Recipes (node id = 3251, list view with 5000 nodes)
    --- About Us
    --- Contact Us

You have a custom model that looks like:

    public class RecipeModel : PublishedContentWrapped
    {
        public RecipeModel(IPublishedContent content) : base(content)
        {
            RelatedRecipes = content 
                .Parent           
                .Children
                .Where(x => x.GetPropertyValue<IEnumerable<int>>("related")
                                .Contains(content.Id));

            Votes = content.GetPropertyValue<int>("votes");
        }

        public int Votes { get; private set; }
        public IEnumerable<RecipeModel> RelatedRecipes { get; private set; }
    }

You then run the following code to show to show the favorites 

    @var recipeNode = Umbraco.TypedContent(3251);
    <ul>
    @foreach(var recipe in recipeNode.Children
                                .Select(x => new RecipeModel(x))
                                .OrderByDescending(x => x.Votes)
                                .Take(10))
    {
        <li><a href="@recipe.Url">@recipe.Name</a></li>    
    }
    </ul>

__Ouch!__ So just to show the top 10 voted recipe's this will end up doing the following:

* This will iterate over all Recipess, create and allocate 5000 instances of `IPublishedContent`
* This will create and allocate 5000 instances of `RecipeModel`
* For each `RecipeModel` created, this will traverse upwards, iterate all 5000 recipes then resolve property data for 2 properties

This means that there is now a minimum of __20,000__ new objects created and allocated in memory. The number of traversals/visits to each
of these objects is now 5000 x 5000 = __25,000,000 (25 MILLION TIMES!)__

_Side note: The other problem is the logic used to lookup related recipes is incredibly inneficient. Instead, each reciple
should have a picker to choose it's related recipe's and then each of those can just be looked up by their ID.
(There's probably a few other ways to achieve this too!)_

Which leads us on to the next anti-pattern...

## Don't eager load data, lazy load it instead

The above example could be rewritten like this:

    public class RecipeModel : PublishedContentWrapped
    {
        public RecipeModel(IPublishedContent content) : base(content)
        {
        }

        private int? _votes;
        public int Votes 
        {
            get 
            {
                //Lazy load the property value and ensure it's not re-resolved once it's loaded
                return _votes ?? (_votes = GetPropertyValue<int>("votes"));
            } 
        }

        //Just return the Ids, they can be resolved to IPublishedContent instances in the view or elsewhere,
        // doesn't need to be in the model - this would also be bad if the model was cached since all of the
        // related entities would end up in the cache too.
        private List<int> _related;
        public IEnumerable<int> RelatedRecipes
        {
            get 
            {
                //Lazy load the property value and ensure it's not re-resolved once it's loaded            
                return _related ?? 
                    (_related = GetPropertyValue<IEnumerable<int>>("related").ToList());
            } 
        }    
    }

This is slightly better:

* This will iterate over all Recipess, create and allocate 5000 instances of `IPublishedContent`
* This will create and allocate 5000 instances of `RecipeModel`

This means that there is now a minimum of __15,000__ new objects created and allocated in memory. The number of traversals/visits to each
of these objects is now __5000__.

This is still not great though. There really isn't much reason to create a `RecipeModel` just to use it as a filter,
this is allocating a lot of objects to memory for no real reason. This could just as easily be written like:

    @var recipeNode = Umbraco.TypedContent(3251);
    <ul>
    @foreach(var recipe in recipeNode.Children
                                .OrderByDescending(x => x.GetPropertyValue<int>("votes"))
                                .Take(10))
    {
        <li><a href="@recipe.Url">@recipe.Name</a></li>    
    }
    </ul>

This is slightly better:

This means that there is now a minimum of __10,000__ new objects created and allocated in memory. The number of traversals/visits to each
of these objects is now __5000__.

## Too much Linq - XPath is still your friend 

Based on the above 2 points, you can see that just iterating content with the traversal APIs will cause new
instances of `IPublishedContent` to be created. When memory is used, Garbage Collection needs to occur and this 
turnover can cause performance problems. The more objects created, the more items allocated in memory, the harder the job
is for the Garbage Collector == more performance problems. Even worse is when you allocate tons of items in memory and/or really 
large items in memory, they will remain in memory for a long time because they'll end up in something called "Generation 3" which the 
GC tries to ignore for as long as possible because it knows it's gonna take a lot of resources to cleanup!

So if you have a huge site and are running Linq queries over tons of content, how do you avoid allocating all of these `IPublishedContent` instances? 

Instead of iterating over (and thus creating them) we can use regular old `XPath` or use the `XPathNodeIterator` directly:

* `UmbracoHelper.ContentQuery.TypedContentAtXPath`
* `UmbracoHelper.ContentQuery.TypedContentSingleAtXPath`
* `UmbracoContext.ContentCache.GetXPathNavigator`

The methods `TypedContentAtXPath` and `TypedContentSingleAtXPath` will return the resulting `IPublishedContent` instances based
on your XPath query but without creating interim `IPublishedContent` instances to perform the query against. 

These 2 methods can certainly help avoid using Linq (and as such allocating IPublishedContent instances) 
to perform almost any content filtering you want. 

## XPathNodeIterator - for when you need direct XML support

Using the `GetXPathNavigator` method is a little more advanced but can come in very handy to solve some performance problems when
dealing with a ton of content. Of course when you use this method you'll now be working directly with XML.

For example, here's how to turn the above recipe query into a much more efficient query 
without allocating any `IPublishedContent` instances:

    @{
        var recipeNode = Umbraco.TypedContent(3251);
        if (recipeNode == null) throw new NullReferenceException("No node found with ID " + 3251);
        var xPath = $"//* [@isDoc and @id='{recipeNode.Id}']/* [@isDoc]";
    }
    <ul>
    @foreach(var recipe in UmbracoContext.ContentCache.GetXPathNavigator()
                                .Select(xPath).Cast<XPathNavigator>()
                                .OrderByDescending(x =>
                                    {
                                        var vote = 0;
                                        int.TryParse(x.GetAttribute("@id", ""), out vote);
                                        return vote;
                                    })
                                .Take(10))
    {
        <li><a href="@recipe.Url">@recipe.GetAttribute("@nodeName", "")</a></li>    
    }
    </ul>

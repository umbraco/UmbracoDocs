---
versionFrom: 8.0.0
---

# UmbracoHelper

UmbracoHelper is the unified way to work with published content/media on your website. You can use the UmbracoHelper to query/traverse Umbraco published data.

UmbracoHelper also has a variety of helper methods that are useful when working in your views and controllers.

## How to reference UmbracoHelper

Nearly all of Umbraco's base classes expose an instance of UmbracoHelper. If you are using MVC Views or Partial View Macros you can reference UmbracoHelper with the syntax: `@Umbraco`

If you are using SurfaceControllers, RenderMvcControllers, UmbracoApiControllers, or any controller inheriting from UmbracoController, these all expose an UmbracoHelper via the `Umbraco` property.

For webservices and HTTP handlers, these base classes expose UmbracoHelper via the `Umbraco` property: `Umbraco.Web.WebServices.UmbracoHttpHandler`, `Umbraco.Web.WebServices.UmbracoWebService`

## IPublishedContent

UmbracoHelper will expose all content in the form of `IPublishedContent`. To get a reference to the currently executing content item from the UmbracoHelper, use `UmbracoHelper.AssignedContentItem`.

The samples below demonstrate using `UmbracoHelper` in Razor. Aside from the `@` syntax, usage is the same inside controllers or UserControls.

## Working with Content

### .Content(Guid id)

Given a node ID, returns a `IPublishedContent`

```csharp
@{
    var page = Umbraco.Content(Guid.Parse("ca4249ed-2b23-4337-b522-63cabe5587d1"));
}

<h3>@(page.Value<string>("propertyAlias"))
</h3>

@foreach (var child in page.Children) {
    <a href="@child.Url">@child.Name</a>
}
```

### .ContentAtRoot()

Returns a collection of `IPublishedContent` objects from the Content tree.

```csharp
// Get the children of the first content item found in the root
@foreach (var child in Umbraco.ContentAtRoot().First().Children) {
    <a href="@child.Url">@child.Name</a>
}
```

### .ContentAtXPath(string xpath)

Queries the cache for content matching a given XPath query and returns a collection of `IPublishedContent` objects.

```csharp
@{
    var newsArticles = Umbraco.ContentAtXPath("//newsArticle");
    var bodyText = newsArticles.First().Value("bodyText");
}
```

### .ContentSingleAtXPath(string xpath)

Queries the cache for content matching a given XPath query and returns the first match as an `IPublishedContent` object.

```csharp
@{
    var newsArticle = Umbraco.ContentSingleAtXPath("//newsArticle");
    var bodyText = newsArticle.Value("bodyText");
}
```

## Working with Media

### .Media(Guid id)

Given a node ID, returns an `IPublishedContent` Media entity

```csharp
@{
    var media = Umbraco.Media(Guid.Parse("ca4249ed-2b23-4337-b522-63cabe5587d1"));
    var image = media.Url;
    var height = media.Value<int>("umbracoHeight");
}
```

### .MediaAtRoot()

Returns a collection of `IPublishedContent` objects from the Media tree.

```csharp
@foreach (var child in Umbraco.MediaAtRoot()) {
    <img src="@child.Url" />
}
```

## Working with Tags

### .TagQuery

Gets a lazily loaded reference to the tag context to allow you to work with tags

```csharp
@{
    var tagQuery = Umbraco.TagQuery;
}
```

### .TagQuery.GetAllContentTags([string tagGroup])

Get a collection of tags used by content items on the site, you can optionally pass in a group name to only list tags belonging to a specific tag group

```csharp
@{
    var allTags = Umbraco.TagQuery.GetAllContentTags();
    var newsTags = Umbraco.TagQuery.GetAllContentTags("news");
}
```

### .TagQuery.GetAllMediaTags([string tagGroup])

Get a collection of tags used by media items on the site, you can optionally pass in a group name to only list tags belonging to a specific tag group

```csharp
@{
    var allTags = Umbraco.TagQuery.GetAllMediaTags();
    var newsTags = Umbraco.TagQuery.GetAllMediaTags("news");
}
```

### .TagQuery.GetAllMemberTags([string tagGroup])

Get a collection of tags used by members on the site, you can optionally pass in a group name to only list tags belonging to a specific tag group

```csharp
@{
    var allTags = Umbraco.TagQuery.GetAllMemberTags();
    var newsTags = Umbraco.TagQuery.GetAllMemberTags("news");
}
```

### .TagQuery.GetAllTags([string tagGroup])

Get a collection of tags used on the site, you can optionally pass in a group name to only list tags belonging to a specific tag group

```csharp
@{
    var allTags = Umbraco.TagQuery.GetAllTags();
    var newsTags = Umbraco.TagQuery.GetAllTags("news");
}
```

### .TagQuery.GetContentByTag(string tag, [string tagGroup])

Get a collection of IPublishedContent by tag, and you can optionally filter by tag group as well

```csharp
@{
    var taggedContent = Umbraco.TagQuery.GetContentByTag("News");
}
```

### .TagQuery.GetContentByTagGroup(string tagGroup)

Get a collection of IPublishedContent by tag group

```csharp
@{
    var taggedContent = Umbraco.TagQuery.GetContentByTagGroup("BlogTags");
}
```

### .TagQuery.GetMediaByTag(string tag, [string tagGroup])

Get a collection of Media by tag, and you can optionally filter by tag group as well

```csharp
@{
    var taggedContent = Umbraco.TagQuery.GetMediaByTag("BlogTags");
}
```

### .TagQuery.GetMediaByTagGroup(string tag, [string tagGroup])

Get a collection of Media by tag group

```csharp
@{
    var taggedContent = Umbraco.TagQuery.GetMediaByTagGroup("BlogTags");
}
```

### .TagQuery.GetTagsForEntity(int contentId, [string tagGroup])

Get a collection of tags by entity id (queries content, media and members), and you can optionally filter by tag group as well

```csharp
@{
    var taggedContent = Umbraco.TagQuery.GetTagsForEntity(1234);
}
```

### .TagQuery.GetTagsForProperty(int contentId, string propertyTypeAlias, [string tagGroup])

Get a collection of tags assigned to a property of an entity (queries content, media and members), and you can optionally filter by tag group as well

```csharp
@{
    var taggedContent = Umbraco.TagQuery.GetTagsForProperty(1234,"propertyTypeAlias");
}
```

## Working with Members

### .Member(1234)

Given a node ID, returns a single `IPublishedContent` Member 

```csharp
@{
    var member = Umbraco.MembershipHelper.GetById(Guid.Parse("1f46e266-9acb-4f5b-afdb-5e26c23c56e3"));
    var email = member.Value<string>("email");
}
```

### Member Helpers

### .MemberIsLoggedOn()

Returns a `Boolean` on whether there is currently a member profile

```csharp
@if(Umbraco.MemberIsLoggedOn()) {
    <h1>Welcome!</h1>
}
```

### .MemberHasAccess(string path)

Returns a `Boolean` on whether the currently logged in member has access to the page given its [Umbraco path](../IPublishedContent/Properties.md#path).

```csharp
@if (Umbraco.MemberHasAccess(Model.Path))
{
    <h1>Welcome!</h1>
}
```

### .IsProtected(string path)

Returns a `Boolean` on whether a page with a given [Umbraco path](../IPublishedContent/Properties.md#path) has public access restrictions set.

```csharp
@foreach (var child in Model.Children) {
    <h2>@child.Name</h2>
    if(Umbraco.MembershipHelper.IsProtected(child.Path)){
        <blink>Members only</blink>
    }
}
```

## Fetching miscellaneous data

### .GetDictionaryValue(string key)

Returns a dictionary value(`string`) for the key specified.

```html
<p>@Umbraco.GetDictionaryValue("createdOn"): @Model.CreateDate</p>
```

Alternatively, you can also specify an `altText` which will be returned if the dictionary value is empty.

```html
<p>@Umbraco.GetDictionaryValue("createdOn", "Date Created"): @Model.CreateDate</p>
```

### .Search(string term)

By default, Umbraco searches it's 'External' search index for any published content matching the provided search term. 

```csharp
@{
    <ul>
        @foreach (var result in Umbraco.ContentQuery.Search("ipsum"))
        {
            <li><a href="@result.Content.Url">@result.Content.Name</a></li>
        }
    </ul>
}
```

### .Search(string term, int skip, int take, out long totalRecords)

Specifying the number of records 'to skip', and the number of records 'to take' is more performant when there are lots of matching search results and there is a requirement to implement paging.

```csharp
@{
    var search = Umbraco.ContentQuery.Search("ipsum", 5, 10, out long totalRecords);
    <ul>
        <li>
            Total results: @totalRecords
            <ul>
                @foreach (var result in search)
                {
                    <li><a href="@result.Content.Url">@result.Content.Name</a></li>
                }
            </ul>
        </li>
    </ul>
}
```

### .Search(IQueryExecutor queryExecutor)

For more complex searching you can construct an Examine QueryExecutor. In the example the search will execute against content of type "blogPost" only.
[Further information on using Examine](../../Searching/Examine/Quick-Start/index.md#different-ways-to-query)

```csharp
@{
    if (!ExamineManager.Instance.TryGetIndex(Constants.UmbracoIndexes.ExternalIndexName, out IIndex index))
    {
        throw new InvalidOperationException($"No index found by name{ Constants.UmbracoIndexes.ExternalIndexName }");
    }

    var term = "ipsum";
    var query = index.GetSearcher().CreateQuery(IndexTypes.Content);
    var queryExecutor = query.NodeTypeAlias("blogPost").And().ManagedQuery(term);

    foreach (var result in Umbraco.ContentQuery.Search(queryExecutor))
    {
        {
            <li><a href="@result.Content.Url">@result.Content.Name</a></li>
        }
    }
}
```

## Templating Helpers

### .RenderMacro(string alias, object parameters)

Renders a macro in the current page content, given the macro's alias, and parameters required by the macro.

```csharp
@Umbraco.RenderMacro("navigation", new {root="1083", header="Hello"})
```

### .RenderTemplate(int contentId, int? altTemplateId)

Renders a template, as if a page with the given contentId was requested, optionally with an alternative template ID passed in.

```csharp
@Umbraco.RenderTemplate(1234)
```

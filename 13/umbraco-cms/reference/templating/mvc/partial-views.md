# Using MVC Partial Views in Umbraco

This section will show you how to use MVC Partial Views in Umbraco.&#x20;

{% hint style="warning" %}
Please note, this is documentation relating to the use of native MVC partial views, not '[Partial View Macros](../macros/partial-view-macros.md)'
{% endhint %}

## Overview

Using Partial Views in Umbraco is exactly the same as using Partial Views in a normal MVC project.

Partial views allow you to reuse components between your views (templates).

## View Locations

The locations to store Partial Views when rendering in the Umbraco pipeline is:

```
~/Views/Partials
```

The standard MVC partial view locations will also work:

```
~/Views/Shared
~/Views/Render
```

The `~/Views/Render` location is valid because the controller that performs the rendering in the Umbraco codebase is the: `Umbraco.Cms.Web.Common.Controllers.RenderController`

If however you are [Hijacking an Umbraco route](../../routing/custom-controllers.md) and specifying your own controller to do the execution, then your partial view location can also be:

```
~/Views/{YourControllerName}
```

## Example

A quick example of a content item that has a template that renders out a partial view template for each of its child documents:

The MVC template markup for the document:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@{
    Layout = null;
}

<html>
<body>
@foreach(var page in Model.Children().Where(x => x.IsVisible()))
    {
        <div>
            @Html.Partial("ChildItem", page)
        </div>
    }
</body>
</html>
```

The partial view (located at: `~/Views/Partials/ChildItem.cshtml`)

```csharp
@model IPublishedContent
<strong>@Model.Name</strong>
```

## Strongly typed Partial Views

Normally you would create a partial view by using the `@model MyModel` syntax. However, inside of Umbraco you will probably want to have access to the handy properties available on your normal Umbraco views like the Umbraco helper: `@Umbraco` and the Umbraco context: `@UmbracoContext`. The good news is that this is possible. Instead of using the `@model MyModel` syntax, you need to inherit from the correct view class, so do this instead:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<MyModel>
```

By inheriting from this view, you'll have instant access to those handy properties and have your view created with a strongly typed custom model.

Another case you might have is that you want your Partial View to be strongly typed with the same model type (`IPublishedContent`) as a normal template if you are passing around instances of IPublishedContent. To do this, have your partial view inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage` (like your normal templates). When you render your partial, a neat trick is that you can pass it an instance of `IPublishedContent`. For example:

```csharp
@foreach(var child in Model.Children())
{
    @Html.Partial("MyPartialName", child)
}
```

## Caching

You don't normally need to cache the output of Partial views, like you don't normally need to cache the output of User Controls, but there are times when this is necessary. Like macro caching, we provide caching output of partial views. This is done by using an HtmlHelper extension method:

```csharp
@await Html.CachedPartialAsync("ChildItem", page, TimeSpan.FromHours(1))
```

The above will cache the output of your partial view for one hour when not running Umbraco in `debug` mode. Additionally, there are a few optional parameters you can specify to this method. Here is the full method signature:

```csharp
Task<IHtmlContent?> CachedPartialAsync(
        this IHtmlHelper htmlHelper,
        string partialViewName,
        object model,
        TimeSpan cacheTimeout,
        bool cacheByPage = false,
        bool cacheByMember = false,
        ViewDataDictionary? viewData = null,
        Func<object, ViewDataDictionary?, string>? contextualKeyBuilder = null)
```

So you can specify to cache by member and/or by page and also specify additional view data to your partial view. \* _However_\*, if your view data is dynamic (meaning it could change per page request) the cached output will still be returned. This same principle applies if the model you are passing in is dynamic. Please be aware of this: if you have a different model or viewData for any page request, the result will be the cached result of the first execution. If this is not desired you can generate your own cache key to differentiate cache instances using the contextualKeyBuilder parameter

To create multiple versions based on one or more viewData parameters you can do something like this:

```csharp
@await Html.CachedPartialAsync("ChildItem", Model, TimeSpan.FromHours(1), true, false, new ViewDataDictionary(ViewData)
{
    { "year", Context.Request.Query["year"] }
}, (model, viewData) => viewData?["year"] + viewData?["Parameter2"]?.ToString() )
```

Or using a custom helper function:

```csharp
@functions{
    private static Func<object, ViewDataDictionary?, string>? CacheBy(params string[] keys)
    {
        return (model, viewData) => String.Join("", keys.Select(s => viewData?[s]?.ToString() ?? string.Empty));
    }
}

@await Html.CachedPartialAsync("MediaGallery", Model, TimeSpan.FromHours(1), true, false, new ViewDataDictionary(ViewData)
        {
            { "year", Context.Request.Query["year"] }
        }, CacheBy("year", "Parameter2"))
```

Or even based on a property on the Model (though if Model is the current page then `cacheByPage` should be used instead):

```csharp
 @await Html.CachedPartialAsync("MediaGallery", Model, TimeSpan.FromHours(1), true, false, new ViewDataDictionary(ViewData) { },
 (model, viewData) => (model is IPublishedContent pc ? pc.Name : null) ?? string.Empty)
```

Regardless of the complexity here the contextualKeyBuilder function needs to return a single string value.

Caching is only enabled when your application has `debug="false"`. When `debug="true"` caching is disabled. Also, the cache of all CachedPartials is emptied on Umbraco publish events.

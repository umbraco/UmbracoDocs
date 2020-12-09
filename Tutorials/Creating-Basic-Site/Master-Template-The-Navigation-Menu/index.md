---
versionFrom: 8.0.0
---
# Master Template - The Navigation Menu

Now let's fix the navigation menu - there are two ways of doing this:

1. You could have Umbraco dynamically create a navigation menu from the pages it has in the Content Tree, so that when an editor creates a page it automatically appears or,
2. You can hardcode it.

## Basic navigation

As you start building a site you might want to hard code the navigation so you can move around testing before you replace it. Edit your **_Master template_** - edit the `<li>` items under the `<nav>` tags to say:

```html
<nav id="nav">
    <ul class="links">
        <li><a href="/">Home</a></li>
        <li><a href="/contact-us">Contact Us</a></li>
        <li><a href="/articles">Articles</a></li>
    </ul>
</nav>
```

**_Save_** your changes and let's test our menu. You'll find that clicking on the Article link throws an Umbraco error as we've not created this page yet. Let's do that now.

## Dynamic navigation

If your navigation links are to be created from published content nodes you can loop through the child nodes.
As an example, this has come from the default starter kit.  

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage
@using Umbraco.Web;
@{ 
    var site = Model.Root();
    var selection = site.Children.Where(x => x.IsVisible()); <!-- see below for explanation of IsVisible helper method -->
}

<!-- uncomment this line if you want the site name to appear in the top navigation -->
<!-- <a class="nav-link @Html.Raw(Model.Id == site.Id ? "navi-link--active" : "")" href="@site.Url">@site.Name</a> -->

@foreach (var item in selection)
{
    <a class="nav-link @(item.IsAncestorOrSelf(Model) ? "nav-link--active" : null)" href="@item.Url">@item.Name</a>
}
```

:::tip
**The IsVisible() helper method**

If you add a checkbox property to a document type with an alias of `umbracoNaviHide` the `IsVisible()` helper method can be used to exclude these from being shown in any collection.
:::

---
## Next - [Articles Parent and Article Items](../Articles-Parent-and-Article-Items)
How to have a parent page that lists and links to the child nodes automatically (e.g. Articles home with infinite articles - useful for Blogs or News pages).

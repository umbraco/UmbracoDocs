# Working with MVC Views in Umbraco

_Working with MVC Views and Razor syntax in Umbraco_

## Properties available in Views

All Umbraco views inherit from `Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ContentModels.NameOfYourDocType>` along with the using statement `@using ContentModels = Umbraco.Cms.Web.Common.PublishedModels;`. This exposes many properties that are available in razor. The properties on the Document Type can be accessed in a number of ways:

* @Model (of type `Umbraco.Web.Mvc.ContentModel`) -> the model for the view which contains the standard list of IPublishedContent properties but also gives you access to the typed current page (of type whatever type you have added in the angled brackets).
* @Umbraco (of type `UmbracoHelper`) -> contains many helpful methods, from rendering fields to retrieving content based on an Id and tons of other helpful methods. [See UmbracoHelper Documentation](../../querying/umbracohelper.md)
* @Html (of type `HtmlHelper`) -> the same HtmlHelper you know and love from Microsoft but we've added a bunch of handy extension methods like @Html.BeginUmbracoForm
* @UmbracoContext (of type `Umbraco.Cms.Web.Common.UmbracoContext`)

## Rendering a field in a strongly typed view

This is probably the most used method which renders the contents of a field using the alias of the content item.

```csharp
@Model.Value("bodyContent")
```

If you're using the method from within a partial view then be aware that you will need to inherit the context so the method knows which type to get the desired value from. You'd do this at the top of partial view and so strongly typed properties can then be accessed in the partial view. For instance you can pass "HomePage" like this:

```csharp
@inherits UmbracoViewPage<HomePage>
...
@Model.Value("title")
```

You will also need to pass the "Context" to the @Model.Value() method if you're looping over a selection like this where we pass the "item" variable.

Looping over a selection works in a similar way. If you have a property that contains, for instance, an IEnumberable collection, you can access the individual items using a foreach loop. Below illustrates how you might do that using "item" as a variable.

```csharp
@{
    var collection = Model.ItemList;
}

<ul>
    @foreach(var item in collection)
    {
        <p>@item.Name</p>
    }
</ul>
```

If you want to convert a type and it's possible, you can do that by typing a variable and assigning the value from your property to it. This could look like the example below.

```csharp
@foreach (TeamMember person in Model.TeamMembers)
{
    <a href="@person.Url()">
       <p>@person.Name</p>
    </a>
}
```

In this example, we are looping through a list of items with the custom made type TeamMember assigned. This means we are able to access the strongly typed properties on the TeamMember item.

[UmbracoHelper Documentation](../../querying/umbracohelper.md)

## Accessing Member data

`IMemberManager` is the gateway to everything related to members when templating your site. [IMemberManager Documentation](../../querying/imembermanager.md)

```csharp
@using Umbraco.Cms.Core.Security;
@inject IMemberManager _memberManager;

@if(_memberManager.IsLoggedIn())
{
    <p>A Member is logged in</p>
}
else
{
    <p>No member is logged in</p>
}
```

## Models Builder

Models Builder allows you to use strongly typed models in your views. Properties created on your document types can be accessed with this syntax:

```csharp
@Model.BodyText
```

When Models Builder resolve your properties it will also try to use value converters to convert the values of your data into more convenient models. This allows you to access nested objects as strong types instead of having to rely on dynamics and risking having a lot of potential errors when working with these.

[Models Builder documentation](../modelsbuilder/)

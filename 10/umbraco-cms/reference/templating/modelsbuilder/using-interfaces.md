---


meta.Title: "Using Modelsbuilder interfaces"
description: "Using interfaces with modelsbuilder"
---

# Using Interfaces

When using compositions, Models Builder generates an interface for the composed model, which enables us to not have to switch back to using `Value()` for the composed properties.

A common use-case for this is if you have a separate composition for the "SEO properties" `Page Title` and `Page Description`.

You would usually use this composition on both your `Home` and `Textpage` document types. Since both `Home` and `Textpage` will implement the generated `ISeoProperties` interface, you will still be able to use the simpler models builder syntax (e.g. `Model.PageTitle`).

However, you won't be able to use the nice models builder syntax on any master template, since a master template needs to be bound to a generic `IPublishedContent`. So you'd have to resort to the *ever-so-slightly* clumsier `Model.Value("pageTitle")` syntax to render these properties. It is possible to solve this issue of master templating, by using partial views, to render the SEO specific properties. 

## Render with a partial

If you create a partial and change the first line to use the *interface name* for the model binding, you can use the nice Models Builder syntax when rendering the properties, like this:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<ISeoProperties>
<title>@Model.PageTitle</title>
<meta name="description" content="@Model.PageDescription">
```

You can then render the partial from your Master Template with something like this (assuming the partial is named `Metatags.cshtml`):

```csharp
<head>
    @Html.Partial("Metatags")
</head>
@RenderBody()
```

It's important to note though, that this master template will only work for content types that use the Seo Properties composition.

---
description: Templating in Umbraco including inheriting from master template
---

# Templates

_Templating in Umbraco builds on the concept of Razor Views from ASP.NET MVC - if you already know this, then you are ready to create your first template - if not, this is a quick and handy guide._

## Creating your first Template

By default, all document types should have a template attached - but in case you need an alternative template or a new one, you can create one:

Open the **Settings** section inside the Umbraco backoffice and right-click the **Templates** folder. Choose **Create**. Enter a template name and click the **Save** button. You will now see the default template markup in the backoffice template editor.

![Created template](images/create-template-v8.png)

## Allowing a Template on a Document Type

To use a template on a document, you must first allow it on the content's type. Open the Document Type you want to use the template, go to the Templates tab and select the template under the **Allowed Templates** section.

![Allowing template](images/allow-template-v8.png)

## Inheriting a Master Template

A template can inherit content from a master template by using the ASP.NET views Layout feature. Let's say we have a template called **MasterView**, containing the following HTML:

```csharp
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage
@{
    Layout = null;
}
<!DOCTYPE html>
<html lang="en">
    <body>
        <h1>Hello world</h1>
        @RenderBody()
    </body>
</html>
```

We then create a new template called **textpage** and in the template editor, click on the **Master Template** button and set its master template to the template called **MasterView**:

![Inherit template](images/inherit-template-v8.png)

This changes the `Layout`value in the template markup, so **textpage** looks like this:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage
@{
    Layout = "MasterView.cshtml";
}
<p>My content</p>
```

When a page using the textpage template renders, the final HTML will be merged replacing the `@renderBody()` placeholder, and produce the following:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage
@{
    Layout = null;
}
<!DOCTYPE html>
<html lang="en">
    <body>
        <h1>Hello world</h1>
        <p>My content</p>
    </body>
</html>
```

## Template Sections

What's good to know, is that you are not limited to a single section. Template sections allow child templates that inherit the master layout template to insert HTML code up into the main layout template. For example, a child template inserting code into the `<head>` tag of the master template.

You can do this by using [named sections](https://www.youtube.com/watch?v=lrnJwglbGUA). Add named sections to your master template with the following code:

```csharp
@RenderSection("SectionName")
```

For instance, if you want to be able to add HTML to your `<head>` tags write:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage
@{
    Layout = null;
}

<html>
    <head>
        <title>Title</title>
        @RenderSection("Head")
    </head>

    <body>
    </body>
</html>
```

By default, when rendering a named section, the section is not mandatory. To make the section mandatory, add `true` or enable **Section is mandatory** field in the **Sections** option.

```csharp
@RenderSection("Head", true)
```

![Create partial](images/render-named-sections-v10.png)

On your child page template call `@section Head {}` and then type your markup that will be pushed into the Master Template:

```csharp
@section Head {
    <style>
        body {
            background: #ff0000;
        }
    </style>
}
```

## Injecting Partial Views

Another way to reuse HTML is to use partial views - which are small reusable views that can be injected into another view.

Like templates, create a partial view, by right-clicking **Partial Views** and selecting **Create**. You can then either create an empty partial view or create a partial view from a snippet.

![Create partial](images/create-partial-v8.png)

The created partial view can now be injected into any template by using the `@Html.Partial()` method like so:

```csharp
@inherits Umbraco.Web.Mvc.UmbracoViewPage
@{
    Layout = "MasterView.cshtml";
}

<h1>My new page</h1>
@Html.Partial("a-new-view")
```

### Related Articles

* [Basic Razor syntax](basic-razor-syntax.md)
* [Rendering content](../rendering-content.md)
* [Named Sections](named-sections.md)

### Tutorials

* [Creating a basic website with Umbraco](../../../tutorials/creating-a-basic-website/)

### Umbraco Learning Base

{% embed url="https://www.youtube.com/playlist?ab_channel=UmbracoLearningBase&list=PLgX62vUaGZsFmzmm4iFKeL41CZ5YFw09z" %}
Playlist: Templates in Umbraco
{% endembed %}

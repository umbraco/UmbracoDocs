---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Preparing your Frontend

For Umbraco Forms to work correctly, you need to include some client dependencies.

## Umbraco Forms

You can use the following Razor helper to output script tags containing the dependencies. To access this method you will need a reference to `Umbraco.Forms.Web`:

```csharp
@using Umbraco.Forms.Web
<head>
    @Html.RenderUmbracoFormDependencies()
</head>
```

Alternatively, you can add the dependencies to the body tag:

```csharp
@using Umbraco.Forms.Web
...

<body>
    @Html.RenderUmbracoFormDependencies()
</body>
```

All dependencies originate from your Umbraco Forms installation, which means that no external references are needed.


## Validation Using jQuery
If you want to use jQuery as your validation framework for Umbraco Forms, you can manually add the following client dependencies without using the above Razor method:
- `jQuery` (JavaScript library)
- `jQuery validate` (jQuery plugin that provides client-side Form validation)
- `jQuery validate unobtrusive` (Add-on to jQuery Validation that provides unobtrusive validation via data-* attributes)

The easiest way to add the dependencies is to fetch them from a [CDN](https://en.wikipedia.org/wiki/Content_delivery_network). There are various CDN services you can use:

- For example: [Microsoft CDN](https://docs.microsoft.com/en-us/aspnet/ajax/cdn/overview).
- Other CDN services you might want to look at are https://www.jsdelivr.com/ and https://cdnjs.com/about, which may offer better performance and more reliable service.

To add the three client dependencies, see the examples below:

**Example within `head` tags.**

```html
<head>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.16.0/jquery.validate.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/mvc/5.2.3/jquery.validate.unobtrusive.min.js"></script>
</head>
```

**Example within `body` tags.**

When adding the script to the bottom of the page, you will also need to render the scripts. For more information, see [Rendering From Scripts](../Rendering-Scripts/index.md) article.

```html
<body>
    <!-- Page content here -->

    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.16.0/jquery.validate.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/mvc/5.2.3/jquery.validate.unobtrusive.min.js"></script>
</body>
```

---

Prev: [Developer Documentation](../index.md) &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Rendering Forms Scripts](../Rendering-Scripts/index.md)

---
versionFrom: 7.0.0
---

# Preparing your frontend

In order for Umbraco Forms to work correctly, you need to include some client dependencies.

In Umbraco Forms v.8.5.0+ you can use the following Razor method to output script tags containing the dependencies:

```html
<head>
    @Html.RenderUmbracoFormDependencies()
</head>
```

For older version of Umbraco Forms you should go for the jQuery option, please read the 'use jQuery' section below.

All dependencies originate from your Umbraco Forms installation, which means that no external references are needed.

If you'd like to use jQuery instead, you can manually add them without using the above Razor method. Follow the instructions in the 'Use jQuery' section below to learn more.


## Use jQuery

If you'd like to use jQuery as your validation framework for Umbraco Forms you will need to manually include three client dependencies:

- `jQuery` (JavaScript library)
- `jQuery validate` (jQuery plugin that provides client side form validation)
- `jQuery validate unobtrusive` (Add-on to jQuery Validation that provides unobtrusive validation via data-* attributes)

The easiest way to add the dependencies is to fetch them from a [CDN](https://en.wikipedia.org/wiki/Content_delivery_network). There are various CDN services you can use, we've included references for [Microsoft CDN](https://docs.microsoft.com/en-us/aspnet/ajax/cdn/overview). Other CDN services you might want to look at including are https://www.jsdelivr.com/ and https://cdnjs.com/about, which may offer better performance and more reliable service.

Here's how to add the three (3) client dependencies below to your template within the head tags or at the bottom of the page.

**Example within `head` tags.**

```html
<head>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.16.0/jquery.validate.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/mvc/5.2.3/jquery.validate.unobtrusive.min.js"></script>
</head>
```

**Example before closing `body` tag**

When adding the script to the bottom of the page, you'll also need to perform an extra step — have a look at [this page](../Rendering-Scripts/index.md) for instructions.

```html
<body>
    <!-- Page content here -->

    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.0.0.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery.validate/1.16.0/jquery.validate.min.js"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/mvc/5.2.3/jquery.validate.unobtrusive.min.js"></script>
</body>
```

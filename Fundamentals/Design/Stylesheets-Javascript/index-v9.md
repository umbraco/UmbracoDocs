---
versionFrom: 9.0.0
meta.Title: "Working with stylesheets and JavaScript in Umbraco"
meta.Description: "Information on working with stylesheets and JavaScript in Umbraco, including bundling & minification"
verified-against: rc-02
state: complete
updated-links: true
---

# Working with stylesheets and JavaScript

## Stylesheets in the Backoffice

You can create and edit stylesheets in the Stylesheets folder in the Settings section of the Backoffice.

![Creating a new stylesheet](images/1-creating-stylesheet.png)

In the Create menu, there are several options available:

* Stylesheet file (for use in templates/views)
* Rich Text Editor stylesheet file (for use in [Rich Text Editor](../../Backoffice/Property-Editors/Built-in-Property-Editors/Rich-Text-Editor/index-v9.md))
* Folder (for keeping stylesheets organized)

:::note
It is currently not possible to use any CSS preprocessor (such as SASS) in the backoffice.
:::

After creating a new stylesheet, you would work with it as you would with templates or javascript files - using the built-in backoffice text editor.
When you're working with stylesheets, you also have access to the Rich Text Editor, which allows you to create CSS styles and get a real-time preview.

![Stylesheet RTE](images/2-rte-editor.png)

The rules you create in the Rich Text Editor section will carry over to the Code tab.

![Stylesheet RTE tab](images/3-rte-editor-p2.png)
![Stylesheet Code tab](images/3-rte-editor-p3.png)

To reference your newly included stylesheet in a template file, navigate to Templates, pick the template you like (css files are usually referenced in the layout or home templates) and link to it with the `link` tag.

![Linking CSS in template](images/4-link-css-v9.png)

By default, the stylesheets will be saved in the `wwwroot/css` folder in the solution.
To reference them you can use either of the methods used in the above screenshot.

```html
<link rel="stylesheet" href='@Url.Content("~/css/mystylesheet.css")' />
```
or
```html
<link rel="stylesheet" href="/css/mystylesheet.css" />
```

With the stylesheet referenced, you will be able to style the template file with the rules and classes defined in the stylesheet.

Your stylesheets can be used in Rich Text Editors (datatype) as well - please see the [Rich Text Editor](../../Backoffice/Property-Editors/Built-in-Property-Editors/Rich-Text-Editor/RTE-Styles/index.md) documentation for more information.

:::note
If your RTE is styled differently on the frontend of the site, the backoffice styling might be getting overwritten by other stylesheets you have included.
:::

## JavaScript files in the Backoffice

To create and edit JavaScript files in the Backoffice, head on over to the Scripts folder in the Settings section of the Backoffice.

![Creating a new JavaScript](images/8-create-js.png)

From here you can add a new JavaScript file, or a new folder.

Add a new JavaScript file and write your code:

![Sample JS script](images/9-myscript.png)

Then, navigate to the template where you would like to include your JS file.

```html
<script src="/scripts/myScript.js"></script>
```

![Reference the script in template](images/10-reference-script-v9.png)

By default all JavaScript files will be stored in the `wwwroot/scripts` folder in the solution.

:::tip
If you are working locally, you can create CSS and JS files outside of the Backoffice - long as they are placed in appropiate folders (`css` and `scripts`), they will show up in the Backoffice.
:::

## Bundling & Minification for JavaScript and CSS

You can use whichever tool you are comfortable with for bundling & minification by implementing the `IRuntimeMinifier` interface in your custom minifier class, though it is worth noting that Umbraco 9 ships with Smidge which offers lightweight runtime bundling and minification.

You can create various bundles of your site's CSS or JavaScript files in your code that can be rendered later in your views. There can be a single bundle for the entire site, or a common bundle for the files you want to be loaded on every page, as well as page-specific bundles, just by listing your resources in the order you like.
```csharp
_runtimeMinifier.CreateJsBundle("inline-js-bundle",
                    BundlingOptions.NotOptimizedAndComposite,
                    new[] { "~/scripts/myScript1.js", "~/scripts/myScript2.js" });

_runtimeMinifier.CreateCssBundle("inline-css-bundle",
                    BundlingOptions.NotOptimizedAndComposite,
                    new[] { "~/css/mystylesheet.css" });

```

Then, you can simply render bundles by the bundle name in a view template file:

```csharp
<html>
<head>
    <script src="inline-js-bundle" type="text/javascript"></script>
    <link rel="stylesheet" href="inline-css-bundle"/>
</head>
</html>
```

Or by using our `IRuntimeMinifier`:

```csharp
@inject IRuntimeMinifier runtimeMinifier

<html>
<head>
    @Html.Raw(await runtimeMinifier.RenderJsHereAsync("inline-js-bundle"))
    @Html.Raw(await runtimeMinifier.RenderCssHereAsync("inline-css-bundle"))
</head>
</html>
```

Another possibility is to declare bundles inline in your views using Smidge directly:

```csharp
@using Smidge
@{
    SmidgeHelper
        .CreateJsBundle("inline-js-bundle")
        .RequiresJs("~/scripts/myScript1.js", "~/scripts/myScript2.js");

    SmidgeHelper
        .CreateCssBundle("inline-css-bundle")
        .RequiresCss("~/css/mystylesheet.css");
}
<html>
<head>
    @await SmidgeHelper.JsHereAsync("inline-js-bundle")
    @await SmidgeHelper.CssHereAsync("inline-css-bundle")
</head>
</html>
```

Full details about Smidge can be found here: [https://github.com/Shazwazza/Smidge](https://github.com/Shazwazza/Smidge)
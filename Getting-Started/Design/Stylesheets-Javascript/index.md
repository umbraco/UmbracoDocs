---
meta.Title: "Working with stylesheets and JavaScript in Umbraco"
meta.Description: "Information on working with stylesheets and JavaScript in Umbraco, including bundling & minification"
versionFrom: 7.0.0
---

# Working with stylesheets and JavaScript

## Bundling & Minification for JavaScript and CSS

You can use whichever tools you are comfortable with for bundling & minification but it's worth noting that Umbraco ships with the ClientDependency Framework which offers runtime bundling & minification.

You can bundle and minify as follows in a view template file.

```csharp
@using ClientDependency.Core.Mvc
@using ClientDependency.Core
@{
    Html.RequiresJs("~/scripts/Script1.js", 1);
    Html.RequiresJs("~/scripts/Script2.js", 2);

    Html.RequiresCss("~/css/style.css");
}
<html>
<head>
    @Html.RenderCssHere()
    @Html.RenderJsHere()
</head>
```

Full details of the ClientDependency Framework can be found here: [https://github.com/Shandem/ClientDependency](https://github.com/Shandem/ClientDependency)

# Render grid in template

## Using @Html.GetGridHtml

To render a property based on the grid inside a template you should use the HtmlHelper extension:

```csharp
@Html.GetGridHtml(Model, "propertyAlias")
```

This will render the grid item with alias "propertyAlias" from the current page models' content.

This will by default use the view `/views/partials/grid/bootstrap3.cshtml` you can also use other provided grid template rendering files - for example the built-in bootstrap2.cshtml view by overloading this helper:

```csharp
@Html.GetGridHtml(Model, "propertyAlias", "bootstrap3")
```

You can create your own custom grid rendering files e.g for your favourite or custom grid framework implementation. Tip: copy one of the existing files as a starting point. By convention, if you create your "mycustomrenderer.cshtml" file in `/views/partials/grid` you can render the grid property like so:

```csharp
@Html.GetGridHtml(Model, "propertyAlias", "mycustomrenderer")
```

or alternatively you can provide the path to where the file resides:

```csharp
@Html.GetGridHtml(Model, "propertyAlias", "/views/mycustomrenderer.cshtml")
```

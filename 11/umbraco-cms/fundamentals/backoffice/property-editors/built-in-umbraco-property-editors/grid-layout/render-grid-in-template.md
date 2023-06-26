# Render grid in a template

## Using @Html.GetGridHtml

To render a property based on the grid inside a template you should use the HtmlHelper extension:

```csharp
@Html.GetGridHtml(Model, "propertyAlias")
```

This will render the grid item with the alias "propertyAlias" from the current page models' content.

This will by default use the view `/views/partials/grid/bootstrap3.cshtml` you can also use other provided grid template rendering files - for example, the built-in bootstrap2.cshtml view by overloading this helper:

```csharp
@Html.GetGridHtml(Model, "propertyAlias", "bootstrap3")
```

You can create your own custom grid rendering file for your favorite or custom grid framework implementation. Tip: copy one of the existing files as a starting point. By convention, if you create your `mycustomrenderer.cshtml` file in `/views/partials/grid` you can render the grid property like so:

```csharp
@Html.GetGridHtml(Model, "propertyAlias", "mycustomrenderer")
```

Possible paths where you can add the custom Grid layout views:

```none
/Views/grid/mycustomrenderer.cshtml
/Views/Shared/grid/mycustomrenderer.cshtml
/Views/Partials/grid/mycustomrenderer.cshtml
/Views/MacroPartials/grid/mycustomrenderer.cshtml
/Views/Render/grid/mycustomrenderer.cshtml
/Views/Shared/grid/mycustomrenderer.cshtml
/Pages/Shared/grid/mycustomrenderer.cshtml
```

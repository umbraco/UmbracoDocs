#Render grid in template
To render a property based on the grid inside a template you should use the HtmlHelper extension:

    @Html.GetGridHtml(Model.Content, "propertyAlias")

This will render the grid item with alias "propertyAlias" from the current page models' content.

This will by default use the view `/views/partials/grid/bootstrap3.cshtml` you can also use other provided grid template rendering files - for example the built-in bootstrap2.cshtml view by overloading this helper: 

    @Html.GetGridHtml(Model.Content, "propertyAlias", "bootstrap2")

You can create your own custom grid rendering files (eg for your favourite or custom grid framework implementation - tip: copy one of the existing files as a starting point)
 by convention if you create your "mycustomrenderer.cshtml" file in `/views/partials/grid` you can render the grid property like so:

    @Html.GetGridHtml(Model.Content, "propertyAlias", "mycustomrenderer")

or alternatively you can provide the path to where the file resides:

    @Html.GetGridHtml(Model.Content, "propertyAlias", "/views/mycustomrenderer.cshtml")

Finally the Html.GetGridHtml helpers are the recommended approach for rendering grid properties in templates, however you may see in grid examples or discover in your existing site 'legacy code' when using the 'dynamic' CurrentPage approach for working with Umbraco templates and grid properties:
   
    @CurrentPage.GetGridHtml(Html, "propertyAlias")
    @CurrentPage.GetGridHtml(Html, "propertyAlias", "bootstrap2")
    @CurrentPage.GetGridHtml(Html, "propertyAlias", "mycustomrenderer")
    @CurrentPage.GetGridHtml(Html, "propertyAlias", "/views/mycustomrenderer.cshtml")

and similarly 

    @Model.Content.GetGridHtml(Html, "propertyAlias")

These approaches are considered obsolete. Use @Html.GetGridHtml.
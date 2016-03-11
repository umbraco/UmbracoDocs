#Render grid in template
To display the grid on a site use using dynamics, you'd should do:

    @CurrentPage.GetGridHtml(Html, "propertyAlias")


This will by default use the view `/views/partials/grid/bootstrap3.cshtml` you can also use the built-in bootstrap2.cshtml view by overloading the method: 

    @CurrentPage.GetGridHtml(Html, "propertyAlias", "bootstrap2")

or point it a custom view, which by default looks in `/views/partials/grid/` - or provide the method with a full path 

    @CurrentPage.GetGridHtml(Html, "propertyAlias", "mycustomview")
    @CurrentPage.GetGridHtml(Html, "propertyAlias", "/views/mycustomfile.cshtml")

If using strongly typed models it's better to use the HtmlHelper extensions, and replace `@CurrentPage` with `@Model.Content` like:

    @Html.GetGridHtml(Model.Content, "propertyAlias")


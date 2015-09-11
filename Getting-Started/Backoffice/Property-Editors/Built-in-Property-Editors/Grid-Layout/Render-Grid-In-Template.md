#Render grid in template
To display the grid on a site use:

    @CurrentPage.GetGridHtml("propertyAlias")

This will by default use the view `/views/partials/grid/bootstrap3.cshtml` you can also use the built-in bootstrap2.cshtml view by overloading the method: 

    @CurrentPage.GetGridHtml("propertyAlias", "bootstrap2")

or point it a custom view, which by default looks in `/views/partials/grid/` - or provide the method with a full path 

    @CurrentPage.GetGridHtml("propertyAlias", "mycustomview")
    @CurrentPage.GetGridHtml("propertyAlias", "/views/mycustomfile.cshtml")

If you're working with a strongly typed model simply replace `@CurrentPage` with `@Model.Content`, so:

    @Model.Content.GetGridHtml("propertyAlias")


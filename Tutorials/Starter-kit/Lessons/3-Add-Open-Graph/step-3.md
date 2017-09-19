# Add Open Graph - Step 3
Next step is to actually get the Open Graph code rendered on the website. This is done in the `head` section of the html, so you need to find the template for this. In the `Starter Kit` the head is placed in the Master template, which is responsible for wrapping all the other templates. Because you've added the Open Graph feature as a composition you can check if the composition is present on the current page and then render meta tags.

1. Go to the Settings section and expand the Template tree.
2. Select the Master template
3. Find the *head* html tags of the template
4. Write the following at bottom of the *head*:

    @if(Model.Content is IOpenGraph){ 
        @Html.Partial("openGraph")
    }

This will render a partial view *if* the composition is present on the current page which will be the case for Home and blog posts on the site. `IOpenGraph` is an interface created by adding the composition, if you know how that works you can see how powerful this is. If not, just enjoy the handy helper to check for the composition.

At the end the head should look like this

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <title>@Model.Content.Name - @home.Sitename</title>
        <meta name="description" content="">
        <meta name="author" content="">
        
        <link rel="stylesheet" href="@Url.Content("~/css/umbraco-starterkit-style.css")" />
        @RenderSection("Header", required: false)
        @if (Model.Content is IOpenGraph) { @Html.Partial("openGraph") }
    </head>

[Previous](step-2.md) - [Next](step-4.md)
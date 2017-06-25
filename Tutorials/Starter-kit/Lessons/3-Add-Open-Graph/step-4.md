# Add Open Graph - Step 4
The final piece to the puzzle is adding the partial view that will be rendered when the compositions is present. To do this:

1. Go to the settings section
2. Right click on *Partial Views* choose create *New Empty partial view*

The partial view comes with a standard view model `@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
` which can be fine but as we are using compositions and only render this view on pages where the composition exists you can get a little more specific.

3. In the template editor, change the view model from `UmbracoTemplatePage` to `UmbracoViewPage` and pass in the specific model you've created by adding `<IOpenGraph>`. Now you can start rendering the meta tags and adding in the values.
4. First add the tittle property `<meta property="og:title" content="" />`
5. Set the cursor in the content attribute and click the *Insert+* button.
6. Select Value
7. Under *Choose field*, select the `openGraphTitle` property.
8. Add a *Fallback field*, select `siteName`, making sure that even though the Open Graph title isn't filled in, it will fallback to the title of the site (defined on Home)
9. Check *Make this recursive* to ensure the fallback will work on all pages.
10. Add the Open Graph meta tag for type of content, you can hardcode website in here <meta property="og:type" content="website" />
11. Next up is adding the url for Open Graph. For this you'll need the entire url to page, not just relative to this page. There is a handy method for getting this from a content item. Add: <meta property="og:url" content="@Model.UrlAbsolute()" />
12. The final thing we need to do is render the image selected on the Open Graph Image property. You'll still need to render the entire Url for the image. It's a little different than for the content url. Add: <meta property="og:image" content="@Url.GetAbsoluteMediaUrl(Model.OpenGraphImage)" />
13 Your partial view is now complete and should only render on pages that are using the Open Graph composition. The final view should look like this:

    ```
    @inherits Umbraco.Web.Mvc.UmbracoViewPage<IOpenGraph>

    <meta property="og:title" content="@Umbraco.Field("openGraphTitle", altFieldAlias:"sitename", recursive: true)" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="@Model.UrlAbsolute()" />
    <meta property="og:image" content="@Url.GetAbsoluteMediaUrl(Model.OpenGraphImage)" />
    ```
    
[Previous](step-1.md) - [Next](summary.md)
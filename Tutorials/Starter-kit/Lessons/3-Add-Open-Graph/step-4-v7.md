---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Add Open Graph - Step 4

The final piece to the puzzle is adding the partial view that will be rendered when the composition is present. To do this:

1. Go to the Settings section

2. Right-click on *Partial Views* and choose *Create* > *New empty partial view*

The partial view comes with a standard view model `@inherits Umbraco.Web.Mvc.UmbracoTemplatePage` but because we are using compositions and only render this view on pages where the composition exists, we can get a little more specific.

3. In the template editor, change the view model from `UmbracoTemplatePage` to `UmbracoViewPage` and pass in the specific model you've created by adding `<IOpenGraph>`.
    * Now you can start rendering the meta tags and adding in the values.
4. First add the title property

    ```html
    `<meta property="og:title" content="" />`
    ```

5. Set the cursor in the content attribute and click the *+ Insert* button.
6. Select **Value**
7. Under *Choose field*, select the `openGraphTitle` property.
8. Add a *Fallback field*, select `siteName`, making sure that even though the Open Graph title isn't filled in, it will fallback to the title of the site (defined on Home)
9. Check *Yes, make it recursive* to ensure the fallback will work on all pages.
10. Add the Open Graph meta tag for type of content - you can hardcode "website" in here:

    ```html
    <meta property="og:type" content="website" />
    ```

11. Next up is adding the URL for Open Graph.
    * For this you'll need the entire URL to the page, not relative to this page.
    * There is a handy method for getting this from a content item. Add:

    ```html
    <meta property="og:url" content="@Model.UrlAbsolute()" />
    ```

12. The final thing we need to do is render the image selected on the Open Graph Image property.
    * You'll still need to render the entire URL for the image.
    * It's a little different than for the content URL. Add:

    ```html
    <meta property="og:image" content="@Url.GetAbsoluteMediaUrl(Model.OpenGraphImage)" />
    ```

13. Your partial view is now complete and should only render on pages that are using the Open Graph composition.

The final view should look like this:

```html
@inherits Umbraco.Web.Mvc.UmbracoViewPage<IOpenGraph>

<meta property="og:title" content="@Umbraco.Field("openGraphTitle", altFieldAlias:"sitename", recursive: true)" />
<meta property="og:type" content="website" />
<meta property="og:url" content="@Model.UrlAbsolute()" />
<meta property="og:image" content="@Url.GetAbsoluteMediaUrl(Model.OpenGraphImage)" />
```

:::note
If you do not have Starter Kit installed, or experience issues with the properties not being picked up/showing up in HTML feel free to remove the fallback to siteName.

If your meta properties do not show up on social media, make sure to inspect source HMTL and make sure there are no inline HTML tags in `og:title`, `og:description` etc.
:::

**Pro tip:** In order to keep the lesson short and to the point, we have left out `null`-checks from the code examples. So remember to fill in the Open Graph properties, in the content section, to avoid exceptions when viewing the page.

[Previous](step-3-v7.md) - [Next](summary-v7.md)

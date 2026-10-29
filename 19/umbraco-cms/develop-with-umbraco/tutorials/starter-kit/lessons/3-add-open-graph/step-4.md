# Add Open Graph - Step 4

The final piece to the puzzle is adding the partial view that will be rendered when the composition is present. To do this:

1. Go to the **Settings** section.

2. Click on **Partial Views** and select **Create...** > **New empty partial view**.
3. **Enter a Name** for the partial view. Let's call it: _OpenGraph_
3. Add the standard view model: `@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage`
    * We only render this view on pages where the composition exists, so we need to be more specific.
4. In the template editor, pass in the specific model you've created by adding `<IOpenGraph>` after the view model.
    * Now you can start rendering the meta tags and adding in the values.
5. First add the title property

    ```html
    <meta property="og:title" content="@Model.OpenGraphTitle" />
    ```

6. Add the Open Graph meta tag for type of content - you can hardcode "website" in here:

    ```html
    <meta property="og:type" content="website" />
    ```

7. Next up is adding the URL for Open Graph.
    * For this you'll need the entire URL to the page, not relative to this page.
    * There is a handy method for getting this from a content item. Add:

    ```html
    <meta property="og:url" content="@Model.Url(mode: UrlMode.Absolute)" />
    ```

8. The final thing we need to do is render the image selected on the Open Graph Image property.
    * You'll still need to render the entire URL for the image.
    * First, we'll create a variable to get the image:

    ```csharp
    @{
        var ogImage = Model.Value<IPublishedContent>("openGraphImage");
    }
    ```

    * Next, we add the `meta` property to get the path for the media item:

    ```html
    <meta property="og:image" content="@ogImage.Url(mode: UrlMode.Absolute)" />
    ```

9. Your partial view is now complete and should only render on pages that are using the Open Graph composition.

The final view should look like this:

```html
@inherits Umbraco.Cms.Web.Common.Views.UmbracoViewPage<IOpenGraph>

@{
    var ogImage = Model.Value<IPublishedContent>("openGraphImage");
}

<meta property="og:title" content="@Model.OpenGraphTitle" />
<meta property="og:type" content="website" />
<meta property="og:url" content="@Model.Url(mode: UrlMode.Absolute)" />
<meta property="og:image" content="@ogImage.Url(mode: UrlMode.Absolute)" />
```

{% hint style="info" %}
If your meta properties do not show up on social media, make sure to inspect source HTML. Make sure there are no inline HTML tags in `og:title`, `og:description` etc.
{% endhint %}

**Pro tip:** To keep the lesson short and to the point, we have left out `null`-checks from the code examples. So remember to fill in the Open Graph properties, in the content section, to avoid exceptions when viewing the page.

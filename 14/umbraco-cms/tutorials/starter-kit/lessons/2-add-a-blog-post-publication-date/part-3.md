# Add a Blog Post Publication Date

In [Part Two](part-2.md), we displayed a nicely formatted publication date on the blog post page.

Finally, in Part Three we shall change the blog listing.

## Steps - Part Three

1. In the **Settings** section, expand the **Partial Views** > **Components** > **LatestBlogPosts** folder.

    * Select *Default.cshtml*.

2. Scroll down to find the `foreach` loop.
3. Declare a new `publicationDate` variable as the first thing within the loop:

    ```csharp
    var publicationDate = post.Value<DateTime>("publicationDate");
    ```

4. Locate the `blogpost-date` element a bit further down and change it to use the new variable:

    ```html
    <small class="blogpost-date">@publicationDate.ToLongDateString()</small>
    ```

    * The ToLongDateString() method is called on the `publicationDate` variable to format it as a long date string.

5. Redefine the `blogposts` variable before the first `div` tag - this will be used for sorting the posts:

    ```csharp
    @{
        var blogposts = Model.BlogPosts.OrderByDescending(x => x.Value<DateTime>("publicationDate")).ToList();
    }
    ```

    * Because we are sorting by a custom property we need to use the generic `Value` method.

{% hint style="info" %}
You can use **Query builder** to construct your queries in a more structured and reusable manner. Use the `UmbracoHelper` or the `IPublishedContentQuery` interface to build queries dynamically. For more information, see the [Querying & Models](https://docs.umbraco.com/umbraco-cms/reference/querying) article.
{% endhint %}

6. Locate the `@foreach` loop, and change `Model.Blostposts` to the variable created above: `blogposts`:

    ```csharp
    @foreach (IPublishedContent post in blogposts)
    ```

7. **Save** the partial view - a confirmation message should appear confirming that the Partial view has been saved.

Now view both the Blog overview and the blog posts themselves in the browser to confirm that all is working as expected.

## Summary

Nice job! In this lesson, you've learned what a **Document Type** is and how to add a new Property to it. You've also learned how to change Templates and sort by custom Properties.

<details>

<summary>See the entire file: Default.cshtml</summary>

{% code title="Default.cshtml" lineNumbers="true" %}
```csharp
@using Umbraco.Cms.Core.Models.PublishedContent
@using Umbraco.Extensions
@model Umbraco.SampleSite.Models.LatestBlogPostsViewModel;
@{
    var blogposts = Model.BlogPosts.OrderByDescending(x => x.Value<DateTime>("publicationDate")).ToList();
}
<div class="blogposts">
    @foreach (IPublishedContent post in blogposts)
    {
        var publicationDate = post.Value<DateTime>("publicationDate");
        <a href="@post.Url()" class="blogpost">
            <div class="blogpost-meta">
                <small class="blogpost-date">@publicationDate.ToLongDateString()</small>
                <small class="blogpost-cat">
                    @await Html.PartialAsync("~/Views/Partials/CategoryLinks.cshtml", post.Value<IEnumerable<string>>("categories"))
                </small>
            </div>
            <h3 class="blogpost-title">@post.Value("pageTitle")</h3>
            <div class="blogpost-excerpt">@post.Value("excerpt")</div>
        </a>
    }
    @if (Model.BlogPosts.Count() < Model.Total)
    {
        <div class="pagination">
            <nav class="nav-bar nav-bar--center">
                @if (Model.Page <= 1)
                {
                    <span class="nav-link nav-link--black nav-link--disabled">Prev</span>
                }
                else
                {
                    <a class="nav-link nav-link--black" href="@(Model.Url + "?page=" + (Model.Page - 1))">Prev</a>
                }
                @for (int i = 1; i <= Model.PageCount; i++)
                {
                    <a class="nav-link nav-link--black @(Model.Page == i ? " nav-link--active" : null)" href="@(Model.Url + "?page=" + i)">@i</a>
                }
                @if (Model.Page == Model.PageCount)
                {
                    <span class="nav-link nav-link--black nav-link--disabled">Next</span>
                }
                else
                {
                    <a class="nav-link nav-link--black" href="@(Model.Url + "?page=" + (Model.Page + 1))">Next</a>
                }
            </nav>
        </div>
    }
</div>
```
{% endcode %}

</details>

[Back to Lessons](../README.md)

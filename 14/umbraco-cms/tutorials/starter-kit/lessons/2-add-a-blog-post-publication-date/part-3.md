# Add a Blog Post Publication Date

In [Part Two](part-2.md), we displayed a nicely formatted publication date on the blog post page.

Finally, in Part Three we shall change the blog listing.

## Steps - Part Three

1. In the **Settings** section, expand the **Partial Views** > **Components** > **LatestBlogPosts** folder.

    * Select *Default.cshtml*.

2. Scroll down to find the `foreach` loop.
3. Declare a new `publicationDate` variable as the first thing with the loop:

    ```csharp
    var publicationDate = post.Value<DateTime>("publicationDate");
    ```

4. Locate the `blogpost-date` element a bit further down and change it to use the new variable:

    ```html
    <small class="blogpost-date">@publicationDate.ToLongDateString()</small>
    ```

    * The `ToLongDateString()` method ensures a clean looking date format.

5. Redefine the `blogposts` variable before the first `div` tag - this will be used for sorting the posts:

    ```csharp
    @{
        var blogposts = Model.BlogPosts.OrderByDescending(x => x.Value<DateTime>("publicationDate")).ToList();
    }
    ```

    * Because we are sorting by a custom property we need to use the generic `Value` method.
6. Locate the `@foreach` loop, and change `Model.Blostposts` to the variable created above: `blogposts`:

    ```csharp
    @foreach (IPublishedContent post in blogposts)
    ```

7. *Save* the partial view - a confirmation message should appear confirming that the Partial view has been saved.
8. Now view both the Blog overview and the blog posts themselves in the browser to confirm that all is working as expected.

## Summary

Nice job! In this lesson, you've learned what a **Document Type** is and how to add a new Property to it. You've also learned how to change Templates and sort by custom Properties.

[Back to Lessons](../README.md)

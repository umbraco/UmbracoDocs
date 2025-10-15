---


---

# Add a Blog Post Publication Date

In [Part Two](part-2.md), we displayed a nicely formatted publication date on the blog post page.

Finally, in Part Three we shall change the blog listing.

## Steps - Part Three

1. In the **Settings** section, expand **Partial View Macro Files**.

    * Select *LatestBlogPosts.cshtml*.
    * **Macros** are beyond the scope of this lesson, but you don't need to understand them right now.

2. Scroll down to find the `blogpost-date` element and change it to use a nicely formatted Publication Date, i.e.:

    ```html
    <small class="blogpost-date">@post.PublicationDate.ToLongDateString()</small>
    ```

3. Further up in the view, you also need to redefine the `blogposts` variable:

    ```csharp
    var blogposts = startNode.Children.OrderByDescending(x => x.Value<DateTime>("PublicationDate")).ToList();
    ```

    * Because we are sorting by a custom property we need to use the generic `Value` method.

4. *Save* the partial view - a confirmation message should appear confirming that the Partial view has been saved.
5. Now view both the Blog overview and the blog posts themselves in the browser to confirm that all is working as expected.

## Summary

Nice job! In this lesson, you've learned what a **Document Type** is and how to add a new Property to it. You've also learned how to change Templates and sort by custom Properties.

[Back to Lessons](../README.md)

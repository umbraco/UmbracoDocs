# Add a Blog Post Publication Date

In [Part One](./) we added a new property to the _Blogpost_ Document Type. Now in Part Two, we're going to display that instead of the default creation date.

## Steps - Part Two

1. Find the blog posts on the _Blog_ in the **Content** section.
2. Add publication dates to the blog posts.
   * Remember to publish your changes!
   * As this field is flagged as Mandatory you now can't save a post without it.
3. Go to the **Settings** section
4. Expand **Templates**, and _Master_, then click on _Blogpost_.
   * This is the template that is rendering the full page view of a blog post
5.  Find the element with the `blogpost-date` class and change it to use a nicely formatted Publication Date, i.e.:

    ```html
    <small class="blogpost-date">@Model.PublicationDate.ToLongDateString()</small>
    ```
6. _Save_ the Template - a confirmation message should appear confirming that the Template was saved.
7. View the blog post page in the browser (find the page in the Content tree, then select the link on the Info tab).

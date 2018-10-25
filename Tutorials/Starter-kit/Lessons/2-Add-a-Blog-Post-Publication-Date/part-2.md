# Add a Blog Post Publication Date

In [Part One](./) we added a new property to the *Blogpost* Document Type.
Now in Part Two we're going to display that instead of the creation date.

## Steps - Part Two
1. Edit the blog posts (click on *Blog* in the **Content** section to display the list) and add publication dates. Remember to publish your changes!  As this field is flagged as Mandatory you now can't save a post without it.
2. Go to the **Settings** section
3. Expand **Templates**, and *Master*, then click on *Blogpost*: this is the template that is rendering the full page view of a blog post
4. Find the element with the class `blogpost-date` and change it to use a nicely formatted Publication Date, i.e.:
```
<small class="blogpost-date">@Model.Content.PublicationDate.ToLongDateString()</small>
```
5. Click Save.  A confirmation message should appear confirming that the Template was saved. 
6. View the blog post page in the browser (remember... an easy way to do that is to find the page in the Content tree, then click Link to document on the Property tab).

[Proceed to Part Three](part-3.md)

# Add a Blog Post Publication Date

In [Part Two](part-2.md) we displayed a nicely formatted publication date on the blog post page.
Finally in Part Three we shall change the blog listing.

## Steps - Part Three
1. In the **Developer** section, expand **Partial View Macro Files**.  **Macros** are beyond the scope of this lesson, but you don't need to understand them right now.  You just need to know that the file used on both the home page and the blog is called *LatestBlogPosts.cshtml*.  So click on that.
2. Scroll down to find the `blogpost-date` element and change it to use a nicely formatted Publication Date, i.e.:
```
<small class="blogpost-date">@post.PublicationDate.ToLongDateString()</small>
```
3. Scroll further back up the page to where we get the blog posts (as the **Children** of this page).  Change this to:
```
var blogposts = startNode.Children.OrderByDescending(x => x.GetPropertyValue<DateTime>("PublicationDate")).ToList();
```
Because we are sorting by a custom property we need to use the generic GetPropertyValue method.
4. Then click *Save*. A confirmation message should appear confirming that the Partial view has saved.  
5. Now view both the home and the blog pages and in the browser to confirm that all is working as expected.

## Summary
Nice job! In this lesson you've learned what a **Document Type** is and how to add a new Property to a document type, and how to change templates and sort by custom Properties.

[Back to Lessons](../index.md)

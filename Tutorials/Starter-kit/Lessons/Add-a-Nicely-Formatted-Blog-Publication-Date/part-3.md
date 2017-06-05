# Add a Nicely Formatted Blog Publication Date

Now we should update all the listings of blogs to use the Publication Date if it exists.
[Back to Part Two](part-2.md)

## Steps - Part Three
1. There is a list of blog posts on the home page, and on the blog page.  Both pages use the same template, so there is only one file to update.
2. In the **Developer** section, expand **Partial View Macro Files**.  **Macros** are beyond the scope of this lesson, but you don't need to understand them to do what we need to.
3. Click on *latestBlogPosts.cshtml*.
4. Scroll down to find the `blogpost-date` element and change it as before to be:
```
<small class="blogpost-date">@Umbraco.Field("publicationDate", altFieldAlias:"createDate", formatAsDate: true)</small>
```
5. Then click *Save*. A confirmation message should appear confirming that the Partial view has saved.  
6. Now reload the home page in the browser and, there, doesn't that look better!

## Why Not...
* Try creating a **Custom List View** for the Blog to display the Publication Date [docs until lesson link?]
* Learn about **Macros** [docs until lesson link?]

## Summary
Nice job! In this lesson you've learned what a **Document Type** is [more info], how to add a new Property to a document type, how to use Umbraco Helper methods, and how to sort by a custom property.

[Back to Lessons](../index.md)

# Add a Nicely Formatted Blog Publication Date

In Part Two you need to add a Publication Date to at least one blog post, and render that in preference to its creation date.
[Back to Part One](part-1.md)

## Steps - Part Two
1. Expand *Home* in the Content section, and click on *Blog* to display a list of the current blog posts
2. Click on one of the posts in the list and select a Publication Date
3. Publish the changes
4. Go to the **Settings** section
5. Expland **Templates**, and *Master*, then click on *Blogpost*: this is the template that is rendering the full page view of a blog post
6. Find the element with the class `blogpost-date` and remove its contents
7. With your cursor inside this element click the Insert button, and select Value
8. Choose the field publicationDate in the Custom Fields list (*publicationDate* is the alias that was generated for you for the new property)
9. Click the **Add fallback link** and select **createDate** in the Standard Fields section.
10. As we want our date displayed in a nicer format, in the **Format as date** section select **Date only**.  This means dates will be displayed as Monday, June 5, 2017.
11. Click the **Insert** button at the bottom. Your `blogpost-date` element should now look like:
```
<small class="blogpost-date">@Umbraco.Field("publicationDate", altFieldAlias:"createDate", formatAsDate: true)</small>
```
12. View the blog post page in the browser (remember, an easy way to do that is to find the page in the Content tree, and click Link to document on its Property tab)

Nearly there! [Proceed to Part Three](part-3.md)
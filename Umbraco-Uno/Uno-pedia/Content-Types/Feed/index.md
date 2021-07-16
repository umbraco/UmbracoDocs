---
versionFrom: 8.0.0
---

# Feed

Many websites requires a new section or a blog or sometimes even both. With Umbraco Uno that can be achieved used the **Feed** content type. Once a Feed has been setup, **Posts** can be created as child elements or subpages - these could be anything from blogposts to news articles.

Below is an example of a feed page with a Hero widget and a feed with 3 posts.

![Example of the Feed page](images/feed-sample.png)

Besides being a feed-archive for posts, the Feed content type also has a Content tab with a set of groups similar to the ones found on the Site and the Page content type:

* Content group for adding widgets (these will appear before the feed)
* [SEO](../../Settings/Specific-Settings/#seo)
* [Settings](../../Settings/Specific-Settings/#settings)

## Post

The Post content type is used to create the subpages/posts in a feed.

To create a post using the Post content type, a Feed must already be setup. With that in place, posts can be created from the *Child Items* tab on the feed.

![Create posts from the Child items tab on the feed content item](images/child-items-tab.png)

Posts are created through the Feed content type, using the "Create post" feature on the Child items tab.

The Post content type provides the following groups of options:

* [Content](#content)
* [Meta](#meta)
* [SEO](../../Settings/Specific-Settings/#seo)
* [Settings](../../Settings/Specific-Settings/#settings)

### Content

When creating a new post, the first thing that needs to be filled in is the fields in the Content group. The fields in the group make out the entire blogpost or news item.

#### Pre Heading and Heading

While the *Pre Heading* is optional, the *Heading* is mandatory. The Heading will be the title shown along with the post whenever the feed is listed on the frontend.

#### Intro Text and Image

Both of these fields are optional and will be shown before the actual content of the post. The image will be shown in full-width.

#### Text

This field is where the main contents of the post needs to go. The Text field uses a Rich Text Editor, which enables the use of images, links, lists and other text formatting options.

There is also a set of already defined formats for headers, quotes and other text elements. These are explained in more detail in the [Rich Text Editor](../../../Creating-Content/Rich-Text-Editors) article.

### Meta

The Meta group presents a few options for adding meta data to the post.

This includes setting a publish date for the post. If a date is not defined it will default to 01-01-0001. The date will be below the post Heading on the post itself and when feed is listed on the frontend.

:::note
When using "Scheduled Publishing" on posts, the *Date* field will **not** update automatically, and will still need to be manually set to the correct date.
:::

Also in this group if an *Image* field and *Description* field. Whichever is added to these two fields, will be used to present the post when the feed is listed on the frontend.

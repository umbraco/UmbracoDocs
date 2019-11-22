---
versionFrom: 7.0.0
---
# Master Template - The Navigation Menu


Now let's fix the navigation menu. There are two ways of doing this.

1. You could have Umbraco dynamically create a navigation menu from the pages it has in the Content Tree (*Hint: see the list child pages macro we create later..*). Whenever an editor creates a page it automatically appears or,
* You can hardcode it.

We're going to hardcode this for now. It's a good idea as you start building a site to hard code this so you can move around testing before you replace this. We'll leave it to you as an exercise to do this later. Edit your **_Master template_** - edit the `<li>` items under the `<nav>` tags to say:

```html
<nav>
    <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/contact-us">Contact Us</a></li>
        <li><a href="/articles">Articles</a></li>
    </ul>
</nav>
```

*Figure 34 - Master Template - Menu / Nav Section*


**_Save_** your changes and let's test our menu. You'll find that clicking on the Article link throws an Umbraco error as we've not created this page yet. Let's do that now.

---
## Next - [Articles Parent and Article Items](../Articles-Parent-and-Article-Items/index-v7.md)
How to have a parent page that lists and links to the child nodes automatically (e.g. Articles home with infinite articles - useful for Blogs or News pages).

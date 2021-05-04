---
versionFrom: 8.0.0
---
# Master Template - The Navigation Menu

You can fix the navigation menu in two ways:

1. [Dynamically](#dynamic-navigation) - Umbraco creates a navigation menu from the pages in the Content Tree, so when you create a page it automatically appears.
2. [Hardcode](#hardcode-navigation) it.

## Dynamic Navigation

To create dynamic navigation links from published content nodes, use the following code:

```csharp
@using Umbraco.Web;

	<!-- Navigation -->
	<nav class = "nav-bar top-nav">
            <a class = "nav-link" href = "/"> Home </a>
            @foreach (var child in Model.Root().Children())
            {
                <a class = "nav-link" href = "@child.Url">@child.Name</a>
            }
        </nav>
```

## Hardcode Navigation

To add a basic hardcoded navigation, follow these steps:

1. Go to **Settings**.
2. In the **Templating** section, select **Templates** and open the **Master** template.
3. Edit the `<li>` items under the `<nav>` tags to look like:
    
    ```html
    <nav id="nav">
        <ul class="links">
            <li><a href="/">Home</a></li>
            <li><a href="/contact-us">Contact Us</a></li>
            <li><a href="/articles">Articles</a></li>
        </ul>
    </nav>
    ```
4. Click **Save**.

Let's test the menu. You'll find that clicking on the Articles link throws an Umbraco error as we've not created this page yet. We'll create the Articles page in the next chapter.

---

Prev: [Creating Master Template Part 2](../Creating-Master-Template-Part-2)  &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Articles Parent and Article Items](../Articles-Parent-and-Article-Items)
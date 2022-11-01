---
versionFrom: 8.0.0
---
# Setting the Navigation Menu

You can fix the navigation menu in two ways:

1. [Dynamically](#dynamic-navigation) - Umbraco creates a navigation menu from the pages in the Content Tree, so when you create a page it automatically appears in the navigation menu. Using dynamic navigation, you do not need to manually add or change your menu items if the page changes.
2. [Hardcode](#hardcode-navigation) it - You can hardcode the navigation menu but they would require more upkeep in the future if you  want to remove a page or change its name.

## Dynamic Navigation

To create dynamic navigation links from published content nodes, follow these steps:

1. Go to **Settings**.
2. Select **Templates** from the **Templating** section, and open the **Master** template.
3. Go to the `<!-- Navigation -->` tag (around line 20) and use the following code:

    ```csharp
    @inherits Umbraco.Web.Mvc.UmbracoViewPage
    @using Umbraco.Web;
    @{ 
        var site = Model.Root();
        var selection = site.Children.Where(x => x.IsVisible()); <!-- see below for explanation of IsVisible helper method -->
    }

    <!-- uncomment this line if you want the site name to appear in the top navigation -->
    <!-- <a class="nav-link @Html.Raw(Model.Id == site.Id ? "navi-link--active" : "")" href="@site.Url">@site.Name</a> -->

    @foreach (var item in selection)
    {
        <a class="nav-link @(item.IsAncestorOrSelf(Model) ? "nav-link--active" : null)" href="@item.Url">@item.Name</a>
    }
    ```
4. Click **Save**.

## Hardcode Navigation

To add a basic hardcoded navigation, follow these steps:

1. Go to **Settings**.
2. Select **Templates** from the **Templating** section, and open the **Master** template.
3. Go to the `<!-- Navigation -->` tag (around line 20) and update your code to look like:

    ```html
    <div class="container">
		<nav class="navbar navbar-expand navbar-light">
			<a class="navbar-brand font-weight-bold" href="/">Umbraco TV</a>
				<!-- Links -->
				<ul class="navbar-nav">
					<li class="nav-item">
					    <a class="nav-link" href="/contact-us">Contact Us</a>
					</li>
					<li class="nav-item">
					    <a class="nav-link" href="/articles">Articles</a>
                    </li>
				</ul>
		</nav>
	</div>
    ```

4. Click **Save**.

:::tip The IsVisible() helper method

If you add a checkbox property to a Document Type with an alias of umbracoNaviHide, the IsVisible() helper method can be used to exclude these from being shown in any collection.
:::

Let's test the menu. You'll find that clicking on the Articles link throws an Umbraco error as we've not created this page yet. We'll create the Articles page in the next chapter.

---

Prev: [Creating Master Template Part 2](../Creating-Master-Template-Part-2)  &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; &emsp; Next: [Articles Parent and Article Items](../Articles-Parent-and-Article-Items)

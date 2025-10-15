---


---
# Setting the Navigation Menu

You can fix the navigation menu in two ways:

1. [Dynamically](#dynamic-navigation) - Umbraco creates a navigation menu from the pages in the Content Tree, so when you create a page it automatically appears in the navigation menu. Using dynamic navigation, you do not need to manually add or change your menu items if the page changes.
2. [Hardcode](#hardcode-navigation) it - You can hardcode the navigation menu but they would require more upkeep in the future if you  want to remove a page or change its name.

## Dynamic Navigation

To create dynamic navigation links from published content nodes, follow these steps:

1. Go to **Settings**.
2. Select **Templates** from the **Templating** section, and open the **Master** template.
3. Locate the `<!-- Navigation -->` tag (around line 22).
4. Right below it, place the cursor on an empty line.
5. Select **Query builder...** in the top-right side of the editor.
6. Make sure it is set to say *"I want all content from my website"*.
7. Click **Submit**.

You now have the following snippet in your **Master** Template:

```csharp
@{
	var selection = Umbraco.ContentAtRoot().FirstOrDefault()
    .Children()
    .Where(x => x.IsVisible());
}
<ul>
	@foreach (var item in selection)
	{
		<li>
			<a href="@item.Url()">@item.Name()</a>
		</li>
	}
</ul>
```

This snippet will now need to be merged with the navigation above it.

The `<ul>` tag needs to be wrapped inside the `<div class="container">` and `<nav>` tags, and the classes need to be added to the correct tags as well.

The final result will look like this:

```csharp
    @{
        var selection = Umbraco.ContentAtRoot().FirstOrDefault()
        .Children()
        .Where(x => x.IsVisible());
    }
    <!-- Navigation -->
    <div class="container">
        <nav class="navbar navbar-expand navbar-light">
            <a class="navbar-brand font-weight-bold" href="index.html">UmbracoTV</a>
            <!-- Links -->
        <ul class="navbar-nav">
            @foreach (var item in selection)
            {
                <li class="nav-item">
                    <a href="@item.Url()" class="nav-link" >@item.Name()</a>
                </li>
            }
        </ul>

        </nav>
    </div>
```

The final step is to **Save** the **Master** template.

## Hardcode Navigation

To add a basic hardcoded navigation, follow these steps:

1. Go to **Settings**.
2. Select **Templates** from the **Templating** section, and open the **Master** template.
3. Go to the `<!-- Navigation -->` tag (around line 22), copy the content within the <div> tags (around line 23 to 45) and replace it with the following code:

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

{% hint style="info" %} 
The IsVisible() helper method

If you add a checkbox property to a Document Type with an alias of umbracoNaviHide, the IsVisible() helper method can be used to exclude these from being shown in any collection.
{% endhint %}

Let's test the menu. You'll find that clicking on the Articles link throws an Umbraco error as we've not created this page yet. We'll create the Articles page in the next chapter.

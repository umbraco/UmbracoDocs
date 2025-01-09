# Setting the Navigation Menu

You can set up the navigation menu in two ways:

* [Dynamically](setting-the-navigation-menu.md#dynamic-navigation): Umbraco can automatically generate a navigation menu based on the pages in the Content Tree. When you create or modify a page, it will automatically appear in the navigation menu. This dynamic approach eliminates the need to manually add or update menu items when pages are added, removed, or renamed.
* [Hardcoded](setting-the-navigation-menu.md#hardcode-navigation): Alternatively, you can hardcode the navigation menu. However, this approach requires more maintenance, as any changes to the pages—such as adding, removing, or renaming—would need to be manually reflected in the menu.

## Dynamic Navigation

To create dynamic navigation links from the published content nodes, follow these steps:

1. Go to **Settings**.
2. Expand the **Templates** folder from the **Templating** section.
3. Open the **Master** template.
4. Locate the `<!-- Navigation -->` tag (around line 20).
5. Right below it, place the cursor on an empty line.
6. Select **Query builder...** in the top-right side of the editor.
7. Make sure it is set to say "I want **all content** from **my website**".
8. Click **Submit**.

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

This snippet needs to be merged with the navigation above it.

9. Wrap the `<ul>` tag inside the `<div class="container">` and `<nav>` tags.

The final result will look like this:

```csharp
@{
var selection = Umbraco.ContentAtRoot().FirstOrDefault()
	.Children()
	.Where(x => x.IsVisible());
}
<div class="container">
	<nav class="navbar navbar-expand navbar-light">
		<a class="navbar-brand font-weight-bold" href="/">UmbracoTV</a>
		<!-- Links -->
		<ul class="navbar-nav">
			@foreach (var item in selection)
			{
				<li class="nav-item">
					<a href="@item.Url()" class="nav-link">@item.Name()</a>
				</li>
			}
		</ul>
	</nav>
</div>
```

10. Click **Save**.

## Hardcode Navigation

To add a basic hardcoded navigation, follow these steps:

1. Go to **Settings**.
2. Expand the **Templates** folder from the **Templating** section.
3. Open the **Master** template.
4. Go to the `<!-- Navigation -->` tag (around line 20).
5. Copy the content within the `<div>` tags (around line 21 to 43) and replace it with the following code:

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

6. Click **Save**.

{% hint style="info" %}
The IsVisible() helper method

If you add a checkbox property to a Document Type with an alias of umbracoNaviHide, the IsVisible() helper method can be used to exclude these from being shown in any collection.
{% endhint %}

Let's test the menu. You'll find that clicking on the Articles link throws an Umbraco error as we've not created this page yet. We'll create the Articles page in the next chapter.

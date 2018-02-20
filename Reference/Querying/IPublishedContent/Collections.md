# IPublishedContent Collections

All collections of `IPublishedContent` are `IEnumerable<IPublishedContent>`. 
This means that all c# Linq statements can be used to filter and query the collections.  

## Collections

### .Children
Returns a collection of items just below the current content item

	<ul>
		@foreach(var item in Model.Content.Children)
		{
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>


### .Ancestors
Returns all ancestors of the current page (parent page, grandparent and so on)

	<ul>
		@*Order items by their Level*@
		@foreach(var item in Model.Content.Ancestors().OrderBy(x => x.Level))
		{
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>

### .Ancestor
Returns the first ancestor of the current page

	@* return the first ancestor item from the current page *@
	var nodes = Model.Content.Ancestor();
	
	@* return the first item, of a specific type, from the current page *@
	var nodes = Model.Content.Ancestor<DocumentTypeAlias>();


<span id="ancestorsorself"></span>
### .AncestorsOrSelf
Returns a collection of all ancestors of the current page (parent page, grandparent and so on), and the current page itself

	@* Get the top item in the content tree, this will always be the Last ancestor found *@
	var websiteRoot = Model.Content.AncestorsOrSelf().Last();

### .Descendants
Returns all descendants of the current page (children, grandchildren etc)

	<ul>
		@* Filter collection by content that has a template assigned *@
		@foreach(var item in Model.Content.Descendants().Where(x = x.TemplateId > 0))
		{
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>

### .DescendantsOrSelf
Returns all descendants of the current page (children, grandchildren etc), and the current page itself

	<ul>
		@* Filter collection by content that has a template assigned *@
		@foreach(var item in Model.Content.DescendantsOrSelf().Where(x = x.TemplateId > 0))
		{
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>

### .OfTypes
Filters a collection of content by content type alias 

	<ul>
		@* Filter collection by content type alias (you can pass in any number of aliases) *@
		@foreach(var item in Model.Content.DescendantsOrSelf().OfTypes("widget1", "widget2"))
		{
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>

-----

## Filtering, Ordering & Extensions

Filtering and Ordering are done simply with Linq.

Some examples:
	
### .Where

	@* Returns all items in the collection that have a template assigned and have a name starting with 'S' *@
	var nodes = Model.Content.Descendants().Where(x => x.TemplateId > 0 && x.Name.StartsWith("S"))

### .OrderBy

	@* Orders a collection by the property name "title" *@
	var nodes = Model.Content.Children.OrderBy(x => x.GetPropertyValue<string>("title"))
	
### .GroupBy
Groups collection by content type alias

	@{
	  	var groupedItems = Model.Content.Descendants().GroupBy(x => x.DocumentTypeAlias);
	  	foreach (var group in groupedItems)
	  	{
	   		<h2>@group.Key</h2>
	   		foreach(var item in group)
	   		{
	   			<h3>@item.Name</h3>
	   		}
	   	}
	}


### .Take(int)
Return only the number of items for a collection specified by the integer value.
	
	@* return the first 3 items from the child collection *@
	var nodes = Model.Content.Children.Take(3);

### .Skip(int)
Return items from the collection after skipping the specified number of items.

	@* Skip the first 3 items in the collection and return the rest *@
	var nodes = Model.Content.Children.Skip(3);

**HINT:** You can combine Skip and Take when using for paging operations

	@* using skip and take together you can perform paging operations *@
	var nodes = Model.Content.Skip(10).Take(10);

### .Count()
Returns the number of items in the collection

	int numberOfChildren =  Model.Content.Children.Count();

### .Any()
Returns a boolean True/False value determined by whether there are any items in the collection

	bool hasChildren =  Model.Content.Children.Any();
	
## [Filtering Conventions](#filtering-conventions)
Some filtering and routing behaviour is dependant upon a set of special naming conventions for certain properties. [See also: Routing Property Conventions](../../Routing/routing-properties.md)

### .IsVisible()
If you create a checkbox property on a document type with an alias *umbracoNaviHide* then the value of this property is used by the *IsVisible()* extension method when filtering.

   	IEnumerable<IPublishedContent> sectionPages =  Model.Content.Children.Where(x => x.IsVisible());

Use case: When displaying a navigation menu for a section of the site, following this convention gives editors the option to 'hide' certain pages from appearing in the section navigation. (hence the unusual *umbracoNaviHide* property alias!)



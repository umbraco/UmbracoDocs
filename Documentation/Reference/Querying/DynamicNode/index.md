#DynamicNode
DynamicNode is the dynamic access to all the data stored in your Umbraco website. Also know as the Model of your site.
Model represents the page, currently being rendered, and is usually referenced on Templates or Macros

DynamicNode is a dynamic object, this gives us a number of obvious benefits, mostly a much lighter syntax for 
accessing data, as well as dynamic queries, based on the names of your DocumentTypes and their properties, but at the same time, it does not provide intellisense.


##Get started
To access the current page in your Razor macros or templates, copy-paste the below Razor code.

	@{
		var pageName = Model.Name;
		var childPages = Model.Children;
	}
	
	<h1>@pageName</h1>

##Properties
Built-in properties, which exists on all dynamic content objects by default. These are referenced in Razor as a standard property
`object.Property` using standard C syntax. 

	@* gets the current page Url *@
	@Model.Url
	
	@* gets the Creation date, and formats it to a short date *@
	@Model.CreateDate.ToString("D")
	
	@* Outputs the name of the parent if it exists *@
	@if(Model.Parent != null){
		<h1>@Model.Parent.Name</h1>
	}

###.Parent
Returns a dynamic object, referencing the parent of the current page. If current page is at the top of the site tree, null will be returned

###.Id
Returns the unique Id for the current content item

###.Template
Returns the Template object used by this content item.

###.SortOrder
Returns the index the page is on, compared to its siblings

###.Name
Returns the Name of the current content item

###.Visible
Returns the navigational visibility of the current item if the umbracoNaviHide property is used

###.Url
Returns the complete Url to the page

###.UrlName
Returns the Url encoded name of the page

###.NodeTypeAlias
Returns the Alias of the Document type used by this content item.

###.WriterName
Returns the name of the Umbraco back office user that perfomed the last update operation on the content item.

###.CreatorName
Returns the name of the Umbraco back office user that initially created the content item.

###.WriterId
Returns the Id of the Umbraco back office user that performed the the last update operation to the content item.

###.CreatorId
Returns the Id of the Umbraco back office user that initially created the content item.

###.Path
Returns a comma delimited string of Node Ids that represent the path of content items back to root.

###.CreateDate
Returns the DateTime the page was created

###.UpdateDate
Returns the DateTime the page was modified

###.NiceUrl
Same as Url

###.Level
Returns the Level this content item is on

###.PropertiesAsList()
Returns a `new List<IProperty>()` of the user defined properties for a content item.  an `IProperty` has two `string` properties `.Alias` and `.Value`

###.ChildrenAsList
Returns the children of the current item as a `List<>()`


-----

##Custom properties
All content and media items also contains a reference to all the data defined by their document type
	
###Model.PropertyAlias
Returns the property matching the PropertyAlias (replace with alias of property) 

	@*Get the property with alias: "siteName" from the current page  *@
	@Model.siteName
	
	@*Notice razor uses Pascal casing, there is therefore an OverLoad to get propeties as pascal cased as well*@
	@Model.SiteName
		

**Notice**, that Razor uses Pascal casing (capitalize first letter) for properties.
Property `bodyText` can therefore be referenced as `BodyText`


###Model._propertyAlias
Returns the property matching the propertyAlias (replace with alias of property) 
by prefixing with '_' razor will first look on the current page. If no value is defined, it will then search ancestor pages for a property matching the alias, and return a value, if a property is found.

	@* Get the "siteName" property recursively (if not present on current page, traverse 
	through page ancestors, 
	Notice this matches alias casing, but prefixes a _ char *@
	@Model._siteName
	
**Notice**, this matches the exact casing for the property.
Property `bodyText` is therefore referenced as `_bodyText`

----

##Collections
All collections returned by Model are of type DynamicContentList, which itself has a collection of properties.

###.[DocumentTypeAlias]s (Pluralised Collections)
Returns the children of the current page, matching the Document type alias

**Get all children of type with alias: 'textPage'**

	@var collection = Model.TextPages
	
**Get the first child page of type with alias: 'homePage'**

	@var page = Model.HomePages.First()


###.Children
Returns a collection of items just below the current content item

	<ul>
		@foreach(var item in Model.Children){
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>


###.Ancestors
Returns all ancestors of the current page (parent page, grandparent and so on)

	<ul>
		@*Order items by their Level*@
		@foreach(var item in Model.Ancestors.OrderBy("Level")){
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>
<span id="ancestorsorself"></span>
###.AncestorsOrSelf
Returns a collection of all ancestors of the current page (parent page, grandparent and so on), and the current page itself

	@* Get the top item in the content tree, this will always be the Last ancestor found *@
	var websiteRoot = Model.AncestorsOrSelf.Last();


###.Descendants
Returns all descendants of the current page (children, grandchildren etc)

	<ul>
		@* Filter collection by the document type alias *@
		@foreach(var item in Model.Descendants.Where("NodeTypeAlias = @0", "newsItem")){
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>

###.DescendantsOrSelf
Returns all descendants of the current page (children, grandchildren etc), and the current page itself

	<ul>
		@* Filter collection by the document type alias *@
		@foreach(var item in Model.DescendantsOrSelf.Where("NodeTypeAlias = @0", "newsItem")){
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>


###.XPath(string XPath)
Returns a collection of items that match the XPath expression specified.

	@* select all the newsitems that have more than 0 pictures attached *@
	@foreach(var item in @Model.XPath("//NewsItem[count(.//Pictures) > 0]"))
	{
    		@item.Name
	}

###.GetChildrenAsList
Returns a `DynamicNodeList` of `DynamicNode` of the child content items

-----

##Traversing

###.Parent
Returns a dynamic object, referencing the parent of the current page. If current page is at the top of the site tree, null will be returned.

###.First()
Returns the first item in a specified collection.

	@var NewsArea = Model.NewsAreas.First();	


###.Last()
Returns the last item in a specified collection.

	@var root =Model.AncestorsOrSelf.Last();

###.Up([int])
Returns a parent item up the tree by one level or by the value specified in the optional parameter. default value = 0, or 1 level. For example to move up two levels set the optional parameter to 1.

	@var parent = Model.Up();
	@var parentsParent = Model.Up(1);

###.Down([int])
Returns a child item down the tree by one level or by the value specified in the optional parameter. default value = 0, or 1 level. For example to move down two levels set the optional parameter to 1.

	@var firstChild = Model.Down();
	@var firstChildsFirstChild = Model.Down(1);

###.Next([int])
Returns the next sibling item in the tree by one position or by the value specified in the optional parameter. default value = 0, or 1 level. For example to move two positions set the optional parameter to 1.

	@var nextSibling = Model.Next();
	@var anotherSibling = Model.Next(1);

###.Previous([int])
Returns the previous sibling item in the tree by one position or by the value specified in the optional parameter. default value = 0, or 1 level. For example to move two positions set the optional parameter to 1.

	@var previousSibling = Model.Previous();
	@var anotherSibling = Model.Previous(1);

###.AncestorOrSelf()
The AncestorOrSelf() method has a number of overloads that allow you to quickly traverse the tree and return an item that matches the overloaded criteria.
Using the menthod without any parameters will return the top most node in tree that you are currently navigating.

**Notice** `.AncestorOrSelf()` should not be confused with the collection [`.AncestorsOrSelf()`](#ancestorsorself)

	@var root = Model.AncestorOrSelf();

<table>
	<tr>
		<th>Overload Option</th><th>Description</th>
	</tr>
	<tr>
		<td>.AncestorOrSelf()</td>
		<td>Returns the root item from the current tree</td>
	</tr>
	<tr>
		<td>.AncestorOrSelf((int)level)</td>
		<td>Returns the item from the Ancestors collection at the specified level</td>
	</tr>
	<tr>
		<td>.AncestorOrSelf((string)nodeTypeAlias)</td>
		<td>Returns the item from the Ancestors collection with the specified nodeTypeAlias</td>
	</tr>
</table>

**Examples**

	@* get the root item of the current tree *@
	@var root = Model.AncestorOrSelf();
	
	@* get the item at level 2 *@
	@var level2Item = Model.AncestorOrSelf(2);
	
	@* get item with nodeTypeAlias "HomePage" *@
	@var home = Model.AncestorOrSelf("HomePage");

-----

##Filtering, Ordering & Extensions
	
###.Where("condition"[, valueIfTrue, valueIfFalse] )
Returns all items matching the given condition.
For more details on queries and conditions, see the section below

	@var ancestors = Model.Where("UmbracoNaviHide != @0", "True");
	
	@var HomePage = Model.Where("NodeTypeAlias == @0 && Level == @1 || Name = @2", "HomePage", 0, "Home").First();

###.OrderBy("fieldname [desc][,propertyAlias")
Orders a collection by a field name
	
	@* order by name *@
	@var nodes = Model.Children.OrderBy("Name");
	
	@* order by descending name *@
	@var nodes = Model.Children.OrderBy("Name desc");
	
###.GroupBy("propertyAlias")
Groups items in the collection based on a content property that is used as a key and returns a Collection of Anonymous objects that have two properties. `.Key` and `.Elements` that contains a collection of the content items for that grouping.

	@{
	  	var groupedItems = Model.Children.GroupBy("MyProperty");
	  	foreach (var group in groupedItems)
	  	{
	   		<h2>@group.Key</h2>
	   		foreach(var item in group.Elements)
	   		{
	   			<h3>@el.Name</h3>
	   		}
	   	}
	}


###.InGroupsOf([int])
Returns a collection as a collection of collections. The integer value specifies the size of the groups.

	@* return in groups of 3 *@
	@foreach(var group in Model.Children.InGroupsOf(3)){
		<div class="row">
			@foreach(var item in group){
				<div>@item.Name</div>
			}
		</div>
	}

###.Pluck("PropertyName")
Returns a collection of type `new List<string>()` of only the specified property and not the entire content item.

	@* return only the colour property as a List<string>(); *@
	@Model.Children.Pluck("colour");


###.Take(int)
Return only the number of items for a collection specified by the integer value.
	
	@* return the first 3 items from the child collection *@
	@var nodes = Model.Children.Take(3);

###.Skip(int)
Return items from the collection after skipping the specified number of items.

	@* Skip the first 3 items in the collection and return the rest *@
	@var nodes = Model.Children.Skip(3);

**HINT:** You can combine Skip and Take when using for paging operations

	@* using skip and take together you can perform paging operations *@
	@var nodes = Model.Skip(10).Take(10);

###.Count()
Returns the number of items in the collection

	@int numberOfChildren =  Model.Children.Count();
	
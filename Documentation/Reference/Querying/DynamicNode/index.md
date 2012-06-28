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

###.CreatorName

###.WriterId

###.CreatorId

###.Path

###.CreateDate
Returns the DateTime the page was created

###.UpdateDate
Returns the DateTime the page was modified

###.Version

###.NiceUrl
Same as Url

###.Level
Returns the Level this content item is on

###.PropertiesAsList

###.ChildrenAsList

###.Position

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

###.AncestorsOrSelf
Returns all ancestors of the current page (parent page, grandparent and so on), and the current page itself

	@* Get the top item in the content tree, this will always be the Last ancestor found *@
	var websiteRoot = Model.AncestorsOrSelf.Last();


###.Descendants
Returns all descendants of the current page (children, grandchildren etc)

	<ul>
		@*Filter collection by the document type alias*@
		@foreach(var item in Model.Descendants.Where("NodeTypeAlias = @0", "newsItem")){
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>

###.DescendantsOrSelf
Returns all descendants of the current page (children, grandchildren etc), and the current page itself

	<ul>
		@*Filter collection by the document type alias*@
		@foreach(var item in Model.DescendantsOrSelf.Where("NodeTypeAlias = @0", "newsItem")){
			<li><a href="@item.Url">@item.Name</a></li>
		}
	</ul>


###.XPath(string XPath)

###.GetChildrenAsList

-----

##Traversing

###.Parent

###.First()
Returns the first item

	@var NewsArea = Model.NewsAreas.First();	


###.Last()
Returns the last item

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

###.DescendantOrSelf()

-----

##Filtering, Ordering & Extensions
	
###.Where("condition"[, valueIfTrue, valueIfFalse] )
Returns all items matching the given condition.
For more details on queries and conditions, see the section below

	@var ancestors = Model.Where("UmbracoNaviHide != @0", "True");
	
	@var HomePage = Model.Where("NodeTypeAlias == @0 && Level == @1 || Name = @2", "HomePage", 0, "Home").First();

###.OrderBy("fieldname [desc][,propertyAlias")
Orders a collection by a field name
	
	//order by name
	@var nodes = Model.Children.OrderBy("Name");
	
	// order by descending name
	@var nodes = Model.Children.OrderBy("Name desc");
	
###.GroupBy("propertyAlias")

###.Pluck("PropertyName")

###.Take(int)

###.Skip(int)

###.Count()
Returns the number of items in the collection

	@int numberOfChildren =  Model.Children.Count();
	
#DynamicNode

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
Returns the name of the Umbraco back office user that performed the last update operation on the content item.

###.CreatorName
Returns the name of the Umbraco back office user that initially created the content item.

###.WriterId
Returns the Id of the Umbraco back office user that performed the last update operation to the content item.

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
	
	@*Notice razor uses Pascal casing, there is therefore an OverLoad to get properties as Pascal cased as well*@
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

---

##Property Methods
**There are a few helpful methods to help check if a property exists, has a value or is null.**

###.HasProperty(string propertyAlias)
Returns a boolean value representing if the DynamicNode has a property with the specified alias.

###.HasValue(string propertyAlias)
Retruns a boolean value representing if the DynamicNode property has had a value set.

###.IsNull(string propertyAlias)
Returns a boolean value representing if the DynamicNode property is Null.

**Further useful property methods**

It is possible to use any standard C# method on a property such as .Contains (example below). They can also be chained, e.g. `@item.Name.SubString(1,3).Contains("v")`

###.Contains(string needle)
Returns a boolean value representing if the needle was found in the property (haystack).

For example:

	@foreach(var item in Model.Children.Where("bodyText.Contains(\"cat\")"))
	{
	    @item.Name 
	}

###.ContainsAny(List&lt;string&gt; needles)
A property extension method, it returns a boolean value representing if any of the needles in the list were found in the property.

For example:

	@{
		var values = new Dictionary<string,object>();
		var keywords = new List<string>();
		keywords.Add("cat");
		keywords.Add("dog");
		keywords.Add("fish");
		values.Add("keywords",keywords);
		var items = @Model.Children.Where("Name.ContainsAny(keywords)", values); 
	}

---

##Permissions
The following checks are to find out if the current website user has permissions or access to the current DynamicNode.   Commonly used in navigation scripts.

###.HasAccess()
Returns a boolean value representing whether or not the current website user has permissions to access the DynamicNode.

###.IsProtected()
Returns a boolean value representing whether a node has public access permissions set.

---
##Media


###.Media(string propertyAlias[,string mediaPropertyAlias])
When a DynamicNode contains a media picker, a media item can be returned using this method.

###.UmbracoFile
Returns the path to the file stored if the media type is using the umbracoFile property alias for the upload field

###.UmbracoSize
Returns the size of the file in KB if the media type has the umbracoSize property alias

###.UmbracoWidth
Returns the width of stored a image if the media type has the umbracoWidth property alias

###.UmbracoHeight
Returns the height of a stored image if the media type has the umbracoHeight property alias
	
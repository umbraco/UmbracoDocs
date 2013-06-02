#Querying & Traversal

**Applies to: Umbraco 4.10.0+**

_This section will describe how you can render content from other nodes besides the current page in your MVC Views_

##Querying for content and media by id

The easiest way to get some content by Id is to use the following syntax (where 1234 is the content id you'd like to query for):
	
	//to return the strongly typed (Umbraco.Core.Models.IPublishedContent) object
	@Umbraco.TypedContent(1234)

	//to return the dynamic representation:	
	@Umbraco.Content(1234) 	

You can also query for multiple content items using multiple ids:

	//to return the strongly typed (IEnumerable<Umbraco.Core.Models.IPublishedContent>) collection
	@Umbraco.TypedContent(1234, 4321, 1111, 2222)

	//to return the dynamic representation:	
	@Umbraco.Content(1234, 4321, 1111, 2222)

This syntax will support an unlimited number of Ids passed to the method. 

The same query structures apply to media:

	@Umbraco.TypedMedia(9999)
	@Umbraco.TypedMedia(9999,8888,7777)
	@Umbraco.Media(9999)
	@Umbraco.Media(9999,8888,7777)	


##Traversing

All of these extension methods are available on `Umbraco.Core.Models.IPublishedContent` so you can have strongly typed access to all of them with intellisense for both content and media. Additionally, all of these methods are available for the dynamic model representation too. The following methods return `IEnumerable<IPublishedContent>` (or dynamic if you are using @CurrentPage)

	Children() //this is the same as using the Children property on the content item.
	Ancestors()
	Ancestors(int level)
	Ancestors(string nodeTypeAlias)
	AncestorsOrSelf()
	AncestorsOrSelf(int level)
	AncestorsOrSelf(string nodeTypeAlias)
	Descendants()
	Descendants(int level)
	Descendants(string nodeTypeAlias)
	DescendantsOrSelf()
	DescendantsOrSelf(int level)
	DescendantsOrSelf(string nodeTypeAlias)
	

Additionally there are other methods that will return a single `IPublishedContent` (or dynamic if you are using @CurrentPage) 

	AncestorOrSelf()
	AncestorOrSelf(int level)
	AncestorOrSelf(string nodeTypeAlias)
	AncestorOrSelf(Func<IPublishedContent, bool> func)
	Up()
	Up(int number)
	Up(string nodeTypeAlias)
	Down()
	Down(int number)
	Down(string nodeTypeAlias)
	Next()
	Next(int number)
	Next(string nodeTypeAlias)
	Previous()
	Previous(int number)
	Previous(string nodeTypeAlias)
	Sibling(int number)
	Sibling(string nodeTypeAlias)

##Complex querying (Where)

With the `IPublishedContent` model we support strongly typed Linq queries out of the box so you will have intellisense for that too. We also still support all of the dynamic query access that was supported for razor macros, however in some very minor cases the same syntax may not be supported. In some cases the dynamic queries may be less to type and in some cases the strongly typed way might be less to type so it will ultimately be your preference for what you use and you can most definitely inter-mingle the two.

###Some examples

####Where children are visible

	//dynamic access
	@CurrentPage.Children.Where("Visible")
	
	//strongly typed access
	@Model.Content.Children.Where(x => x.IsVisible())

####Traverse for sitemap

	//dynamic access
	var values = new Dictionary<string,object>();
	values.Add("maxLevelForSitemap", 4);
	var items = @CurrentPage.Children.Where("Visible && Level <= maxLevelForSitemap", values);

	//strongly typed access
	var items = @Model.Content.Children.Where(x => x.IsVisible() && x.Level <= 4)

####Content sub menu

	//dynamic access
	//NOTE: you can also use NodeTypeAlias but is recommended to use DocumentTypeAlias
	@CurrentPage.AncestorOrSelf(1).Children.Where("DocumentTypeAlias == \"DatatypesFolder\"").First().Children
	
	//strongly typed
	@Model.Content.AncestorOrSelf(1).Children.Where(x => x.DocumentTypeAlias == "DatatypesFolder").First().Children

####Complex query

Some complex queries cannot be written dynamically because the dynamic query parser may not understand precisely what you are coding. There are many edge cases where this occurs and for each one the parser will need to be updated to understand such an edge case. This is one reason why strongly typed querying is much better.

	//This example gets the top level ancestor for the current node, and then gets 
	//the first node found that contains "1173" in the array of comma delimited 
	//values found in a property called 'selectedNodes'.
	//NOTE: This is one of the edge cases where this doesn't work with dynamic execution but the 
	//syntax has been listed here to show you that its much easier to use the strongly typed query 
	//instead

	//dynamic access
	var paramVals = new Dictionary<string, object> {{"splitTerm", new char[] {','}}, {"searchId", "1173"}};
	var result = @CurrentPage.Ancestors().OrderBy("level")
		.Single()
		.Descendants()
		.Where("selectedNodes != null && selectedNodes != String.Empty && selectedNodes.Split(splitTerm).Contains(searchId)", paramVals)
		.FirstOrDefault();
	
	//strongly typed
	var result = @Model.Content.Ancestors().OrderBy(x => x.Level)
		.Single()
		.Descendants()
		.FirstOrDefault(x => x.GetPropertyValue("selectedNodes", "").Split(',').Contains("1173"));

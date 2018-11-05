# DynamicPublishedContent

## Properties
Built-in properties, which exists on all dynamic content objects by default. These are referenced in Razor as a standard property
`object.Property` using standard C# syntax. 

	@* gets the current page Url *@
	@CurrentPage.Url
	
	@* gets the Creation date, and formats it to a short date *@
	@CurrentPage.CreateDate.ToString("D")
	
	@* Outputs the name of the parent if it exists *@
	@if(CurrentPage.Parent != null){
		<h1>@CurrentPage.Parent.Name</h1>
	}

All [standard properties](../IPublishedContent/Properties.md) that are available on `IPublishedContent` are available on `DynamicPublishedContent`

-----

## Custom properties
All content and media items also contains a reference to all the data defined by their document type, 
property access for custom properties is the same for built in properties using the standard 
`object.Property` C# syntax. 
	
### CurrentPage.PropertyAlias
Returns the property matching the PropertyAlias (replace with alias of property) 

	@*Get the property with alias: "siteName" from the current page  *@
	@CurrentPage.siteName
	
### CurrentPage._propertyAlias (recursive access)
Returns the property matching the propertyAlias (replace with alias of property) 
by prefixing with '_' razor will first look on the current page. If no value is defined, it will then search ancestor pages for a property matching the alias, and return a value, if a property is found.

	@* Get the "siteName" property recursively (if not present on current page, traverse 
	through page ancestors, 
	Notice this matches alias casing, but prefixes a _ char *@
	@CurrentPage._siteName
	
**Notice**, this matches the exact casing for the property.
Property `bodyText` is therefore referenced as `_bodyText`

---

## Property Methods
**There are a few helpful methods to help check if a property exists, has a value or is null.**

### .HasProperty(string propertyAlias)
Returns a boolean value representing if the DynamicPublishedContent has a property with the specified alias.

### .HasValue(string propertyAlias)
Returns a boolean value representing if the DynamicPublishedContent property has had a value set.

### .IsNull(string propertyAlias)
Returns a boolean value representing if the DynamicPublishedContent property is Null.

**Further useful property methods**

It is possible to use any standard C# method on a property such as .Contains (example below). They can also be chained, e.g. `@item.Name.SubString(1,3).Contains("v")`

### .Contains(string needle)
Returns a boolean value representing if the needle was found in the property (haystack).

For example:

	@foreach(var item in CurrentPage.Children.Where("bodyText.Contains(\"cat\")"))
	{
	    @item.Name 
	}

### .ContainsAny(List&lt;string&gt; needles)
A property extension method, it returns a boolean value representing if any of the needles in the list were found in the property.

For example:

	@{
		var values = new Dictionary<string,object>();
		var keywords = new List<string>();
		keywords.Add("cat");
		keywords.Add("dog");
		keywords.Add("fish");
		values.Add("keywords",keywords);
		var items = @CurrentPage.Children.Where("Name.ContainsAny(keywords)", values); 
	}
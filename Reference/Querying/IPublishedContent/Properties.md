# IPublishedContent Property Access

## Umbraco Properties

Built-in properties, which exists on all content objects by default

	@* gets the current page Url *@
	@Model.Content.Url
	
	@* gets the Creation date, and formats it to a short date *@
	@Model.Content.CreateDate.ToString("D")
	
	@* Outputs the name of the parent if it exists *@
	@if(Model.Content.Parent != null){
		<h1>@Model.Content.Parent.Name</h1>
	}

### .Parent
Returns the parent content item

### .Id
Returns the unique Id for the current content item

### .TemplateId
Returns the Template object used by this content item.

### .SortOrder
Returns the index the page is on, compared to its siblings

### .Name
Returns the Name of the current content item

### .Url
Returns the complete Url to the page

### .UrlName
Returns the Url encoded name of the page

### .DocumentTypeAlias
Returns the Alias of the Document type used by this content item.

### .WriterName
Returns the name of the Umbraco backoffice user that performed the last update operation on the content item.

### .CreatorName
Returns the name of the Umbraco backoffice user that initially created the content item.

### .WriterId
Returns the Id of the Umbraco backoffice user that performed the last update operation to the content item.

### .CreatorId
Returns the Id of the Umbraco backoffice user that initially created the content item.

### .Path
Returns a comma delimited string of Node Ids that represent the path of content items back to root.

### .CreateDate
Returns the DateTime the page was created

### .UpdateDate
Returns the DateTime the page was modified

### .Level
Returns the Level this content item is on

-----

## Custom properties
All content and media items also contains a reference to all the data defined by their document type. 
Custom property access is done with the various methods of: `GetPropertyValue`
	
### Model.Content.GetPropertyValue(string)
Returns the property value for the specified property alias 

	@*Get the property with alias: "siteName" from the current page  *@
	@Model.Content.GetPropertyValue("siteName")
	
The result Type of this property value is `object` which is fine in most cases since when using
the above syntax, Razor will automatically execute a `ToString()` on the result value.
	
### Model.Content.GetPropertyValue&lt;T>(string)
Returns the property value for the specified property alias converted to the specified output value. 

For example, to return the `string` result of "siteName" you would do:

 	@(Model.Content.GetPropertyValue<string>("siteName"))
		 
 Some property value converters support multiple return value formats, for example if a property value
 normally returns a comma separated value list like: "5677,3456,8776", then the property value
 converter for the property editor might support converting directly to an enumerable list of integers, for example:
 
 	@(Model.Content.GetPropertyValue<IEnumerable<int>>("mediaIds"))

Another example might be if a property editor stores a JSON value, it might support converting to a custom 
strongly typed model such as, or at the very least the JSON would be convertible to a `JObject` instance, for example:

 	@(Model.Content.GetPropertyValue<NestedContentModel>("nestedContent"))
		 
 or
 
 	@(Model.Content.GetPropertyValue<JObject>("nestedContent"))

## Property Methods
**There are a few helpful methods to help check if a property exists, has a value or is null.**

### .HasProperty(string propertyAlias)
Returns a boolean value representing if the IPublishedContent has a property with the specified alias.

### .HasValue(string propertyAlias)
Returns a boolean value representing if the IPublishedContent property has had a value set.

### .IsNull(string propertyAlias)
Returns a boolean value representing if the IPublishedContent property is Null.
# (Obsolete) Multinode Treepicker

`Returns: ID or CSV`

## Settings

The Multinode Treepicker allows you to configure the type of tree to render, what part of the tree that should be rendered, and specifically for content, it allows you to select a dynamic root node based on the current document using the multinode tree picker. 

**Node type:** set the type of node, root node of the tree, or query for the root node

For querying for a root node, you can use dynamic placeholders in the XPath query, following the below sample queries 

	// get the first textpage below the current document
	$current/textpage: current page or closest found ancestor
	
	// get a descendant of type news article somewhere below the parent
	$parent//newsArticle: parent page or closest found ancestor
	
	// go to the root the content tree
	$root
	
	// go the ancestor at @level=1 where your website root usually is.
	$site: Ancestor node at level 1 

It is important to notice that all placeholders above acts against published content only. So if you therefore try to fetch `$parent` of the current document, then Umbraco will return that or its closest published ancestor. So in case parent is not published, it will try the parent of that parent, and so on.  


**Filter out items with type:** allow or disallow tree nodes with a certain content type alias.

Enter `typeAlias,altTypeAlias` to only allow selecting nodes with those alias'. Enter `!typeAlias,altTypeAlias` to only allow selecting nodes **not** with those alias'.

**Minimum/maximum number of items:** set a limit on the amount of items allowed to be selected.
 
 
**note:** the ability to query for the content trees root node was added in 7.0.3 


## Data Type Definition Example

![Multinode Treepicker Data Type Definition](images/Multinode-Treepicker-DataType.png)

## Content Example 

![Multinode Treepicker](images/Multinode-Treepicker-Content.jpg)

## MVC View Example - [value converters enabled](../../../Setup/Upgrading/760-breaking-changes.md#property-value-converters-u4-7318)

### Typed:

    @{
        var typedMultiNodeTreePicker = Model.Content.GetPropertyValue<IEnumerable<IPublishedContent>>("banner");
        foreach (var item in typedMultiNodeTreePicker)
        {
            <p>@item.Name</p>
        }
    }

## MVC View Example - [value converters disabled](../../../Setup/Upgrading/760-breaking-changes.md#property-value-converters-u4-7318)

### Typed:

	@{
	    if (Model.Content.HasValue("banner"))
	    {
	        var bannerListValue = Model.Content.GetPropertyValue<string>("banner");
	        var bannerList = bannerListValue.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(int.Parse);
	        var bannerCollection = Umbraco.TypedContent(bannerList).Where(x => x != null);
	        foreach (var item in bannerCollection)
	        {
	            <p>@item.Name</p>
	        }
	    }
	}

### Dynamic:                              

	@{
	    var bannerList = CurrentPage.banner.ToString().Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
	    var bannerCollection = Umbraco.Content(bannerList);
	    foreach (var item in bannerCollection)
	    {
	        <p>@item.Name</p>
	    }
	}

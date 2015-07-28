#Content Picker

`Returns: Node Id`

The content picker opens a panel to pick a specific page from the content structure. The value saved is the selected nodes ID.

##Data Type Definition Example

![Content Picker Data Type Definition](images/wip.png)

##Content Example 

![Content Picker Content](images/wip.png)

##MVC View Example

###Typed:

	@{
	  if (Model.Content.HasValue("contentPicker")){
	    var node = Umbraco.TypedContent(Model.Content.GetPropertyValue<int>("contentPicker"));
	    <a href="@node.Url">@node.Name</a>
	  }
	}

###Dynamic:                              

	@{
	  if (CurrentPage.HasValue("contentPicker")){
	    var node = Umbraco.Content(CurrentPage.contentPicker);
	    <a href="@node.Url">@node.Name</a>
	  }
	}
	
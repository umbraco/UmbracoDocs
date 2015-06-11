#Content Picker

`Returns: Node ID`

The content picker opens a simple modal to pick a specific page from the content structure. The value saved is the selected nodes ID. 

##Data Type Definition Example

![Content Picker Data Type Definition](images/Content-Picker-DataType.jpg?raw=true)

##Content Example

![Content Picker Example](images/Content-Picker-Content.jpg?raw=true)

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

##Razor Macro (DynamicNode) Example

	@{
	  if (Model.HasValue("contentPicker")){
	    var node = Library.NodeById(Model.contentPicker);
	    <a href="@node.Url">@node.Name</a>
	  }
	}

##XSLT Macro Example

	<xsl:if test="number($currentPage/contentPicker) > 0">  
	  <a href="{umbraco.library:NiceUrl($currentPage/contentPicker)}">
	    <xsl:value-of select="umbraco.library:GetXmlNodeById($currentPage/contentPicker)/@nodeName"/>
	  </a>
	</xsl:if>
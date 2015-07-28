#Textbox

`Returns: String`

Textbox is a simple HTML input control for text

##Data Type Definition Example

![Textbox Multiple Data Type Definition](images/Textbox-DataType.jpg?raw=true)

##Settings

###Database datatype

This setting is maintained for legacy however it should generally be set to Nvarchar as the property editor stores the value which is always text.

##Content Example 

![No Edit Content Example](images/Textbox-Content.jpg?raw=true)

##MVC View Example

###Typed:

	@{
	   if (Model.Content.HasValue("pageTitleH1")){
	       <p>@Model.Content.GetPropertyValue<string>("pageTitleH1")</p>
	   } 
	}

###Dynamic: 

	@{       
	   if (CurrentPage.HasValue("pageTitleH1")){
	       <p>@CurrentPage.pageTitleH1</p>
	   } 	       
	}

##Razor Macro (DynamicNode) Example

	@inherits umbraco.MacroEngines.DynamicNodeContext
	@using umbraco.MacroEngines
	@{
	   if (Model.HasValue("pageTitleH1")){
	       <p>@Model.pageTitleH1</p>
	   } 
	}


##XSLT Macro Example

	<xsl:if test="string-length($currentPage/pageTitleH1) > 0">  
	  <p><xsl:value-of select="$currentPage/pageTitleH1"/></p>  
	</xsl:if>
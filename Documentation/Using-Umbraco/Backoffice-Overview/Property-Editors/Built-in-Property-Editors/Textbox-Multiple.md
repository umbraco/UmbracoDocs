#Textbox Multiple

`Returns: String`

Textbox Multiple is simple HTML textarea control to input text

##Data Type Definition Example

![Textbox Multiple Data Type Definition](images/Textbox-Multiple-DataType.jpg?raw=true)

##Settings

###Database datatype

This setting is maintained for legacy however it should be set to Ntext as the property editor stores the value which is always text.

##Content Example 

![No Edit Content Example](images/Textbox-Multiple-Content.jpg?raw=true)

##MVC View Example

###Typed:

	@{
	   if (Model.Content.HasValue("introParagraph")){
	       <p>@Model.Content.GetPropertyValue<string>("introParagraph")</p>
	   } 
	}

###Dynamic: 

	@{       
	   if (CurrentPage.HasValue("introParagraph")){
	       <p>@CurrentPage.introParagraph</p>
	   } 	       
	}

##Razor Macro (DynamicNode) Example

	@inherits umbraco.MacroEngines.DynamicNodeContext
	@using umbraco.MacroEngines
	@{
	   if (Model.HasValue("introParagraph")){
	       <p>@Model.introParagraph</p>
	   } 
	}


##XSLT Macro Example

	<xsl:if test="string-length($currentPage/introParagraph) > 0">  
	  <p><xsl:value-of select="$currentPage/introParagraph"/></p>  
	</xsl:if>
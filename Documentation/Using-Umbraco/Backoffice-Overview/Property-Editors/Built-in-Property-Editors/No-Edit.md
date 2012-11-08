#No Edit

`Returns: String`

No Edit is a property editor that can only be used to display a preset text. It can also be used in the media section to load in values related to the node, such as width, height and file size.

##Data Type Definition Example

![No Edit Data Type Definition](images/No-Edit-Settings.jpg?raw=true)

##Content Example 

![No Edit Content Example](images/No-Edit-Content.jpg?raw=true)

##XSLT Example

	<xsl:if test="string-length($currentPage/propertyNoEdit) > 0">  
	  <p><xsl:value-of select="$currentPage/propertyNoEdit"/></p>  
	</xsl:if>

##Razor (DynamicNode) Example

	@inherits umbraco.MacroEngines.DynamicNodeContext
	@using umbraco.MacroEngines
	@{  
		if (Model.HasValue("propertyNoEdit")){
			<p>@Model.propertyNoEdit</p>
		}
	}

**TIP:** If you need to edit the value of a "Label" property, switch it's type to "Textstring", edit the value and then switch it back to "Label".
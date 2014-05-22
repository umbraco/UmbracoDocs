#No Edit

`Returns: String`

No Edit is a property editor that can only be used to display a preset text. It can also be used in the media section to load in values related to the node, such as width, height and file size.

##Data Type Definition Example

![No Edit Data Type Definition](images/No-Edit-Settings.jpg?raw=true)

##Content Example 

![No Edit Content Example](images/No-Edit-Content.jpg?raw=true)

##MVC View Example

###Typed:

	@{
	   if (Model.Content.HasProperty("propertyNoEdit")){
	       <p>This document type has a No Edit property</p>
	   } else {
	        <p>This document type does have a No Edit property</p>
	   }
	}

###Dynamic: 

	@{       
	   if (CurrentPage.HasProperty("propertyNoEdit")){
	       <p>This document type has a No Edit property</p>
	   } else {
	        <p>This document type does have a No Edit property</p>
	   }
	        
	}

##Razor Macro (DynamicNode) Example

	@inherits umbraco.MacroEngines.DynamicNodeContext
	@using umbraco.MacroEngines
	@{  
		if (Model.HasProperty("propertyNoEdit")){
			<p>This document type has a No Edit property</p>
	   } else {
	        <p>This document type does have a No Edit property</p>
	   }
	}


##XSLT Macro Example

	<xsl:choose>
	  <xsl:when test="$currentPage/propertyNoEdit">
	    <p>This document type has a No Edit property</p>  
	  </xsl:when>
	  <xsl:otherwise>
	    <p>This document type does have a No Edit property</p>
	  </xsl:otherwise>  
	</xsl:choose>

**TIP:** If you need to edit the value of a "Label" property, switch its type to "Textstring", edit the value and then switch it back to "Label".
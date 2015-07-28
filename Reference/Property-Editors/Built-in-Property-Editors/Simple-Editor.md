#Simple Editor

`Returns: String`

Simple Editor is simple HTML text area control that additionally provides three quick function buttons for adding bold, italic and link markup.

##Data Type Definition Example

![Simple Editor Data Type Definition](images/Simple-Editor-DataType.jpg?raw=true)

##Settings

###Database datatype

This setting is maintained for legacy however it should be set to Ntext as the property editor stores the value which is always text.

##Content Example 

![No Edit Content Example](images/Simple-Editor-Content.jpg?raw=true)

##MVC View Example

###Typed:

	@{
	   if (Model.Content.HasValue("footerContent",true)){
	       @Html.Raw(Model.Content.GetPropertyValue("footerContent",true))
	   } 
	}

###Dynamic: 

	@{       
	   if (CurrentPage.HasValue("footerContent",true)){
	       @Html.Raw(CurrentPage._footerContent)
	   } 	       
	}

##Razor Macro (DynamicNode) Example

	@inherits umbraco.MacroEngines.DynamicNodeContext
	@using umbraco.MacroEngines
	@{
        if (Model.HasValue("footerContent",true)){
	        if (Model._footerContent.GetType() == typeof(DynamicXml)){
	            @Html.Raw(Model._footerContent.ToXml().ToString())
	        } else {
	            @Html.Raw(Model._footerContent.ToString())
	        }
        }
	}
Note: DynamicXml check is only required due to a known issue http://issues.umbraco.org/issue/U4-2224

##XSLT Macro Example

	<xsl:if test="string-length($currentPage/ancestor-or-self::*[@isDoc]/footerContent) > 0">  
	  <xsl:value-of select="$currentPage/ancestor-or-self::*[@isDoc]/footerContent" disable-output-escaping="yes"/>  
	</xsl:if>
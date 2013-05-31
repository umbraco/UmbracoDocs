#True/False

`Returns: Boolean`

True/False is a simple checkbox which saves either 0 or 1, depending on the checkbox being checked or not.

##Data Type Definition Example

![Textbox Multiple Data Type Definition](images/TrueFalse-DataType.jpg?raw=true)

##Settings

###Database datatype

This setting is maintained for legacy however it should generally be set to Integer as the property editor stores the value which is always 0 or 1.

##Content Example 

![No Edit Content Example](images/TrueFalse-Content.jpg?raw=true)

##MVC View Example

###Typed:

	@{
		foreach (var page in Model.Content.Children){
            if (!page.GetPropertyValue<bool>("umbracoNaviHide"))
            {
				<p>@page.Name</p>
			}
		}	
	}

###Dynamic: 

	@{
		foreach (var page in CurrentPage.Children){
			if (!page.umbracoNaviHide){
				<p>@page.Name</p>
			}
		}	
	}

##Razor Macro (DynamicNode) Example

	@inherits umbraco.MacroEngines.DynamicNodeContext
	@using umbraco.MacroEngines
	@{
		foreach (var page in Model.Children){
			if (!page.umbracoNaviHide){
				<p>@page.Name</p>
			}
		}	
	}


##XSLT Macro Example

	<xsl:for-each select="$currentPage/*[@isDoc]">
		<xsl:if test="string(umbracoNaviHide) != '1'">
			<p><xsl:value-of select="@nodeName"/></p>
		</xsl:if>
	</xsl:for-each>
#Multiple Textstring

`Returns: XML`

The Multiple Textstring property editor enables a content editor to make a list of text items. For best use with an unordered-list.

##Settings

There are two settings for Multiple Textstring which allow the setting of the minimum and maximum (-1 unlimited) number of items to display.

![Multiple Textstring Data Type Definition](images/Multiple-Textstring-Settings.jpg?raw=true)

##Content Example 

![Multiple Textstring Content Example](images/Multiple-Textstring-Content.jpg?raw=true)

Users can add a new item by clicking the plus icon, delete a item by clicking the minus icon and order the items by clicking and dragging on the blue up/down icon.

##Data example

Multiple Textstring stores it's content as XML, below is an example.

	<keyFeatureList>
		<values>
			<value>Strong</value>
			<value>Flexible</value>
			<value>Efficient</value>
		</values>
	</keyFeatureList>
	

##XSLT Example

	<xsl:if test="count($currentPage/keyFeatureList/values/value) > 0">
	  <ul>
		<xsl:for-each select="$currentPage/keyFeatureList/values/value">
			<li><xsl:value-of select="current()"/></li>
		</xsl:for-each>
	  </ul>
	</xsl:if>

##Razor (DynamicXML) Example

	@inherits umbraco.MacroEngines.DynamicNodeContext
	@using umbraco.MacroEngines
	@{
		if (Model.keyFeatureList.Any()){	
		  <ul>
			@foreach (var item in Model.keyFeatureList) {		
				<li>@item.InnerText</li>
			}
		  </ul>
		}
	}

**NOTE:** DynamicXml .Any() method is only available in Umbraco 4.10.0+ Substitute with `if (Model.keyFeatureList.Count() > 0)` if using a older version of Umbraco
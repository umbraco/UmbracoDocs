#Dropdown list

`GUID a74ea9c9-8e18-4d2a-8cf6-73c6206c5da6`

`Retuns: Text value`

Displays a list of preset values as a list. The value saved is a text value. The prevalue ID is not accessible, use the [Dropdown list, publishing keys](Dropdown-Publish-Keys.md) instead if you need the prevalue ID.

##Data Type Definition Example

![Dropdown List, Data Type Definition](images/Dropdown-DataType.jpg?raw=true)

##Content Example

![Dropdown List, Publish Keys Content Example](images/Dropdown-Content.jpg?raw=true)

##XSLT Example

	<xsl:if test="string-length($currentPage/superHero) > 0">  
	  <p><xsl:value-of select="$currentPage/superHero"/></p>  
	</xsl:if>

##Razor (DynamicNode) Example

	@{
	  if (@Model.HasValue("superHero")){                                                     
	   <p>@Model.superHero</p>                                                                                                                                                                                                                                                                                                                                                       
	  }
	}
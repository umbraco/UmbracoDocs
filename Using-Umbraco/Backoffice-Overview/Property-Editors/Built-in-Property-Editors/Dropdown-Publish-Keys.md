#Dropdown list, publishing keys

`Retuns: Prevalue ID`

Displays a list of preset values as a list. The value saved is a prevalue ID. The Prevalue text can be retrieved using the umbraco.library.GetPreValueAsString method in XSLT or Razor.

##Data Type Definition Example

![Dropdown List, publishing keys Data Type Definition](images/Dropdown-Publish-Keys-DataType.jpg?raw=true)

##Content Example

![Dropdown List, Publish Keys Content Example](images/Dropdown-Content.jpg?raw=true)

##XSLT Example

	<xsl:if test="$currentPage/superHero > 0">  
	  <p><xsl:value-of select="umbraco.library:GetPreValueAsString(number($currentPage/superHero))"/> - <xsl:value-of select="$currentPage/superHero"/></p>  
	</xsl:if>

##Razor (DynamicNode) Example

	@{
	  if (Model.HasValue("superHero")){                                                     
	    <p>@umbraco.library.GetPreValueAsString(Convert.ToInt32(Model.superHero)) - @Model.superHero</p>                                                                                               
	  }
	}
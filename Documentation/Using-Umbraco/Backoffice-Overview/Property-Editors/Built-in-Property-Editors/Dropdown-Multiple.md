#Dropdown list multiple

`Returns: Comma Separated String`

Displays a list of preset values as a list where multiple values can be selected. The value saved is a comma separated string of the text values. The prevalue ID's are not accessible, use the [Dropdown list multiple, publish keys](Dropdown-Multiple-Publish-Keys.md) instead if you need the prevalue IDs.

##Data Type Definition Example

![Dropdown List, Publish Keys Data Type Definition](images/Dropdown-Multiple-DataType.jpg?raw=true)

##Content Example

![Dropdown List, Publish Keys Content Example](images/Dropdown-Multiple-Content.jpg?raw=true)

##XSLT Example

	<xsl:if test="string-length($currentPage/superHeros) > 0">  
	  <xsl:variable name="items" select="umbraco.library:Split($currentPage/superHeros,',')" />  
	  <ul>  
	  <xsl:for-each select="$items//value">
	    <li>
	      <xsl:value-of select="current()"/>
	    </li>
	  </xsl:for-each>
	  </ul>    
	</xsl:if>

##Razor (DynamicNode) Example

	@{
	  if (Model.HasValue("superHeros")){
	    <ul>                                                        
	      @foreach(var item in Model.GetProperty("superHeros").Value.Split(',')) { 
	        <li>@item</li>
	      }
	    </ul>                                                                                        
	  }
	}

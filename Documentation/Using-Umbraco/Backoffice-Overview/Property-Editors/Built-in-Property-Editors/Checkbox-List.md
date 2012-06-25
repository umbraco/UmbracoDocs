#Checkbox list

`GUID b4471851-82b6-4c75-afa4-39fa9c6a75e9`

Displays a list of preset values as a list of checkbox controls. The preset values are modified in the developer section under "data types" / checkbox list where new items can be added. The text saved is a comma separeted string of prevalue IDs. 

NOTE: Unlike other data types, the values are not directly accessible in xslt or razor

##Data Type Definition Example

![Approved Color Data Type Definition](images/CheckBox-List-DataType.jpg?raw=true)

##Content Example

![Approved Color Data Type Definition](images/CheckBox-List-Content.jpg?raw=true)

##XSLT Example

	<xsl:if test="string-length($currentPage/fruit) > 0">  
	  <xsl:variable name="items" select="umbraco.library:Split($currentPage/fruit,',')" />  
	  <ul>  
	  <xsl:for-each select="$items//value">
	    <li>
	      <xsl:value-of select="current()"/>
	    </li>
	  </xsl:for-each>
	  </ul>    
	</xsl:if>

##Razor Example

	@{
	  if (@Model.fruit.Length > 0){
	    <ul>                                                        
	      @foreach(var item in @Model.fruit.Split(',')) { 
	       <li>@item</li>
	      }
	    </ul>                                                                                        
	  }
	}
#Checkbox list

`Returns: Comma Separated String`

Displays a list of preset values as a list of checkbox controls. The preset values are modified in the developer section under "data types" / checkbox list where new items can be added. The text saved is a comma separated string of text values. 

NOTE: Unlike other data types, the Prevalue IDs are not directly accessible in xslt or razor

##Data Type Definition Example

![Approved Color Data Type Definition](images/CheckBox-List-DataType.jpg?raw=true)

##Content Example

![Approved Color Data Type Definition](images/CheckBox-List-Content.jpg?raw=true)

##XSLT Example

	<xsl:if test="string-length($currentPage/fruitList) > 0">  
	  <xsl:variable name="items" select="umbraco.library:Split($currentPage/fruitList,',')" />  
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
	  if (Model.HasValue("fruitList")){                                                        
	    <ul>                                                        
	      @foreach(var item in Model.GetProperty("fruitList").Value.Split(',')) { 
	        <li>@item</li>
	      }
	    </ul>                                                                                        
	  }
	}
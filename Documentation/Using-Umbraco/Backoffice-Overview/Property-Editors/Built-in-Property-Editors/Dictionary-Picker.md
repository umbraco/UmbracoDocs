#Dictionary Picker

`Returns: Comma Separated String`

Displays a checkbox list of child dictionary items for a named dictionary item

##Data Type Definition Example

![Dictionary Picker Data Type Definition](images/Dictionary-Picker-DataType.jpg?raw=true)

The prevalue text must match the parent dictionary item, in the example below this is "Selected Fruit"

##Content Example

![Dictionary Picker Data Type](images/Dictionary-Picker-Setup.jpg?raw=true)
![Dictionary Picker Data Type](images/Dictionary-Picker-Content.jpg?raw=true)

If you change the language on the root node, the language in the checkbox list in the Umbraco backoffice also changes

![Dictionary Picker Data Type](images/Dictionary-Picker-Content2.jpg?raw=true)

##Examples

The example below renders a HTML select drop down list, if the root node has a language, the dictionary will return the values in that language, see [Hostnames]() for how do change the language

![Dictionary Picker Data Type HTML](images/Dictionary-Picker-HTML-Result.jpg?raw=true)

###XSLT


	<xsl:if test="string-length($currentPage/dictionaryPicker) > 0">  
	  <xsl:variable name="items" select="umbraco.library:Split($currentPage/dictionaryPicker,',')" />  
	  <select>  
	  <xsl:for-each select="$items//value">
	    <option value="{current()}">
	      <xsl:value-of select="umbraco.library:GetDictionaryItem(current())"/>      
	    </option>
	  </xsl:for-each>
	  </select>    
	</xsl:if>  

###Razor (DynamicNode) Example

	  @{
	    if (Model.HasValue("fruit")){
	      <select>                                                         
	        @foreach(var item in Model.GetProperty("dictionaryPicker").Value.Split(',')) { 
	         <option value="@item">@Dictionary[@item]</option>
	        }
	      </select>                                                                                         
	    }
	  }
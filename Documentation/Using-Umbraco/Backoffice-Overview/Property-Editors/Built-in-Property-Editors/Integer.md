#Integer

`Returns: Integer`

A simple textbox to input a numeric value

NOTE: Validation regular expressions do not function on this property editor and the prevalue within the data type settings performs no function.

##Data Type Definition Example

![Integer Data Type Definition](images/Integer-DataType.jpg?raw=true)

##Content Example

![Integer Content Example](images/Integer-Content.jpg?raw=true)

##XSLT Example

	<xsl:if test="string-length($currentPage/stockLevel) > 0">  
	  <p><xsl:value-of select="$currentPage/stockLevel"/></p>  
	</xsl:if>

##Razor (DynamicNode) Example

	@{
	  if (Model.HasValue("stockLevel")){                                                     
	   <p>@Model.stockLevel</p>                                                                                    
	  }
	}

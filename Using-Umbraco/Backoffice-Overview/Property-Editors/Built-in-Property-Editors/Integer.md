#Integer

`Returns: Integer`

A simple textbox to input a numeric value

##Data Type Definition Example

![Integer Data Type Definition](images/Integer-DataType.jpg?raw=true)

##Content Example

![Integer Content Example](images/Integer-Content.jpg?raw=true)

##MVC View Example

###Typed:

    @{
        if (Model.Content.HasValue("stockLevel")){    
        Int32 stockLevel = Model.Content.GetPropertyValue<Int32>("stockLevel");
        <p>@stockLevel.ToString()</p>                                                                                    
        }
    }

###Dynamic: 

    @{
        if (CurrentPage.HasValue("stockLevel")){                                                     
        <p>@CurrentPage.stockLevel</p>                                                                                    
        }
    }

##Razor Macro (DynamicNode) Example

	@{
	  if (Model.HasValue("stockLevel")){                                                     
	   <p>@Model.stockLevel</p>                                                                                    
	  }
	}

##XSLT Macro Example

	<xsl:if test="string-length($currentPage/stockLevel) > 0">  
	  <p><xsl:value-of select="$currentPage/stockLevel"/></p>  
	</xsl:if>
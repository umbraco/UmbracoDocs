#Ultimate Picker

`Returns: CSV`

The Ultimate picker is a flexible document picker where you can set the root for the picker as well as of what type  the picker should rendered as to the content editor. Other settings control which document types the picker should filter, and if it should show grandchildren of the root.

##Data Type Definition Example

![Ultimate Picker Data Type Definition](images/Ultimate-Picker-DataType.jpg?raw=true)

##Settings

###Database datatype

This setting is maintained for legacy however it should generally be set to Nvarchar as the property editor stores the value which is always a string. (You can store as a Integer if you are choosing a "Type" that only allows a single node selection)

###Type 

This setting determines what control is rendered to the content editor. The options are:

- Autocomplete (Single node selector)

![Ultimate Picker](images/Ultimate-Picker-AutoComplete.jpg?raw=true)

- CheckboxList (Multiple node selector)

![Ultimate Picker](images/Ultimate-Picker-CheckBoxList.jpg?raw=true)

- DropDownList (Single node selector)

![Ultimate Picker](images/Ultimate-Picker-DropDownList.jpg?raw=true)

- ListBox (Multiple node selector)

![Ultimate Picker](images/Ultimate-Picker-ListBox.jpg?raw=true)

- RadioButtonList (Single node selector)

![Ultimate Picker](images/Ultimate-Picker-RadioButtonList.jpg?raw=true)

###Parent nodeid 

This setting determines the parent node from which the children will populate the picker.

###Document Alias filter (comma-separated)

This setting allows the items within the picker to be filtered depending on their document type so that only certain documents are shown within the picker.

###Show grandchildren

This settings determines if the picker should be populated with items which the parent nodes grandchildren as well as children.

##MVC View Example

###Typed:

    @{
        String typedUltimatePicker = Model.Content.GetPropertyValue<string>("ultimatePicker");
        IEnumerable<int> typedPublishedUltimateNodeList = typedUltimatePicker.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(x => int.Parse(x));            
        IEnumerable<IPublishedContent> typedUltimatePickerCollection = Umbraco.TypedContent(typedPublishedUltimateNodeList).Where(x => x != null);
        foreach (IPublishedContent item in typedUltimatePickerCollection)
        {     
            <p>@item.Name</p>         
        }       
    }

###Dynamic: 

    @{
        var dynamicUltimatePicker = CurrentPage.ultimatePicker.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
        var dynamicUltimateCollection = Umbraco.Content(dynamicUltimatePicker);
        foreach (var item in dynamicUltimateCollection)
        {     
            <p>@item.Name</p>         
        }       
    }

##Razor Macro (DynamicXml) Example

	@{
	    if (Model.HasValue("ultimatePicker")){
	        //filter out unpublished or deleted nodes, check for Id > 0 due to bug (U4-1924) with NodesById
	        IEnumerable<DynamicNode> PublishedNodeList = Library.NodesById(Model.ultimatePicker.Split(','));        
	        PublishedNodeList = PublishedNodeList.Where(x => x.GetType() != typeof(DynamicNull) && x.Id > 0);                        
	        dynamic ultimatePicker = new DynamicNodeList(PublishedNodeList);    
	        
	        if (ultimatePicker.Any()){            
	            foreach(var item in ultimatePicker.Where("Visible")){                   
	                <p>@item.Name</p>      
	            }               
	        }
	    } 
	}

##XSLT Macro Example

	<xsl:if test="string-length($currentPage/ultimatePicker) > 0">  
	  <xsl:variable name="items" select="umbraco.library:Split($currentPage/ultimatePicker,',')" />  
	  <xsl:for-each select="$items//value">
	    <xsl:variable name="currentnode" select="umbraco.library:GetXmlNodeById(.)" />
	    <!-- render only published nodes -->
	    <xsl:if test="count($currentnode/error) = 0 and string($currentnode/umbracoNaviHide) != '1'">  
	        	<p><xsl:value-of select="$currentnode/@nodeName" /></p>
	    </xsl:if>                       
	  </xsl:for-each>     
	</xsl:if>

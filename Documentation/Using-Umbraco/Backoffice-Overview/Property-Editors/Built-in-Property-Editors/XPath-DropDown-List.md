#XPath DropDownList

`Returns: String`

Uses an XPath expression to select nodes from the content tree to use as the dropdown list options. The advantage of using XPath to define the nodes to use is that it allows a granular selection throughout the whole tree.

##Data Type Definition Example

![Ultimate Picker Data Type Definition](images/XPath-DropDown-List-DataType.jpg?raw=true)

##Settings

###Type

This setting determines if the rendered dropdown list will contain documents, media or members.

**Note: Members option is only available in Umbraco v6.0.2+**

###XPath Expression 

The XPath expression should select the nodes for the editor to choose from.

The expression is evaluated by using [uQuery.GetNodesByXPath](../../../../Reference/Querying/uQuery/Content/Nodes.md) This method provides some very useful tokens such as $ancestorOrSelf which allow complex expressions.

An example might be to select news items (document type alias of "NewsItem") that are descendants of the same level 1 node as the one being edited, `$ancestorOrSelf/ancestor-or-self::*[@level=1]/NewsItem`

###Value

This setting determines if the returned data are NodeIds or Node Names. Generally this is set to "Node Ids" as it provides the possibility to access full node data.

##Content Example 

![XPath Checkbox List](images/XPath-DropDown-List-Content.jpg?raw=true)

##MVC View Example

**Note: All examples assume "Value" setting is set to "Node Id"**

###Typed:

    @{
        if (Model.Content.HasValue("xPathDropDownList"))
        {
            int xPathDropDownList = Model.Content.GetPropertyValue<int>("xPathDropDownList");
            if (xPathDropDownList != null)
            {
                <p>@Umbraco.TypedContent(xPathDropDownList).Name</p> 
            }                                         
        }
    }

###Dynamic: 

	@{
	    if (CurrentPage.HasValue("xPathDropDownList"))
	    {
	        var xPathDropDownList = Umbraco.Content(CurrentPage.xPathDropDownList);
	        if (xPathDropDownList != null)
	            {
	                <p>@xPathDropDownList.Name</p>                                                
	            } 
	    }
	}

##Razor Macro (DynamicNode) Example

	@{
	    if (Model.HasValue("xPathDropDownList"))
	    {
	        var xPathDropDownList = Library.NodeById(Model.xPathDropDownList);
	        if (xPathDropDownList != null)
	            {
	                <p>@xPathDropDownList.Name</p>                                                
	            } 
	    }
	}

##XSLT Macro Example

	<xsl:if test="number($currentPage/xPathDropDownList) > 0">
	  <xsl:variable name="xPathDropDownList" select="umbraco.library:GetXmlNodeById($currentPage/xPathDropDownList)" />
	  <p>
	    <xsl:value-of select="$xPathDropDownList/@nodeName"/>
	  </p>
	</xsl:if>

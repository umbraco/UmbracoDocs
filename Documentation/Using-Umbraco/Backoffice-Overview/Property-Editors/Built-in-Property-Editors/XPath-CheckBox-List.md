#XPath CheckBoxList

`Returns: CSV or XML`

Uses an XPath expression to select nodes from the content tree to use as the checkbox options. The advantage of using XPath to define the nodes to use is that it allows a granular selection throughout the whole tree.

##Data Type Definition Example

![Ultimate Picker Data Type Definition](images/XPath-Checkbox-List-DataType.jpg?raw=true)

##Settings

###Type

This setting determines if the rendered checkbox list will contain documents, media or members.

**Note: Members option is only available in Umbraco v6.0.2+**

###XPath Expression 

The XPath expression should select the nodes for the editor to choose from.

The expression is evaluated by using [uQuery.GetNodesByXPath](../../../../Reference/Querying/uQuery/Content/Nodes.md) This method provides some very useful tokens such as $ancestorOrSelf which allow complex expressions.

An example might be to select news items (document type alias of "NewsItem") that are descendants of the same level 1 node as the one being edited, `$ancestorOrSelf/ancestor-or-self::*[@level=1]/NewsItem`

###Storage Type

This setting determines if the data is stored as CSV data or XML.

###Values

This setting determines if the returned data are NodeIds or Node Names. Generally this is set to "Node Ids" as it provides the possibility to access full node data.

##Content Example 

![XPath Checkbox List](images/XPath-Checkbox-List-Content.jpg?raw=true)

##MVC View Example

**Note: All examples assume "Values" setting is set to "Node Id"**

###Typed:

For XML data storage (DynamicXml used to retrieve NodeIds):

    @{
        DynamicXml typedXPathCheckBoxList = new DynamicXml(Model.Content.GetPropertyValue<string>("xPathCheckBoxListXML"));
        List<string> typedPublishedXPathCheckBoxListNodeList = new List<string>();
        foreach (dynamic id in typedXPathCheckBoxList)                
        {
            typedPublishedXPathCheckBoxListNodeList.Add(id.InnerText); 
        }                        
        IEnumerable<IPublishedContent> typedXPathCheckBoxListCollection = Umbraco.TypedContent(typedPublishedXPathCheckBoxListNodeList).Where(x => x != null);
        foreach (IPublishedContent item in typedXPathCheckBoxListCollection)
        {     
            <p>@item.Name</p>         
        }       
    }

For CSV data storage:

    @{
        String typedXPathCheckBoxListCSV = Model.Content.GetPropertyValue<string>("xPathCheckBoxListCSV");
        IEnumerable<int> typedPublishedXPathCheckBoxListCSV = typedXPathCheckBoxListCSV.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries).Select(x => int.Parse(x));
        IEnumerable<IPublishedContent> typedXPathCheckBoxListCollectionCSV = Umbraco.TypedContent(typedPublishedXPathCheckBoxListCSV).Where(x => x != null);
        foreach (IPublishedContent item in typedXPathCheckBoxListCollectionCSV)
        {     
            <p>@item.Name</p>         
        }       
    }

###Dynamic: 

For XML data storage

    @{
        var dynamicPublishedXPathCheckBoxListNodeList = new List<string>();
        foreach (var id in CurrentPage.xPathCheckBoxListXML)                
        {
            dynamicPublishedXPathCheckBoxListNodeList.Add(id.InnerText); 
        }
        var dynamicXPathCheckBoxListCollection = Umbraco.Content(dynamicPublishedXPathCheckBoxListNodeList);
        foreach (var item in dynamicXPathCheckBoxListCollection)
        {     
            <p>@item.Name</p>         
        }       
    }   

For CSV data storage:

    @{
        var dynamicPublisheddXPathCheckBoxListCSV = CurrentPage.xPathCheckBoxListCSV.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
        var dynamicdXPathCheckBoxListCollectionCSV = Umbraco.Content(dynamicPublisheddXPathCheckBoxListCSV);
        foreach (var item in dynamicdXPathCheckBoxListCollectionCSV)
        {     
            <p>@item.Name</p>         
        }       
    }

##Razor Macro (DynamicNode) Example

For XML data storage (This example returns a DynamicNodeList so that filtering and ordering can be used):

	@using umbraco; 
	@{
	    if (Model.HasValue("xPathCheckBoxListXML"))
	    {
	        int[] nodeList = uQuery.GetXmlIds(Model.xPathCheckBoxListXML.ToXml());      
	        IEnumerable<DynamicNode> PublishedNodeList = Library.NodesById(nodeList.ToList());        
	        PublishedNodeList = PublishedNodeList.Where(x => x.GetType() != typeof(DynamicNull) && x.Id > 0);
	        dynamic xPathCheckBoxListXML = new DynamicNodeList(PublishedNodeList);
	        if (xPathCheckBoxListXML.Any())
	        {
	            foreach (var item in xPathCheckBoxListXML.Where("Visible"))
	            {                   
	                <p>@item.Name</p>      
	            }               
	        }
	    } 
	}

For CSV data storage (This example returns a DynamicNodeList so that filtering and ordering can be used):

	@{
	    if (Model.HasValue("xPathCheckBoxListCSV"))
	    {
	        IEnumerable<DynamicNode> PublishedNodeList = Library.NodesById(Model.xPathCheckBoxListCSV.Split(','));        
	        PublishedNodeList = PublishedNodeList.Where(x => x.GetType() != typeof(DynamicNull) && x.Id > 0);
	        dynamic xPathCheckBoxList = new DynamicNodeList(PublishedNodeList);
	        if (xPathCheckBoxList.Any())
	        {
	            foreach (var item in xPathCheckBoxList.Where("Visible"))
	            {                   
	                <p>@item.Name</p>      
	            }               
	        }
	    } 
	}

##XSLT Macro Example

For XML data storage:

	<xsl:if test="string-length($currentPage/xPathCheckBoxListXML) > 0">
	  <xsl:for-each select="$currentPage/xPathCheckBoxListXML/XPathCheckBoxList/nodeId">
	    <xsl:variable name="currentnode" select="umbraco.library:GetXmlNodeById(.)" />
	    <!-- render only published and visible nodes -->
	    <xsl:if test="count($currentnode/error) = 0 and string($currentnode/umbracoNaviHide) != '1'">
	      <p><xsl:value-of select="$currentnode/@nodeName" /></p>
	    </xsl:if>
	  </xsl:for-each>
	</xsl:if>

For CSV data storage:

	<xsl:if test="string-length($currentPage/xPathCheckBoxListCSV) > 0">  
	  <xsl:variable name="items" select="umbraco.library:Split($currentPage/xPathCheckBoxListCSV,',')" />  
	  <xsl:for-each select="$items//value">
	    <xsl:variable name="currentnode" select="umbraco.library:GetXmlNodeById(.)" />
	    <!-- render only published nodes -->
	    <xsl:if test="count($currentnode/error) = 0 and string($currentnode/umbracoNaviHide) != '1'">  
	        	<p><xsl:value-of select="$currentnode/@nodeName" /></p>
	    </xsl:if>                       
	  </xsl:for-each>     
	</xsl:if>

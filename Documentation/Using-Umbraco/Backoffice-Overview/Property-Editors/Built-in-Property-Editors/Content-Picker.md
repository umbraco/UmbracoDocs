#Content Picker

`GUID 158aa029-24ed-4948-939e-c3da209e5fba`

`Returns: Node ID`

The content picker opens a simple modal to pick a specific page from the content structure. The value saved is the selected nodes's ID. 

##Data Type Definition Example

![Approved Color Data Type Definition](images/Content-Picker-DataType.jpg?raw=true)

##Content Example

![Approved Color Data Type Definition](images/Content-Picker-Content.jpg?raw=true)

##XSLT Example

	<xsl:if test="number($currentPage/contentPicker) > 0">  
	  <a href="{umbraco.library:NiceUrl($currentPage/contentPicker)}">
	    <xsl:value-of select="umbraco.library:GetXmlNodeById($currentPage/contentPicker)/@nodeName"/>
	  </a>
	</xsl:if>

##Razor (DynamicNode) Example

	@{
	  var node = @Library.NodeById(@Model.contentPicker);
	  <a href="@node.Url">@node.Name</a>
	}
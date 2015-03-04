#Understanding "currentPage"
As mentioned on the previous page, the currentPage parameter is important for us in Umbraco.  It is the complete XML document of the published site, and is how we reference the data stored in each document.  By default, the context of the XML document is set to the requested page.

In XSLT, to reference the parameter, and other variable types, we use the "$" and the name of the variable or parameter, thus $currentPage.  However, before we use this parameter, we need to know what is in the XML document, and how to reference the content.

XML is referenced in XSLT through the use of XPATH, a query syntax that resembles that of DOS file commands.  Since XML has the ability to contain various levels of information, XPATH has means to traverse these levels, and retrieve data based upon the current context.  But again, before we can use XPATH, we must know what is in the XML document.

The XML document, as mentioned before, contains all the content of the published documents.  This data is stored in the XML document structured in the same manner as your tree is laid out in Umbraco.  So, documents are nested to create the hierarchy that we can easily use.Each document in

Umbraco consists of several common pieces of data, and they are:

- id
- version
- parentID
- level
- writerID
- creatorID
- nodeType
- template
- sortOrder
- createDate
- updateDate
- nodeName
- urlName
- writerName
- creatorName
- nodeTypeAlias
- path

These are store as attributes of the document, which is called "node".  The properties that are added to the document in Umbraco, and what the user edits are referenced as "data".  Data consists of a couple common pieces of data, which are attributes on the data elements.  These are:

- alias
- versionID

This is structured similar to the following in the XML document.

	<!DOCTYPE umbraco [
	<!ELEMENT nodes ANY>
	<!ELEMENT node ANY>
	<!ATTLIST node id ID #REQUIRED>
	]>
	<root id="-1">
		<node
			id="numeric-value"
			version="guid-value"
			parentID="numeric-value"
			level="numeric-value"
			writerID="numeric-value"
			creatorID="numeric-value"
			nodeType="numeric-value"
			template="numeric-value"
			sortOrder="numeric-value"
			createDate="datetime-value"
			updateDate="datetime-value"
			nodeName="text-value"	
			urlName="text-value"
			writerName="text-value"
			creatorName="text-value"
			nodeTypeAlias="text-value"
			path="csv-numeric-value">
			<data
				versionID="guid-value"
				alias="text-value">
				field-value or  <![CDATA[field-value]]>
			</data>
			<data ...>...</data>
			<node ...>...</node>
		</node>
		<node ...>...</node>
	</root>
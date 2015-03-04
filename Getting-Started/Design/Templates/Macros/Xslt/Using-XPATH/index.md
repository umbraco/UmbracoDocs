#Using XPATH
Now that we know what is stored in the XML, and know where the XML is in our XSLT, we can now try to retrieve the data, and format it to our needs.

As previous mentioned, XSLT uses an XML structure to define the processing rules.  So we need to learn what a few of the processing elements for XSLT are.

**Displaying content from the XML document**

First, one of the most important elements is the "value-of" command.  It is written as follows:

	<xsl:value-of select="...."/>

This command is one of the most prevalent, and has a couple additional attributes to allow for the output to be controlled as needed.  We will look into that later.

In the template area of the XSLT file, we can write our first output now using the value-of  command.  We know our data is in the $currentPage parameter, and its context is focused on the requested page's node.  Thus, if we want to get the name of the current page, we can use the "nodeName" attribute of the node to display the name.  Attributes are referenced in XPATH using the "@" with the name of the attribute following, thus "@nodeName

	<xsl:template match="/">
		<xsl:value-of select="$currentPage/@nodeName"/>
	</xsl:template>

To explain, the "$currentPage" is looking at the node in the XML document for the current requested page.  The "/" is telling us to look at all child elements and attributes.  The "@nodeName" says we want the attribute named "nodeName".

Placing the macro on a template would render the name of the current page when the template is displayed.

Going a bit deeper, we may want to display user input content, such as a simple text field named "Website".  This is set up in the document type as a text field with the alias "Website".  Since this is not a default property, it is referenced using the data element, which there may be multiple of, depending on the number of custom properties on the document type.  Thus, referencing this property, our template would look like this:

	<xsl:template match="/">
		<xsl:value-of select="$currentPage/data[@alias='Website']"/>
	</xsl:template>

To explain, we are again focused on the child elements of the current page, which we select the ones that have the element name of "data".  We go one step further, and filter that selection with the usage of "[@alias = 'Website']", which is called a predicate.

The predicate acts as a filter, only returning the results that match the test specified.  In this case, only returning the data element that has an "alias" attribute with the value of "Website".

The results are then passed along to the next item that selects the child items, and we return the text of this element.  (The "/text()" is optional, but typically helps some understand the context of their statement.)

Now that we can list out the data from our documents, it is time to go deeper.

**Note: I have copied the original book from Casey Neehouse from the books section of umbraco.org**
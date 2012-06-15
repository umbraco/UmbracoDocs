#The Basics
The standard XSLT file consists of a few different parts. Understanding these parts will allow you to do much more with XSLT than you probably realize.

First, we have the XML declaration, since XSLT is structured off of XML. Then follows various entries at the top of the file - think of this a boilerplate code; Unless you are adding customized functions to your XSLT, this will typically not be edited.

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
	<xsl:stylesheet
    	version="1.0"
	    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	    xmlns:umbraco.library="urn:umbraco.library"
    	exclude-result-prefixes="msxml umbraco.library">
	<xsl:output method="xml" omit-xml-declaration="yes" />

Next, we have a parameter declaration that is very important to us as it is the default link to the content published in the site.  This parameter contains all the data in the site, but is focused on the current page that is loaded.  Thus it is named "currentPage".

	<xsl:param name="currentPage" />

Below this, we have our template.  This is the portion that is responsible for the output.

	<xsl:template match="/">
	
	
	</xsl:template>

And finally, we close out the stylesheet, since this is XML, everything must be properly structured.

	</xsl:stylesheet>

Now that we know what the basic things are here, we can look into what can be done.

**Note: I have copied the original book from Casey Neehouse from the books section of umbraco.org**
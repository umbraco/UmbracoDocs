#Extend your XSLT with custom functions
Sometimes the built-in functions aren't enough. Fortunately the XSLT-parser allows us to extend it with our own C# or Javascript code.
The following is an entire xslt-file, which is split up in parts to explain what is going on. 

Here we're telling the parser to create a new xml namespace for our functions.

	<?xml version="1.0" encoding="UTF-8"?>
	<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:msxml="urn:schemas-microsoft-com:xslt"
		xmlns:umbraco.library="urn:umbraco.library"
		xmlns:myfunctionlib="urn:myfunctionlib"
		exclude-result-prefixes="msxml umbraco.library myfunctionlib">
		<xsl:output method="xml" omit-xml-declaration="yes"/>
		<xsl:param name="currentPage"/>

Then it's time to tell the XSLT-parser to tie the script-block to our custom xml namespace (myfunctionlib).
Furthermore we're using the msxml:assembly-statement to load and prepare the System.Web namespace for use. The msxml:using statement makes the System.Web classes and methods available:

	<msxml:script implements-prefix="myfunctionlib" language="C#">
	<msxml:assembly name="System.Web"/>
	<msxml:using namespace="System.Web"/>
	<![CDATA[
	public string convertText(string text)
	{
    	string decodedStr = HttpUtility.HtmlDecode(text);
	    return decodedStr;
	}
	]]>
	</msxml:script>

The C# codeblock itself is surrounded by a <![CDATA-statement.. This is not a requirement, but generally a good idea, because it prevents the XSLT-parser from thinking it is dealing with XSLT-markup itself

	<xsl:template match="/">
		<xsl:value-of select="umbraco.library:ChangeContentType('text/xml')"/>
		<xsl:text disable-output-escaping="yes">&lt;?xml version="1.0" encoding="UTF-8"?&gt;</xsl:text>
		<Root>
			<xsl:apply-templates select="$currentPage/descendant::node/node [string(data [@alias='umbracoNaviHide']) != '1']">
			</xsl:apply-templates>
		</Root>
	</xsl:template>
	<xsl:template match="node">
		<Story>
			<xsl:value-of select="myfunctionlib:convertText(string(./data [@alias='bodyText']))" disable-output-escaping="yes"/>
		</Story>
	</xsl:template>
	
Finally we're ready to use our custom function (highlighted with bold)
#Tag cloud

If you use the Tag datatype in Umbraco V4, you can easily make an tag-cloud in XSLT:

The variable TagFactor is used to calculate the ratio between the tags.

The bold value "Umbraco" is the name of the Tag group used in the datatype.

The example below has 6 different size of tags, and the style/size of the tags in the cloud is modified through css

Please note: The page/blogpost etc where the macro is used, must take care of the requst variable ?tag=something

	<?xml version="1.0" encoding="UTF-8"?>
	
	<!DOCTYPE xsl:Stylesheet [ <!ENTITY nbsp "&#x00A0;">]> <xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:msxml="urn:schemas-microsoft-com:xslt"
		xmlns:umbraco.library="urn:umbraco.library"
		xmlns:tagsLib="urn:tagsLib" xmlns:Exslt.ExsltMath = "urn:Exslt.ExsltMath" 
		exclude-result-prefixes="umbraco.library msxml Exslt.ExsltMath tagsLib">

	<xsl:output method="xml" omit-xml-declaration="yes"/>
	<xsl:param name="currentPage"/>

	<xsl:template match="/">

		<xsl:variable name="TagFactor" select="6 div Exslt.ExsltMath:max(tagsLib:getAllTagsInGroup('Umbraco')/tags/tag/@nodesTagged)"/>
		<div class="tags">
			<xsl:for-each select="tagsLib:getAllTagsInGroup('Umbraco')/tags/tag">
				<a class="tag{round($TagFactor * @nodesTagged)}x" href="/?tag={.}">
					<xsl:value-of select="."/>
				</a> 
			</xsl:for-each>
		</div>
	</xsl:template>
	</xsl:stylesheet>
	
The CSS stylesheet:

	/* Tag Styles */
	.tags { line-height: 150%; }
	.tag6x { text-decoration: none; font-size: 22px; }
	.tag5x { text-decoration: none; font-size: 19px; }
	.tag4x { text-decoration: none; font-size: 16px; }
	.tag3x { text-decoration: none; font-size: 13px; }
	.tag2x { text-decoration: none; font-size: 10px; }
	.tag1x { text-decoration: none; font-size: 7px; }
	/* End Tag Styles */
 

Example of the tag cloud in use can be found at http://bentzen.dk (Broken Link)

Another Example at: [www.blogfodder.co.uk/.../...g-Tags-In-Umbraco.aspx](http://www.blogfodder.co.uk/2009/12/22/using-tags-in-umbraco)
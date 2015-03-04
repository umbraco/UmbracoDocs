#Getting a series of unique random numbers
If you've tried looping through subnodes to display, for example, random images - you will have noticed the propensity of most solutions to display some identical nodes.This is because most "random" solutions use a time-based seed for their random-number generation. This becomes a problem when you're requesting multiple random numbers within a very short time frame (milliseconds). The seed will be the same, and therefore the random numbers don't differ.

Umbraco's XSLT extension library has a way around this, but you need a bit of extra inline code in your XSLT to be able to take advantage of it.

The function in question is umbraco.library:GetRandom(). This isn't really useful by itself, as it only returns an object, not a number.

To take advantage of the GetRandom() method in the library, and to return a random number within a certain range, you can insert the following inline function into your XSLT file:

	<msxsl:script language="c#" implements-prefix="randomTools">
		<msxsl:assembly href="../bin/umbraco.dll"/>
		<![CDATA[
			/// <summary>
			/// Gets a random integer that falls between the specified limits
			/// </summary>
			/// <param name="lowerLimit">An integer that defines the lower-boundary of the range</param>
			/// <param name="upperLimit">An integer that defines the upper-boundary of the range</param>
			/// <returns>A random integer within the specified range</returns>
			public static int GetRandom(int lowerLimit,int upperLimit) {
				Random r = umbraco.library.GetRandom();
				int returnedNumber = 0;
				lock (r)
				{
					returnedNumber = r.Next(lowerLimit, upperLimit);
				}
				return returnedNumber;
			}
		]]>
	</msxsl:script>
	
Don't forget to add the prefix and namespace information to the <xsl:stylesheet> element. Shown below are the parts that you will need to add to your existing <xsl:stylesheet> declaration.

	<xsl:stylesheet
		xmlns:randomTools="http://www.umbraco.org/randomTools"
		exclude-result-prefixes="randomTools">

You can then generate a random number by calling the inline function. The following example will return a random number between 1 and 100:

	<xsl:value-of select="randomTools:GetRandom(1,100)"/>
	
The following example shows how to list 8 randomly-selected nodes that fall below the "current page":

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE xsl:stylesheet [
		<!ENTITY nbsp "&#x00A0;">
	]>
	<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:msxml="urn:schemas-microsoft-com:xslt"
		xmlns:msxsl="urn:schemas-microsoft-com:xslt"
		xmlns:umbraco.library="urn:umbraco.library"
		xmlns:randomTools="http://www.umbraco.org/randomTools"
		exclude-result-prefixes="msxml umbraco.library msxsl randomTools">

		<xsl:output method="xml" omit-xml-declaration="yes" />
		<xsl:param name="currentPage"/>
		<xsl:variable name="maxItems" select="number(8)" />

		<xsl:template match="/">
			<xsl:for-each select="$currentPage//node">
				<xsl:sort select="randomTools:GetRandom(0,count($currentPage//node))" order="ascending" />
				<xsl:if test="position() &lt;= $maxItems">
					<li>
						<a>
							<xsl:attribute name="href">
								<xsl:value-of select="umbraco.library:NiceUrl(@id)"/>
							</xsl:attribute>
							<xsl:value-of select="@nodeName"/>
						</a>
					</li>
				</xsl:if>
			</xsl:for-each>
		</xsl:template>
		
		<msxsl:script language="c#" implements-prefix="randomTools">
			<msxsl:assembly href="../bin/umbraco.dll"/>
			<![CDATA[
				/// <summary>
				/// Gets a random integer that falls between the specified limits
				/// </summary>
       			/// <param name="lowerLimit">An integer that defines the lower-boundary of the range</param>
				/// <param name="upperLimit">An integer that defines the upper-boundary of the range</param>
				/// <returns>A random integer within the specified range</returns>
				public static int GetRandom(int lowerLimit,int upperLimit) {
					Random r = umbraco.library.GetRandom();
					int returnedNumber = 0;
					lock (r)
					{
						returnedNumber = r.Next(lowerLimit, upperLimit);
					}
					return returnedNumber;
				}
			]]>
		</msxsl:script>
	</xsl:stylesheet>
	
The code on this page, and the GetRandom() method in umbraco.library, is based on [this blog post by Eli Robillard.](http://weblogs.asp.net/erobillard/archive/2004/05/06/127374.aspx)
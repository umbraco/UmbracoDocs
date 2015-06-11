#Populate Select box with years

A colleague asked me or it was possible to populate a Dropdown with years, to help him i wrote a small snippet, which is maybe also useful for other people.

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE xsl:stylesheet [
  	<!ENTITY nbsp "&#x00A0;">
	]>
	<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:msxml="urn:schemas-microsoft-com:xslt"
		xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets"
		exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">
	<xsl:output method="xml" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<select>
			<xsl:call-template name="getyears">
				<!--Call the function which populates the select element-->
				<xsl:with-param name="year" select="1990"/>
			</xsl:call-template>
		</select>
  	</xsl:template>
  	<xsl:template name="getyears">
    	<xsl:param name="year"/>
    	<!--Check or the yearcounter is smaller as Current year-->
    	<xsl:if test="$year &lt;= number(Exslt.ExsltDatesAndTimes:year())">
     		 <option>
        		<xsl:value-of select="$year"/>
      		</option>
      		<!--Recursive Call of the function-->
      		<xsl:call-template name="getyears">
        		<xsl:with-param name="year" select="$year + 1"/>
      		</xsl:call-template>
    	</xsl:if>
  	</xsl:template>
	</xsl:stylesheet>
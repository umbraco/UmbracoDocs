#Recursive Menu
Credits for this snippet go out to Lordtoro ([lordtoro.wordpress.com/.../](http://lordtoro.wordpress.com/2010/07/10/recursive-navigation-in-umbraco-4-5-0/))

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp " "> ]>
	<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:msxml="urn:schemas-microsoft-com:xslt"
		xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets"
		exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets">

		<xsl:output method="xml" omit-xml-declaration="yes"/>
		<xsl:param name="currentPage"/>
		<xsl:param name="level" select="1"/>
		<xsl:variable name="stopLevel" select="/macro/maxDepth"/>
		<xsl:variable name="mystartNodeId" select="/macro/startNodeId"/>
		<xsl:variable name="cssClass" select="/macro/NavigationCSSClass"/>
		<xsl:variable name="cssID" select="/macro/NavigationCSSId"/>
		<xsl:variable name="boolImageLink" select="/macro/navImageLink"/>
		<xsl:variable name="IDSelectorPrefix" select="/macro/IDPrefix"/>
		<xsl:variable name="disableNav" select="/macro/disableNav"/>

		<xsl:template match="/">
			<xsl:call-template name="menu">
				<xsl:with-param name="level" select="$level"/>
			</xsl:call-template>
		</xsl:template>

		<xsl:template name="menu">
			<xsl:param name="level"/>
			<ul class="level_{$level}">
				<xsl:if test="string($cssClass)">
					<xsl:attribute name="class">
						<xsl:value-of select="$cssClass"/> level_{$level}
						<xsl:if test="$disableNav = 1"> disabled</xsl:if>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$cssID!= ''"><xsl:attribute name="id"> <xsl:value-of select="$cssID"/></xsl:attribute></xsl:if>
				<xsl:if test="count($currentPage/ancestor::root/* [@level=$level]/* [@isDoc and string(umbracoNaviHide) != '1']) &gt; '0'">
					<xsl:for-each select="$currentPage/ancestor::root/* [@level=$level]/* [@isDoc and string(umbracoNaviHide) != '1']">
						<li>
							<a href="{umbraco.library:NiceUrl(@id)}">
								<xsl:if test="$currentPage/@id = current()/@id">
									<xsl:attribute name="class">Selected</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="@nodeName"/>
							</a>
							<xsl:if test="count(current()/* [@isDoc and string(umbracoNaviHide) != '1']) &gt; '0'">
								<xsl:call-template name="submenu">
									<xsl:with-param name="level" select="$level+1"/>
								</xsl:call-template>
							</xsl:if>
						</li>
					</xsl:for-each>
				</xsl:if>
			</ul>
		</xsl:template>

		<xsl:template name="submenu">
			<xsl:param name="level"/>

			<ul class="level_{@level}">
				<xsl:for-each select="current()/* [@isDoc and string(umbracoNaviHide) != '1']">
					<li>
						<a href="{umbraco.library:NiceUrl(@id)}">
							<xsl:if test="$currentPage/@id = current()/@id">
								<xsl:attribute name="class">Selected</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="@nodeName"/>
						</a>
						<xsl:if test="count(current()/* [@isDoc and string(umbracoNaviHide) != '1']) &gt; '0'">
							<xsl:call-template name="submenu">
								<xsl:with-param name="level" select="$level+1"/>
							</xsl:call-template>
						</xsl:if>
					</li>
				</xsl:for-each>
			</ul>
		</xsl:template>
		
	</xsl:stylesheet>
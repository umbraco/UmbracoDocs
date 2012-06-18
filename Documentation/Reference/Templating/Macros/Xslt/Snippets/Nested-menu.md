#Nested menu
I created this xslt to render a nested menu like this, the nice part is that it always starts with the parent at level 3 (even if you are at a deeper level).

	<h2>Basic Elements</h2>
	<ul class="level-1">
		<li>
			<a href="/internet/basic-elements/logo">Logo</a>
			<ul class="level-2">
				<li>
					<a href="/internet/basic-elements/logo/download-logo">Download logo</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="/internet/basic-elements/colour">Colour</a>
		</li>
		<li>
			<a href="/internet/basic-elements/typograhpy">Typograhpy</a>
			<ul class="level-2">
				<li>
					<a href="/internet/basic-elements/typograhpy/headings">Headings</a>
				</li>
				<li>
					<a href="/internet/basic-elements/typograhpy/plain-text">Plain Text</a>
				</li>
				<li>
					<a href="/internet/basic-elements/typograhpy/download-fonts">Download Fonts</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="/internet/basic-elements/copy">Copy</a>
			<ul class="level-2">
				<li>
					<a href="/internet/basic-elements/copy/tone-of-voice">Tone of Voice</a>
				</li>
			</ul>
		</li>
		<li>
			<a href="/internet/basic-elements/photography">Photography</a>
		</li>
	</ul>

This is the XSLT:

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE xsl:Stylesheet [
		<!ENTITY nbsp "&#x00A0;">
	]>
	<xsl:stylesheet
		version="1.0"	
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:msxml="urn:schemas-microsoft-com:xslt"
		xmlns:umbraco.library="urn:umbraco.library"
		exclude-result-prefixes="msxml umbraco.library">
		
		<xsl:output omit-xml-declaration="yes" indent="yes" encoding="utf-8"/>
		<xsl:param name="currentPage"/>
		
		<xsl:template match="/">
			<xsl:variable name="pageId" select="$currentPage/@id"/>
			<xsl:variable name="parentElement" select="$currentPage/ancestor-or-self::node[@level=3]"/>
			
			<h2>
				<xsl:value-of select="$parentElement/@nodeName"/>
			</h2>
			
			<ul class="level-1">
				<xsl:for-each select="$parentElement//descendant::node [string(data[@alias='umbracoNaviHide']) != '1'][@level=4][@nodeTypeAlias='Content_Item']">
					<li>
						<a href="{umbraco.library:NiceUrl(@id)}">
							<xsl:value-of select="@nodeName"/>
						</a>
						<xsl:call-template name="RenderSubfolder">
							<xsl:with-param name="parent" select="."/>
						</xsl:call-template>
					</li>
				</xsl:for-each>
			</ul>
			
		</xsl:template>
		
		<xsl:template name="RenderSubfolder">
			<xsl:param name="parent"/>
			
			<xsl:if test="count($parent/descendant::node [string(data[@alias='umbracoNaviHide']) != '1'][@nodeTypeAlias='Content_Item']) &gt; 0">
				<ul class="level-2">
					<xsl:for-each select="$parent/descendant::node [string(data[@alias='umbracoNaviHide']) != '1'][@nodeTypeAlias='Content_Item']">
						<li>
							<a href="{umbraco.library:NiceUrl(@id)}">
								<xsl:value-of select="@nodeName"/>
							</a>
						</li>
					</xsl:for-each>
				</ul>
			</xsl:if>
		</xsl:template>
		
	</xsl:stylesheet>
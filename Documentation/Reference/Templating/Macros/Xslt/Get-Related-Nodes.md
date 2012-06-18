#Get Related Nodes
Get nodes related to the current page

	<xsl:variable name="relations" select="umbraco.library:GetRelatedNodesAsXml($currentPage/@id)//relation[@parentId = $currentPage/@id]"/>

	<ul>
		<li class="header">Alternative languages</li>
		<xsl:for-each select="$relations">
			<xsl:variable name="url" select="umbraco.library:NiceUrl(@childId)" />
			<xsl:if test="$url != ''">
				<li><a href="{$url}"><xsl:value-of select="./node/@nodeName" /></a></li>
			</xsl:if>
		</xsl:for-each>
	</ul>
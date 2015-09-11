#Some XSLT Logic
XSLT has some logic commands that are useful to processing criteria based output.  These commands are the "if" and "choose" commands.

The "if" command is useful for deciding to show content or not based on a single criteria.  There is no "else" in XSLT, so, the if is somewhat limited.

	<xsl:if test="@nodeName = 'example' ">
		<!-- do this -->
	</xsl:if>
	
The "choose" command is a bit more powerful in that it allows for multiple choices to be selected from.

	<xsl:choose>
		<xsl:when test="@nodeName = 'example' ">
			<!-- do this -->
		</xsl:when>
		<xsl:otherwise>
			<!-- do this -->
		</xsl:otherwise>
	</xsl:choose>
	
In this example, you can have as many when statements as you like, but must have the otherwise statement.

**Note: I have copied the original book from Casey Neehouse from the books section of umbraco.org**
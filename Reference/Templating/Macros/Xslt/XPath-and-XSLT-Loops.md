#XPath and XSLT Loops

Another useful command in XSLT is the "for-each" command.  This command takes an XPATH statement and iterates the results for each match, executing the nested commands each time.  The "for-each" command looks as follows:

	<xsl:for-each select="....">
		...
	</xsl:for-each>

So using this command, we can select multiple items and list them out with a very simple call.

Lets say that our current page has 5 sub-pages, named one, two, three, four, and five.  We want to list those 5 pages names on the current page.  Thus, we need to loop through the child nodes of the current page.

	<xsl:for-each select="$currentPage/node">
		<xsl:value-of select="@nodeName"/>
	</xsl:for-each>

To explain, we are selecting all child node elements from the current page, looping each node.  The value-of is selecting only the attribute named @nodeName.

Confused?  Don't be. The value-of inherits the context of the for-each command, thus, it knows it is on the current node in the loop.  If that confuses you too much, you can always write the statement as such:

	<xsl:for-each select="$currentPage/node">
		<xsl:value-of select="current()/@nodeName"/>
	</xsl:for-each>
	
or

	<xsl:for-each select="$currentPage/node">
		<xsl:value-of select="./@nodeName"/>
	</xsl:for-each>

Using "current()/" allows you to easily see that you are working against the current item in the loop, and the "./" notation is actually saying select myself.

The resultant output of this will be the five pages listed without any markup, which will be rather difficult to read.  So, lets add some unordered list markup for usage in our website.

	<ul>
		<xsl:for-each select="$currentPage/node">
			<li><xsl:value-of select="current()/@nodeName"/></li>
		</xsl:for-each>
	</ul>
	
Now, we will get bulleted list of page names.

**Note: I have copied the original book from Casey Neehouse from the books section of umbraco.org**
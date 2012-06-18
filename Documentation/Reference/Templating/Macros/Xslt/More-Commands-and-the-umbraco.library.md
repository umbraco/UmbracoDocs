#More Commands and the umbraco.library
There are many additional commands in the XSLT arsenal, but some of the most powerful aspects are those provided by Umbraco itself.  Umbraco implements [a library of useful items](http://our.umbraco.org/wiki/reference/umbracolibrary) that can be called in XSLT.  There are many commands, which I will cover a few, and reference the rest.

One of the most prevalent library methods is that of NiceUrl.  NiceUrl is the method that is used to generate all the friendly URLs used in the site.  To use the NiceUrl function, we will continue the list of child pages before, and make them linked.

	<ul>
		<xsl:for-each select="$currentPage/node">
			<li>
				<a>
					<xsl:attribute name="href">
						<xsl:value-of select="umbraco.library:NiceUrl(current()/@id)"/>
					</xsl:attribute>
					<xsl:value-of select="current()/@nodeName"/>
				</a>
			</li>
		</xsl:for-each>
	</ul>
	
or

	<ul>
		<xsl:for-each select="$currentPage/node">
			<li>
				<a href="{umbraco.library:NiceUrl(current()/@id)}">
					<xsl:value-of select="current()/@nodeName"/>
				</a>
			</li>
		</xsl:for-each>
	</ul>
	
The first example is more verbose than the second, as the second uses the shortcut method of including commands inside existing tags such as the anchor (a) tag.  The first example uses the xslt commands to inject the attribute into the preceding tag

To explain, the umbraco.library:NiceUrl method is receiving the id of the current node in the loop, and returns the URL, which is then rendered in the href of the a tag.

Using other methods from the umbraco.library is just as simple.

**Note: I have copied the original book from Casey Neehouse from the books section of umbraco.org**
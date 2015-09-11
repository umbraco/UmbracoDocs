#Using Variables and Parameters

Variables and parameters are temporary storage devices in XSLT for holding simple values to complete node sets of data.

Variables are defined with a name, and can be filled two different ways.  The first method is to select the data into the variable as follows:

	<xsl:variable name="myID" select="$currentPage/@id"/>

The second method is to fill the variable by having the content rendered into the variable.

	<xsl:variable name="myID">
		<xsl:value-of select="$currentPage/@id"/>
	</xsl:variable>
	
The second method is useful when applying logic to filling the variable, in which case an if command or choose command would allow you to have the value selected logically.

Parameters are handled the same way, except their command is "xsl:param".

As for the difference, it is a matter of where they can be assigned.

**Note: I have copied the original book from Casey Neehouse from the books section of umbraco.org**
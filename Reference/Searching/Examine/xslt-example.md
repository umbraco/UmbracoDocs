# Using Examine with XSLT

The XSLT implementation of Examine requires a little bit of setup. The steps are outlined below.

1. Add the Examine xslt extensions to the xslt config in file ~/Config/XsltExtensions.config

    `<ext assembly="UmbracoExamine" type="UmbracoExamine.XsltExtensions" alias="Examine" />`

2. In your Xslt for your macro ensure to add the namespace:
	
    `xmlns:Examine="urn:Examine"`

3. And then ensure that you add "Examine" to the exclude-result-prefixes value, so the attribute might look something like:

    `exclude-result-prefixes="Examine umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">`

Now we can use the Examine xslt extensions in our xslt. This will render the exact same results as the above 3 examples:

  	<xsl:template match="/">
	    <xsl:if test="umbraco.library:Request('query') != ''">
	      <ul>
	        <xsl:for-each select="Examine:Search(umbraco.library:Request('query'))//node">
	          <li>
	            <a href="{umbraco.library:NiceUrl(@id)}">
	              <xsl:value-of select="./data[@alias='nodeName']"/>
	            </a>
	          </li>
	        </xsl:for-each>
	      </ul>
	    </xsl:if>
	  </xsl:template>
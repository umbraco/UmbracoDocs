---
keywords: examine indexing v7
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Using Examine with XSLT

The XSLT implementation of Examine requires a little bit of setup. The steps are outlined below.

Now we can use the Examine XSLT extensions in our XSLT. This will render the exact same results as the above 3 examples:

```xml
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
```

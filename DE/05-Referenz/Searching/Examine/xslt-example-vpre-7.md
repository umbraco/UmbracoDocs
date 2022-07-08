---
keywords: examine indexing v4.5 v6
versionFrom: 4.5.0
versionTo: 6.2.6
---

# Using Examine with XSLT

The XSLT implementation of Examine requires a little bit of setup. The steps are outlined below.

1. Add the Examine XSLT extensions to the XSLT config in file ~/Config/XsltExtensions.config

```xml
<ext assembly="UmbracoExamine" type="UmbracoExamine.XsltExtensions" alias="Examine" />
```

2. In your XSLT for your macro ensure to add the namespace:

```xml
xmlns:Examine="urn:Examine"
```

3. And then ensure that you add "Examine" to the exclude-result-prefixes value, so the attribute might look something like:

```xml
exclude-result-prefixes="Examine umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">
```

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

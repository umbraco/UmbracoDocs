#NiceUrl

Use this to return a 'Friendly URL' for a given node in the Umbraco content section. A 'Friendly URL' is the complete encoded URL excluding the domain.

**Please note:** When the `RequestHandler` is set to `useDomainPrefixes=true` in [UmbracoSettings.config](https://our.umbraco.org/documentation/Reference/Config/umbracoSettings/), NiceUrl returns the url including the domain.

##Simple NiceUrl XSLT Example

    <xsl:value-of select="umbraco.library:NiceUrl($currentPage/../@id)" />

This example will return the friendly url for the Parent page that is currently being viewed.

##NiceUrl example used in an anchor tag:

This example shows how to use this to build a link to this page:

    <a>
     <xsl:attribute name="href">
      <xsl:value-of select="umbraco.library:NiceUrl($currentPage/../@id)" />
     </xsl:attribute>
     <xsl:value-of select="$currentPage/../@nodeName" />
    </a>

Or it can be written using the short hand version:

    <a href="{umbraco.library:NiceUrl($currentPage/../@id)}">
     <xsl:value-of select="$currentPage/../@nodeName" />
    </a>

Both of the above statements used on this page will produce:

    <a href="/link/to/node">Name of node</a

#List all subpages below current, vb in xslt.

Here's yet another sample with vb in xslt. I believe many vb-coders feel xslt is a bit hard to get used to, I know I do. The flexibility of umbraco, xslt and .net let vb-coders still use their "mother tongue" even for ui-editable macros.

Edit: This is considered to be bad practice, and I guess the recommendation should be : use this as a quick way of adding functions in c# or vb, but move the code to .dll's asap, for example into xslt extensions. [our.umbraco.org/.../6508-VB-or-C](http://our.umbraco.org/forum/developers/xslt/6508-VB-or-C#-within-xslt-xslt-only-used-for-the-call-bad-practice)

	<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:msxml="urn:schemas-microsoft-com:xslt"
		xmlns:msxsl="urn:schemas-microsoft-com:xslt"
		xmlns:vb="urn:mycompany.com:xslt"
		xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" 
		exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets vb">

		<xsl:output method="xml" omit-xml-declaration="yes"/>

		<xsl:param name="currentPage"/>

		<xsl:template match="/">
			<xsl:value-of select="vb:listAllSubNodes($currentPage/@id)" disable-output-escaping="yes"/>
		</xsl:template>
		
		<!-- =================== Script definition and VB code section =========================-->
		<msxsl:script language="VB" implements-prefix="vb">
        <msxml:assembly name="BusinessLogic"/>
        <msxml:assembly name="cms"/>
        <msxml:assembly name="umbraco"/>
        <msxml:using namespace="System.Web"/>
        <msxml:using namespace="umbraco.BusinessLogic"/>
        <msxml:using namespace="umbraco.cms.businesslogic.web"/>
        <msxml:using namespace="umbraco.presentation.nodeFactory"/>
        
        <![CDATA[

        ' =============================================================================
        ' Listing nodes with fast in-memory node factory

        Public Function listAllSubNodes(nodeId as Integer) as string
                Dim myNode = New Node(nodeId)
                dim t as new text.stringbuilder
                if myNode.Children.Count>0 then 
                t.append("<ul>")
                for each nn as Node in myNode.Children
                        dim umbracoNaviHide as boolean=false
                        if not (nn.GetProperty("umbracoNaviHide") is nothing) then
                                if nn.GetProperty("umbracoNaviHide").Value="1" then umbracoNaviHide=true
                        end if
                        if not umbracoNaviHide then
                                t.append("<li>")
                                t.append(nn.Name)
                                if nn.Children.Count>0 then t.append(listAllSubNodes(nn.Id))
                                t.append("</li>")
                        end if
                next nn
                t.append("</ul>")
                end if
                Return t.tostring()
        End Function

        ' End of good ol' VB
        '
        ' =============================================================================

        ]]>
        </msxsl:script>

	</xsl:stylesheet>
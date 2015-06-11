#List all document types and generic properties

I needed a list of all document types and their properties in an installation. The quick and dirty way I came up with was to create a VB-function and call it from within a xslt:

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
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
		
		<!-- ========= The template with only a call to a VB-function ==================== -->

		<xsl:template match="/">
			<xsl:value-of select="vb:listDocumentTypes()" disable-output-escaping="yes" />
		</xsl:template>
		
		<!-- =================== Script definition and VB code section ========================== -->
		
		<msxsl:script language="VB" implements-prefix="vb">
        <msxml:assembly name="BusinessLogic"/>
        <msxml:assembly name="cms"/>
        <msxml:assembly name="umbraco"/>
        <msxml:using namespace="System.Web"/>
        <msxml:using namespace="umbraco.BusinessLogic"/>
        <msxml:using namespace="umbraco.cms.businesslogic.web"/>
        <msxml:using namespace="umbraco.presentation.nodeFactory"/>
        <msxml:using namespace="System.Collections.Generic"/>
        <msxml:using namespace="umbraco.cms.businesslogic.propertytype"/>
        
        <![CDATA[

        ' =============================================================================
        '
        ' Everything here is plain VB.Net - code

        Public Function listDocumentTypes() as string
                dim d as List(of DocumentType)

                dim t as new text.stringbuilder
                d = DocumentType.GetAllAsList
                t.append("<ul>")
                for each dd as DocumentType in d
                        t.append("<li>")
                        t.append("<strong>")
                        t.append(dd.Text)
                        t.append("</strong>")
                        t.append(" (")
                        t.append(dd.Alias)
                        t.append(")")
                        t.append("<br/>")
                        t.append(dd.Description)
                        t.append("<br/>")
                        dim p as new List(of PropertyType)
                        p=dd.PropertyTypes
                        t.append("<ul>")
                        for each pp as PropertyType in p
                                t.append("<li>")
                                t.append("<strong>")
                                t.append(pp.Name)
                                t.append("</strong>")
                                t.append(" (")
                                t.append(pp.Alias)
                                t.append(")")
                                t.append(" : ")
                                t.append(pp.DataTypeDefinition.Text)
                                t.append("<br/>")
                                t.append(pp.Description)
                                t.append("</li>")
                        next pp
                        t.append("</ul>")
                        t.append("</li>")
                next dd
                t.append("</ul>")

                Return t.tostring()
                
        End Function

        ' End of good ol' VB
        '
        ' =============================================================================

        ]]>
        </msxsl:script>
		
	</xsl:stylesheet>
#XSLT-snippet for VB-coders

There's a coveniant way to add VB-code directly in the Umbraco UI, as a XSLT-macro. Just add a new empty XSLT-file and paste this snippet.

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

		<!--

     ====================================================================================

        This is a sample of how to use VB-code in a XSLT-macro in
        Umbraco. A conveniant way to quickly add code.
 
        You need to add xmlns:vb="urn:mycompany.com:xslt" and 
        exclude-result-prefixes="vb" to the stylesheet element, as above

        Also you need to reference all assemblies and namespaces you
        are going to use, as below.
 
     ====================================================================================

	-->

	<!-- ========= The template with only a sample call to a VB-function ==================== -->

		<xsl:template match="/">
			<xsl:value-of select="vb:nodeFactoryDemo($currentPage/@id)"/>
		</xsl:template>

	<!-- =================== Script definition and VB code section ==========================

        Added a few useful assemblies and namespaces. 
        For reference see Umbraco API documentation, http://umbraco.org/documentation

     ====================================================================================
		-->

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
        '
        ' Everything here is plain VB.Net - code

        Public Function nodeFactoryDemo(nodeId as Integer)
                Dim myNode = New Node(nodeId)
                Return myNode.url
        End Function

        Public Function helloWorld()
                Return "Hello World"
        End Function

        ' End of good ol' VB
        '
        ' =============================================================================

        ]]>
        </msxsl:script>

	</xsl:stylesheet>
	
Happy coding / joeriks
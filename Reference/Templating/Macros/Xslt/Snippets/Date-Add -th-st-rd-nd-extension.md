#Date - Add 'th, st, rd, nd' extension
Here's a really simple snippet which adds the correct extension to the date.

	<xsl:variable name="dte" select="data [@alias = 'contentDate']"/>
	<xsl:variable name="endings" select="umbraco.library:Split('st,nd,rd,th,th,th,th,th,th,th,th,th,th,th,th,th,th,th,th,th,st,nd,rd,th,th,th,th,th,th,th,st',',')"/>
	<xsl:value-of select="concat(umbraco.library:FormatDateTime($dte,'MMMM d'),$endings/value[number(substring($dte,9,2))]/text(),', ',substring($dte,1,4))"/>
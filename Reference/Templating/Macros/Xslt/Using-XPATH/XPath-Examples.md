#XPath Examples

Below are some simple examples that demonstrate the use of XPath. All examples are evaluated against the following XML:

	<?xml version="1.0" encoding="utf-8"?>
	<Catalog>
	    <Album artist="The Last Shadow Puppets" title="The Age Of The Understatement">
        	<Track rating="4" length="P3M7S">The Age Of The Understatement</Track>
	        <Track rating="3" length="P2M18S">Standing Next To Me</Track>
    	    <Track rating="5" length="P2M26S">Calm Like You</Track>
        	<Track rating="3" length="P3M38S">Separate and Ever Deadly</Track>
	        <Track rating="2" length="P2M37S">The Chamber</Track>
    	    <Track rating="3" length="P2M44S">Only The Truth</Track>
	    </Album>
    	<Album artist="Kings Of Leon" title="Because Of The Times">
        	<Track rating="4" length="P7M10S">Knocked Up</Track>
	        <Track rating="2" length="P2M57S">Charmer</Track>
    	    <Track rating="3" length="P3M21S">On Call</Track>
        	<Track rating="4" length="P3M09S">McFearless</Track>
	        <Track rating="1" length="P3M59S">Black Thumbnail</Track>
    	</Album>
	</Catalog>

###//Album

	<Album artist="The Last Shadow Puppets" title="The Age Of The Understatement">
        <Track rating="4" length="P3M7S">The Age Of The Understatement</Track>
        <Track rating="3" length="P2M18S">Standing Next To Me</Track>
        <Track rating="5" length="P2M26S">Calm Like You</Track>
        <Track rating="3" length="P3M38S">Separate and Ever Deadly</Track>
        <Track rating="2" length="P2M37S">The Chamber</Track>
        <Track rating="3" length="P2M44S">Only The Truth</Track>
    </Album>
    <Album artist="Kings Of Leon" title="Because Of The Times">
        <Track rating="4" length="P7M10S">Knocked Up</Track>
        <Track rating="2" length="P2M57S">Charmer</Track>
        <Track rating="3" length="P3M21S">On Call</Track>
        <Track rating="4" length="P3M09S">McFearless</Track>
        <Track rating="1" length="P3M59S">Black Thumbnail</Track>
    </Album>

###//Album/@title

	title="The Age Of The Understatement"
	title="Because Of The Times"

###//Album\[@artist="Kings Of Leon"]

	<Album artist="Kings Of Leon" title="Because Of The Times">
		<Track rating="4" length="P7M10S">Knocked Up</Track>
		<Track rating="2" length="P2M57S">Charmer</Track>
		<Track rating="3" length="P3M21S">On Call</Track>
		<Track rating="4" length="P3M09S">McFearless</Track>
		<Track rating="1" length="P3M59S">Black Thumbnail</Track>
	</Album>

###//Track\[../@artist='The Last Shadow Puppets']

	<Track rating="4" length="P3M7S">The Age Of The Understatement</Track>
	<Track rating="3" length="P2M18S">Standing Next To Me</Track>
	<Track rating="5" length="P2M26S">Calm Like You</Track>
	<Track rating="3" length="P3M38S">Separate and Ever Deadly</Track>
	<Track rating="2" length="P2M37S">The Chamber</Track>
	<Track rating="3" length="P2M44S">Only The Truth</Track>

###//Track\[@rating >= 4]

	<Track rating="4" length="P3M7S">The Age Of The Understatement</Track>
	<Track rating="5" length="P2M26S">Calm Like You</Track>
	<Track rating="4" length="P7M10S">Knocked Up</Track>
	<Track rating="4" length="P3M09S">McFearless</Track>
	<Track rating="1" length="P3M59S">Black Thumbnail</Track>

###//Track/text()

	The Age Of The Understatement
	Standing Next To Me
	Calm Like You
	Separate and Ever Deadly
	The Chamber
	Only The Truth
	Knocked Up
	Charmer
	On Call
	McFearless
	Black Thumbnail

##How does this apply to Umbraco?

In Umbraco, we usually apply these XPath expressions to a variable or parameter such as $currentPage, or a custom variable that contains an XML node set.

###To list all nodes below the current page that match nodeTypeAlias="Article", we could do the following:

	<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
	<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:msxml="urn:schemas-microsoft-com:xslt"
		xmlns:umbraco.library="urn:umbraco.library" 
		exclude-result-prefixes="msxml umbraco.library ">

		<xsl:output method="xml" omit-xml-declaration="yes"/>

		<xsl:param name="currentPage"/>

		<xsl:template match="/">
    		<ul>
				<xsl:apply-templates select="$currentPage//node [@nodeTypeAlias = 'Article']"/>
			</ul>
		</xsl:template>
	
		<xsl:template match="node">
			<li>
				<xsl:value-of select="./@nodeName"/>
			</li>
		</xsl:template>
	</xsl:stylesheet>

For more information, see the following pages:

- [MSDN XPath Examples](http://msdn.microsoft.com/en-us/library/ms256086.aspx)
- [knol XPath article](http://knol.google.com/k/jackie-sprott/xpath/2i2dcklqevrpq/6) - This is where the XML sample data came from
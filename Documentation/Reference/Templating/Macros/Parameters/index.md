#Macro parameters

_Macro parameters are in short a value you send to a Macro from Umbraco. This could be piece of text, a node ID or even a big chunk of xml. To do this you have a handful of different form controls you can use_

##Default macro parameter types

- bool - A true/false value
- contentPicker - the ID of the selected node as a single integer
- contentRandom - the xml from a random node
- contentTree - the xml of the selected node and its child nodes
- contentType - the alias of a selected content type as a string
- contentTypeMultiple - a comma separated list of selected content type aliases
- mediaCurrent - the xml of the selected media item
- number - an integer
- propertyTypePicker - the alias of the selected property type
- propertyTypePickerMultiple - a comma separated list of selected property type aliases 
- tabPicker - the caption of the selected tab
- tabPickerMultiple - a comma separated list of selected tab captions
- text - a text string
- textMultiline - a text string

##Setting up the macro parameter
First let's create a simple xslt script which will have 2 simple parameters, a text string and a contentTree type - to recap: A text type is a simple string and a contentTree type is the xml of a selected node.

##Adding the parameters
- Create a xslt macro.
- Look under the "parameters" tab on the macro settings screen.
- Create a new parameter the alias "text" name "Text property" and type "text".
- Create a second parameter called "contentTree" with the name "Select Node" and the type "contentTree".
 

##Writing some basic xslt 
Okey so now we have a macro with some parameters. Let's get these parameters into the xslt. 

Our Xslt code (without the stylesheet info):

	<xsl:template match="/">
	  <xsl:copy-of select="/macro/text"/>
	  <xsl:copy-of select="/macro/contentTree"/> 
	</xsl:template>

##Working with parameters in XSLT
Okey so far we've set up a simple xslt script, added 2 parameters and picked some simple data for the parameters when we inserted the macro in a template. 

So what does the 2 parameters return?
The `<xsl:copy-of select="/macro/text" />` returns:

	<text>Hello World</text>

The `<xsl:copy-of select="/macro/contentTree" />` returns:

	<contentTree nodeID="1053">
		<node id="1053" version="a1e061ab-3109-4690-9374-bd0f05882e9b" 
			parentID="1052" level="2" writerID="0" creatorID="0" 
			nodeType="1044" template="1043" sortOrder="1" 
			createDate="2005-12-30T14:01:21" updateDate="2007-06-21T14:06:32" 
			nodeName="About" urlName="about" writerName="Administrator" 
			creatorName="Administrator" nodeTypeAlias="wwTextpage" 
			path="-1,1052,1053">
				<data alias="bodyText">Body text...</data>
				<data alias="header">My Header text...</data>
		</node>
	</contentTree>
	
So as you can see: the text parameter simply sends the text string we entered to the macro and the contentTree parameter sends a big chunk of xml describing the node we selected. If the node had any child nodes these would also be send to the xslt macro as xml.

##Explaining how the parameters are send to the macro
When you set up a macro parameter for a xslt macro, you basically tell Umbraco to send some xml to the xslt script. This xml looks something like this: 

	<macro>
		<parameteralias1>Value</parameteralias1>
		<parameteralias2>Value</parameteralias2>
	</macro>
	
So with this information along with some basic xpath we can query the xml from the parameters. Which is what are doing with "/macro/text" which will get the value from the "text" parameter and the "/macro/contentTree" which will get the value of the parameter with the alias "contentTree" we could then go on a do some basic xpath work on the contentTree macro to return the selected nodes name like this:

	<xsl:value-of select="/macro/contentTree/node/nodeName"/> 

or get its bodyText value with

	<xsl:value-of select="/macro/contentTree/node/data [@alias = 'bodyText']"/>
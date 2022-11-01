---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Macro parameters in XSLT

## Setting up the macro parameter
First let's create an xslt script which will have 2 parameters, a text string and a contentTree type.

To recap: A text type is a string and a contentTree type is the xml of a selected node.

## Adding the parameters
- Create a xslt macro.
- Look under the "parameters" tab on the macro settings screen.
- Create a new parameter the alias "text" name "Text property" and type "text".
- Create a second parameter called "contentTree" with the name "Select Node" and the type "contentTree".


## Writing some basic xslt
Okay so now we have a macro with some parameters. Let's get these parameters into the xslt.

Our Xslt code (without the stylesheet info):

```xml
<xsl:template match="/">
  <xsl:copy-of select="/macro/text"/>
  <xsl:copy-of select="/macro/contentTree"/>
</xsl:template>
```

## Working with parameters in XSLT
Okay so far we've set up an xslt script, added 2 parameters and picked some data for the parameters when we inserted the macro in a template.

So what does the 2 parameters return?
The `<xsl:copy-of select="/macro/text" />` returns:

```xml
<text>Hello World</text>
```

The `<xsl:copy-of select="/macro/contentTree" />` returns:

```xml
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
```

So as you can see: the text parameter sends the text string we entered to the macro and the contentTree parameter sends a big chunk of xml describing the node we selected. If the node had any child nodes these would also be send to the xslt macro as xml.

## Explaining how the parameters are send to the macro

When you set up a macro parameter for a xslt macro, you tell Umbraco to send some xml to the xslt script. This xml looks something like this:

```xml
<macro>
    <parameteralias1>Value</parameteralias1>
    <parameteralias2>Value</parameteralias2>
</macro>
```

So with this information along with some basic XPath we can query the xml from the parameters. Which is what we are doing with "/macro/text". It will get the value from the "text" parameter and the "/macro/contentTree" which will get the value of the parameter with the alias "contentTree". We could then go on and do some basic XPath work on the contentTree macro to return the selected nodes name like this:

```xml
<xsl:value-of select="/macro/contentTree/node/nodeName" />
```

or get its bodyText value with

```xml
<xsl:value-of select="/macro/contentTree/node/data [@alias = 'bodyText']" />
```

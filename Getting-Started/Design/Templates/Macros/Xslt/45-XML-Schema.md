# 4.5 XML Schema

This sections covers the new XML Schema that is included in Umbraco version 4.5 and above. By default in version 4.5 of Umbraco it will use the
new XML Schema.

## Old Schema

    <?xml version="1.0"?>
    <root id="-1">
      <node id="1080" version="e9716f36-2014-4154-b030-c9855c1a3f31" parentID="-1" level="1" writerID="0" creatorID="0" nodeType="1066" template="1051" sortOrder="2" createDate="2009-02-26T18:39:39" updateDate="2009-04-27T16:43:41" nodeName="Home" urlName="home" writerName="Administrator" creatorName="Administrator" nodeTypeAlias="CWS_Home" path="-1,1080">
        <data alias="umbracoNaviHide">0</data>
        <data alias="siteName">My Site</data>
        <data alias="headerText"><![CDATA[<p><strong>Sam Grady designed this for Warren Buckley.</strong> "This" idea was first created by the incredible Robert Brownjohn and has been copied many times since.</p>]]></data>
        <node id="1081" version="67a016f9-3eda-4c59-afc7-e5cab7fbfc35" parentID="1080" level="2" writerID="0" creatorID="0" nodeType="1070" template="1058" sortOrder="1" createDate="2009-02-26T18:47:46" updateDate="2009-04-27T16:43:41" nodeName="About" urlName="about" writerName="Administrator" creatorName="Administrator" nodeTypeAlias="CWS_Textpage" path="-1,1080,1081">
          <data alias="umbracoNaviHide">0</data>
          <data alias="headerText"><![CDATA[<p>This is a good place to put a service message or something to help define your site or company.</p>]]></data>
          <data alias="bodyText"><![CDATA[<p><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ullamcorper condimentum lorem. Curabitur placerat nunc ut leo. Integer eros ligula, vestibulum at, eleifend id, dignissim vel, est.</strong></p>]]></data>
        </node>
      </node>
    </root>


-   ```<node>``` for content nodes
-   Documemt Types identified as an attribute on the node ```<node
    nodeTypeAlias="home">```
-   Document Type properties are child nodes of the content ```<node>```
    stored in ```<data>``` nodes for each property
-   A specific Document Type property is identified as an attribue on
    the data node ```<data alias="bodyText">```

## New Schema

    <?xml version="1.0"?>
    <root id="-1">
      <Home id="1080" parentID="-1" level="1" writerID="0" creatorID="0" nodeType="1066" template="1051" sortOrder="2" createDate="2010-05-30T16:17:58" updateDate="2010-05-30T16:22:54" nodeName="Home" urlName="home" writerName="Administrator" creatorName="Administrator" path="-1,1080" isDoc="">
        <umbracoNaviHide>0</umbracoNaviHide>
        <siteName>My Site</siteName>
        <headerText><![CDATA[<p><strong>Sam Grady designed this for Warren Buckley.</strong> "This" idea was first created by the incredible Robert Brownjohn and has been copied many times since.</p>]]></headerText>
        <Textpage id="1081" parentID="1080" level="2" writerID="0" creatorID="0" nodeType="1070" template="1058" sortOrder="1" createDate="2010-05-30T16:23:31" updateDate="2010-05-30T16:24:03" nodeName="About" urlName="about" writerName="Administrator" creatorName="Administrator" path="-1,1080,1081" isDoc="">
          <umbracoNaviHide>0</umbracoNaviHide>
          <headerText><![CDATA[<p>This is a good place to put a service message or something to<br />help define your site or company.</p>]]></headerText>
          <bodyText><![CDATA[<p><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ullamcorper condimentum lorem. Curabitur placerat nunc ut leo. Integer eros ligula, vestibulum at, eleifend id, dignissim vel, est.</strong></p>]]></bodyText>
        </Textpage>
      </Home>
    </root>

-   Each document type has its own node using the document type alias -
    ```<Home>``` as opposed to ```<node documentTypeAlias="home">```
-   Each property has its own node underneath the document type node
    ```<umbracoNaviHide>``` as opposed to ```<data alias="umbracoNaviHide">```
-   The way to tell the difference between a document type node and a
    property node is that the document type node has the blank attribute
    isDoc ```<home isDoc"">```

## Tools

There are some tools available to automate the process of converting
XSLT file from the old to the new schema:

-   [XsltUpdater for
    Umbraco](/projects/developer-tools/xsltupdater-for-umbraco)
-   [Online converter by Tommy
    Poulsen](http://blackpoint.dk/umbraco-workbench/tools/convert-xml-schema-to-45-.aspx?p=2)

## Reverting back to the old schema

However if you wish to revert back to the old XML Schema you need to
update the ```UseLegacyXmlSchema``` setting in the
```config/UmbracoSettings.config``` file, [make sure to read this wiki
page for a step-by-step
guide](/wiki/reference/xslt/45-xml-schema/switching-between-old-and-new-schema).

Here is a [topic on why Umbraco uses the new xml schema](http://our.umbraco.org/forum/developers/xslt/9665-Why-a-new-XML-Schema)

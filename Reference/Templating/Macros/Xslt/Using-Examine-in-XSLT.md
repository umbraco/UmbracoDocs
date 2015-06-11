# Using Examine in XSLT

## Configuration

### Web.config

First, you need to make sure "XSLT Extensions" are enabled.

To enable these, open the web.config file in the root folder of your
Umbraco installation and locate the line:

    <add key="umbracoDisableXsltExtensions" value="false" />

Make sure its value is set to "false". (Don't you love double negation!)

### xsltExtensions.config

Second, you need to configure the Examine XSLT extensions to be
available.

To do this, open the file "xsltExtensions.config", located in the
"config" directory.

Add the following line (make sure it's **not** inside the default
comment section ```<!-- ... --\>```!):

    <ext assembly="UmbracoExamine" type="UmbracoExamine.XsltExtensions" alias="umbraco.examine" />

## Using Examine

### Create a new XSLT file

Go to the "Developer" section in the Umbraco backend and create a new
XSLT file, based on the "Clean" template. Let's name it "ExamineSearch".

After the XSLT file opens in the editor, make sure the stylesheet
references the "urn:umbraco.examine" namespace and that the
"umbraco.examine" prefix is excluded from the output (example below
leaves out the rest of the default namespaces):

    <xsl:stylesheet  
      ...  
      xmlns:umbraco.examine="urn:umbraco.examine"  
      exclude-result-prefixes="... ... umbraco.examine">

If the namespace isn't readily available when creating a new XSLT file,
it's a good indication the configuration wasn't succesful. You might
want to go to the forum for help!

### Test whether Examine works

In the XSLT file you've just created, put your cursor in the "root"
template:

    <xsl:template match="/">
      <!-- start writing XSLT -->
    </xsl:template>

Let's add the Examine XSLT extension through the menu, so click on the
second button "Insert xslt:value-of". In the dialogue that opens, click
on the "Get Extension" button. The dialogue refreshes, you can now
choose the "umbraco.examine" value from the leftmost dropdown menu. A
number of extension methods are now available in the right dropdown
menu, including "Search", "SearchContentOnly", "SearchMediaOnly" and
"SearchMemberOnly", all with one or more method arguments.

![Examine XSLT extension methods](Images/examine-xslt-extension-methods.png)

Let's just start with searching through your content nodes. Pick the
method "SearchContentOnly(String searchText)" and click on the "Insert"
button. Next click on the "Insert Value" button.

The root template will now look like this:

    <xsl:template match="/">
      <!-- start writing XSLT -->
      <xsl:value-of select="umbraco.examine:SearchContentOnly('String searchText')"/>
    </xsl:template>

We'll now have to replace the "String searchText" with an actual value
to test the search with, so take a common term that appears a lot on
your website, like for instance "computer" or "wine" or whatever your
website is about.

To test the search, I'd like to use the "Visualize XSLT" functionality
(last button in the XSLT editor), so I don't actually need to put the
macro on a page to test. So I'm going to wrap the output of the Examine
search in a ```<textarea>``` element.

Furthermore, ```<xsl:value-of />``` will only return the text in the Examine
result, but I'd like to inspect the actual nodeset (XML) Examine
returns, so we're going to replace ```<xsl:value-of />``` with ```<xsl:copy-of
/>```. Let's put these last bits together:

    <xsl:template match="/">
      <!-- start writing XSLT -->
      <textarea cols="60" rows="25">
        <xsl:copy-of select="umbraco.examine:SearchContentOnly('computer')"/>
      </textarea>
    </xsl:template>

Now let's check the results. Select all the text in the XSLT document
(just put your cursor anywhere in the code and hit CTRL+A or CMD+A).
Next, click on the last button in the toolbar "Visualize XSLT". In the
new dialogue window, select any node under the "Content" node and click
on the "Visualize XSLT" button. The result will look something like
this:

![Examine: Visualize XSLT](Images/examine-visualize-xslt.png)

So, Examine returns a nodeset with a ```<nodes>``` root element, containing
one or more ```<node>``` elements, each containing one or more ```<data
alias="propertyNameAlias">``` elements.

When Examine could not find anything for your search query, it will
return ```<error>There were no search results.</error>```.

Using the returned nodeset, you can output the search results, using
either a ```<xsl:for-each />``` or preferably a ```<xsl:template />```.

In case you want to take a peek at the inner workings of the Examine
XSLT extensions, you can [browse the
sourcecode](http://examine.codeplex.com/SourceControl/BrowseLatest) (open
UmbracoExamine > XsltExtensions.cs).

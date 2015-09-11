#XSLT
This section is your resource for XSLT/XPath in relation to Umbraco. You'll find information, examples and best practices according to readability and performance in your XSLT/XPath snippets.

##[The basics](The-Basics.md)
The standard XSLT file consists of a few different parts. Understanding these parts will allow you to do much more with XSLT than you probably realize.

##[Boolean XSLT logic](Some-XSLT-Logic.md)

##[How Umbraco uses XSLT](How-Umbraco-Uses-XSLT.md)
Umbraco utilizes XSLT to dynamically render content such as navigational structures, lists, and nearly anything you can dream of. This is accomplished through the use of Macros.

##[4.5 XML Schema](45-XML-Schema.md)
This sections covers the new XML Schema that is included in Umbraco version 4.5 and above. By default in version 4.5 of Umbraco it will use the new XML Schema.

##[Understanding currentPage](Understanding-currentPage.md)
The currentPage parameter is important for us in Umbraco. It is the complete XML document of the published site, and is how we reference the data stored in each document.

##[Macro Parameters in XSLT](macro-parameters.md)
Working with the different macro parameter types and the values passed from them

##[Using Examine in XSLT](Using-Examine-in-XSLT.md)
Searching with examine from XSLT

##[Using Variables and Parameters](Using-Variables-and-Parameters.md)
Variables and parameters are temporary storage devices in XSLT for holding simple values to complete node sets of data.

##[XPath Axes and their Shortcuts](XPath-Axes-and-their-Shortcuts.md)
XPath works on the premise of Axes, which is how the data relates to the current node.

##[XPath and XSLT Loops](XPath-and-XSLT-Loops.md)
This command takes an XPATH statement and iterates the results for each match, executing the nested commands each time

##[Umbraco.library](../../../Api/UmbracoLibrary/index.md)
Umbraco.library is a collection of helpers available to both Razor and XSLT

##What is XSLT
XSLT, or eXtensible Stylesheet Language Transformations, is a document that is applied programmatically to an XML Document to manipulate the data.  The structure of XSLT resembles that of XML, and contains specialized tags to perform specific actions to the data.

In Umbraco, XSLT is utilized through the use of macros, which are the dynamic building block of front-end content. These templates can be used for various tasks, including the building of navigation structures, display of content nodes in a customizable format.

Umbraco also exposes a series of functions to XSLT documents for the manipulation of the data beyond the standard capabilities of XSLT functions. These XSLT Extensions are easily referenced within the mark-up of the XSLT, allowing for easy manipulation of the data for even the most novice developers.

"Occasional XSLT for Experienced Software Developers" [http://www.devx.com/xml/Article/28610/1954](http://www.devx.com/xml/Article/28610/1954) - this article explains common pitfalls when treating XSLT like a "traditional" programming language.
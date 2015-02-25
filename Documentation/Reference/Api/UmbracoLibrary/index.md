#Umbraco.Library
_Umbraco.Library is a Xslt extension library, built specifically for xslt macros in Umbraco 4. It contains many utility methods which are strictly for use in Xslt, but also has a number of more general purpous methods, which can used more broadly. All samples are written with Xslt in mind, but can easily be referenced in both c# and razor under the `umbraco.library` namespace_

##NiceUrl
Use this to return a 'Friendly URL' for a given node in the Umbraco content section. A 'Friendly URL' is the complete encoded URL excluding the domain.

Please note: When using useDomainPrefixes=true in UmbracoSettings.config, NiceUrl returns the url including the domain.

###Simple NiceUrl XSLT Example
This example will return the friendly url for the Parent page that is currently being viewed.
	
	<xsl:value-of select="umbraco.library:NiceUrl($currentPage/../@id)" />

###NiceUrl example used in an anchor tag:
This example shows how to use this to build a link to this page:

	<a>
	 <xsl:attribute name="href">
	  <xsl:value-of select="umbraco.library:NiceUrl($currentPage/../@id)" />
	 </xsl:attribute>
	 <xsl:value-of select="$currentPage/../@nodeName" />
	</a>
	
Or it can be written using the short hand version:

	<a href="{umbraco.library:NiceUrl($currentPage/../@id)}">
	 	<xsl:value-of select="$currentPage/../@nodeName" />
	</a>

Both of the above statements used on this page will produce:

	<a href="/wiki/reference/umbracolibrary">Umbraco.Library</a>

##FormatDateTime
Using FormatDateTime allows you to format a date, such as the node's createDate and updateDate XML attributes for example.

	FormatDateTime('String Date', 'String Format')
	
- String Date** = The date you want to format
- String Format** = a coded string that is an example of the format you want to use (see below).

###String Format Codes:
- d = Short date format for current culture (eg. 01/03/10)
- D = Long date format for current culture (eg. 1 March 2010)

###Month
- MMMM = Full month name spelled out ('August')
- MMM = Abbreviated month name ('Aug')
- MM = 2 digit month ('08')
- M = 1 or 2 digit month ('8')

Note that if the 'M' format specifier is used alone, without other custom format strings, it is interpreted as the standard month day pattern format specifier. If the 'M' format specifier is passed with other custom format specifiers or the '%' character, it is interpreted as a custom format specifier.


###Day
- dddd = Full day of week ('Thursday')
- ddd = Abbreviated day of the week ('Thu')
- dd = 2 digit day ('06')
- d = 1 or 2 digit day ('6')

###Year
- y or yy = 2 digit year ('99')
- yyyy = 4 digit year ('1999')

###Hour
- h = 1 or 2 digit hour ('9')
- hh = 2 digit hour ('09')
- H = 24 hour ('21')

###Minute
- m = 1 or 2 digit minute ('3')
- mm = 2 digit minute('03')

More date and time formatting codes and information can be found here:

- [MSDN: Standard Date and Time Format Strings](http://msdn.microsoft.com/en-us/library/az4se3k1(loband).aspx)
- [MSDN: Custom Date and Time Format Strings](http://msdn.microsoft.com/en-us/library/8kb3ddd4(loband).aspx)

###Example XSLT Usage:
This displays the current node's update date in the format of June 15, 2009

	<xsl:value-of select="umbraco.library:FormatDateTime($currentPage/@updateDate, 'd')"/>

	<xsl:value-of select="umbraco.library:FormatDateTime($currentPage/@updateDate, 'MMMM d, yyyy')"/>


##GetXmlNodeById
Use this to fetch subnodes from a 'placeholder' document type.

###XSLT Example
This example makes it possible for you to fetch subnodes from a 'placeholder'.

	<xsl:value-of select="umbraco.library:GetXmlNodeById(1243)"/>

If you for instance have a 'placeholder' in your tree called "Locations" you can get the different locations by retrieving the placeholder id as shown above.

Then you could for instance loop through all the subnodes by writing something like this

###XSLT Example
	<xsl:for-each select="umbraco.library:GetXmlNodeById(1243)/node">
	  <xsl:value-of select="@nodeName" /> - 
	  <xsl:value-of select="data[@alias='yourProperty']" />
	</xsl:for-each>


##AddJquery
Use this to insert a reference to the Jquery library in the <head></head> section of your html. It gives you the possibility to only add Jquery to certain pages, which are based on the template(s) you are using the XSLT macro on. For this to work, make sure to set runat="server" on the <head> tag, i.e. <head runat="server">.

###XSLT Example

	<xsl:value-of select="umbraco.library:AddJquery()"/>

##CurrentDate
Use this to return the current date

###XSLT Example
	<xsl:value-of select="umbraco.library:CurrentDate()"/>


##AllowedGroups
Returns a node-set of member groups (roles) that have access to the restricted content document.

	umbraco.library:AllowedGroups(int documentId, string path)

An example of the returned XPathNodeIterator (as XML):

	<roles>
	        <role>1050</role>
	        <role>1066</role>
	        <role>1072</role>
	</roles>

The value of the `<role>` are the Id of the Member Group.


##ChangeContentType
Use this to change to content type from html to the given content type. In the example below we change the content type to xml.

###Example
	<xsl:value-of select="umbraco.library:ChangeContentType('text/xml')"/>


##DateDiff
Use this method to get the difference between two dates in seconds, minutes or years.


###XSLT Example
This example will return an integer with the difference in years: 5. The second date is subtracted from the first date.

	<xsl:value-of select="umbraco.library:DateDiff('16-02-2010', '16-02-2005', 'y')"/>


The third parameter can be one of the following: "s", "m" or "y".

###C# Example
The result of the C# example will be 60 minutes.

	int minutes = umbraco.library.DateDiff("16-02-2010 16:00", "16-02-2010 17:00", "m");



##DateGreaterThanOrEqual
returns true if firstDate >= secondDate otherwise false

	umbraco.library:DateGreaterThanOrEqual( string firstDate, string secondDate )


##DateGreaterThanOrEqualToday
Allows you to select Data and filter via a date field, so you could select data from a specific node which had a date which was in the future or the same as today.


	<xsl:for-each select="$currentPage//node/data [@nodeTypeAlias='whatever' and umbraco.library:DateGreaterThanOrEqualToday(./data [@alias='dateField'])] " />
 

You could use this method for Events or time specific data, this would save you using the publish at and remove at features in the admin section.  

And allow you to leave the data on the site which would be good for the search engines.


##GetDictionaryItem(System.String)
When you have set up a multi-lingual website you have probably created dictionary items in the Settings section of Umbraco. Now of course, you need to display these dictionary items in your pages or to be more specific in your XSLT.

That's where the `GetDictionaryItem()` function comes in. To get the value of the dictionary item simply write the following code:

	<xsl:value-of select="umbraco.library:GetDictionaryItem('YourDictionaryItemsName')"/>
This will output the dictionary item value on your page.

You can of course also put the value in a variable like so:

	<xsl:variable name="myLabel" select="umbraco.library:GetDictionaryItem('YourDictionaryItemsName')"/>
	<xsl:value-of select="$myLabel"/>



##GetDictionaryItems(System.String)
This function has the same general purpose as the GetDictionaryItem() function. The difference comes into play when you have set up you dictionary items like this:

- Dictionary
	- ContactForm
		- Name
		- Email
		- Message

As you can see we have created some itmes under the ContactForm dictionary item. Setting up you dictionary like this means that you don't have to seperately call every single item in your XSLT. You can just call the ContactForm item once, and have access to all underlying items. Just create a variable that gets all your items:

	<xsl:variable name="contactlabels" select="umbraco.library:GetDictionaryItems('ContactForm')"/>
	
And then output the items you need wherever you need them:

	<xsl:value-of select="$contactlabels /DictionaryItems/DictionaryItem[@key = 'Name']" />
	<br/>
	<xsl:value-of select="$contactlabels /DictionaryItems/DictionaryItem[@key = 'Email']" />
	<br/>
	<xsl:value-of select="$contactlabels /DictionaryItems/DictionaryItem[@key = 'Message']" />
 
 
 
##GetHttpItem
Retreive a value from the http collection 

	<xsl:variable name="memId" select="umbraco.library:GetHttpItem('umbMemberLogin')"/>
	
##GetItem
Use this to get the content of a field within a node. You can not access Umbraco set fields like nodeName and createDate with this method.

###XSLT Example
This will put into the variable "aliasContent" the text in the field with the alias 'pageTitle'.

	<xsl:variable name="aliasContent" select="umbraco.library:GetItem(1234, 'pageTitle')"/>
	<h2><xsl:value-of select="umbraco.library:GetItem(@parentID, 'pageTitle')"/></h2>

This example displays the page title of the parent page while process the 'node'.

	<h2>News</h2>

 
 
##GetMedia
The method is used to get information of files in the media library - such as filename, size, height, width.

###Parameters
GetMedia(int MediaId, bool Deep);

  Integer   MediaId 
  Boolean   Deep

###Return value
The method returns a XPathNodeIterator with the information of selected file.

###Usage
Getting the url of a media file with hardcoded ID

	<xsl:value-of select="umbraco.library:GetMedia(./data [@alias = 'yourProperty'], 0)"/>

Getting the url of a media file using a mediaPicker

	<xsl:value-of select="umbraco.library:GetMedia(1057, 0)/data [@alias = 'umbracoFile']"/>

	<xsl:value-of select="umbraco.library:GetMedia($currentPage/data[@alias='yourProperty'], 0)/data [@alias = 'umbracoFile']"/>

###How to render an image from XSLT
Assuming the property alias is 'bannerImage' then:

	 <xsl:variable name="media" select="umbraco.library:GetMedia($currentPage/data[@alias='bannerImage'], 0)/data" />
	
	 <xsl:if test="$media">
	        <xsl:variable name="url" select="$media [@alias = 'umbracoFile']" />
	        <xsl:variable name="width" select="$media [@alias = 'umbracoWidth']" />
	        <xsl:variable name="height" select="$media [@alias = 'umbracoHeight']" />
	        <img src="{$url}" width="{$width}" height="{$height}" />
	 </xsl:if>
	 
In the new syntax (Umbraco 4.5.1 onwards) this has changed to:

	<xsl:variable name="media" select="umbraco.library:GetMedia($currentPage/imageAlias, 0)" />
	
	<xsl:if test="$media">
	        <img src="{$media/umbracoFile}" alt="{$media/altText}" />
	</xsl:if>
	


##GetMember
The "standard" properties of a member are stored as attributes in the `<node>` element (of the XML that's returned from `umbraco.library:GetMember`).

You can access them like this:

	<xsl:variable name="member" select="umbraco.library:GetMember(1066)" />
	Name: <xsl:value-of select="$member/@nodeName" /><br />
	Login Name:<xsl:value-of select="$member/@loginName" /><br />
	Email:<xsl:value-of select="$member/@email" />

** obviously, replace the "1066" with the id of the member you want to access - You could always pass in a variable


##GetMemberName
Returns the name as a string,  of the member with a given Id

	<xsl:variable name="name" select="umbraco.library:GetMemberName(1066)" />



##GetPreValueAsString
Gets the Umbraco data type prevalue with the specified Id as string.

###Xslt Example
	<xsl:variable name="name" select="umbraco.library:GetPreValueAsString(1234)" />

###Razor Example
	@{
	  var myValues = "7,8";
	  foreach(var id in myValues.Split(',')) { 
	   var myStringValue = umbraco.library.GetPreValueAsString(Convert.ToInt32(id)); 
	   <li>@myStringValue </li>
	  }
	}


##GetPreValues
Fetches a list of prevalues. "Prevalues" are predefined values/options attached to e.g. a drop down or checkbox list data type.


##GetWeekDay
GetWeekDay(String Date)
String    date - date from Umbraco XML or a hardcoded value. You could also call the CurrentDate() XSLT extension.

###Usage

	<xsl:value-of select="umbraco.library:GetWeekDay('07-16-2009')"/>

###Return Value
This method returns a string with the name of the day (Surprise! :-))

##GetXmlAll
Returns the entire xml document from the content cache

	<xsl:for-each select="umbraco.library:GetXmlAll()/descendant-or-self::node [string(data[@alias='FeatureInFrontRotater']) = '1' ]">
		<li>some value</li>
	</xsl:for-each>
	

##GetXmlDocumentByUrl
You can pass this extension a URL to an XML file (Such as an RSS feed or API results) and Umbraco will read it in and let you have all the normal XSLT tools to manipulate it

For example I'll lets take the BBC sport RSS feed

newsrss.bbc.co.uk/.../rss.xml

and print out some data, here I create a variable which calls the `umbraco.library:GetXmlDocumentByUr`l extension and stores the XML

	<xsl:variable name="MyFeed" select="umbraco.library:GetXmlDocumentByUrl('http://newsrss.bbc.co.uk/rss/sportonline_uk_edition/front_page/rss.xml')" />
	
Then the loop code using normal XSLT

	<ul>
	  <xsl:for-each select="$MyFeed/rss/channel/item">
	    <li><xsl:value-of select="title" /></li>
	  </xsl:for-each>
	</ul>


##GetXmlNodeByXPath
This method allows you to pass in an XPath statement (as a string) to return the appropriate XmlNodes.

Quick example of how to use the GetXmlNodeByXPath method:

	
	        <xsl:variable name="xpathQuery">
	                <xsl:text>/root/node[@level = 1 and string(data[@alias='umbracoNaviHide']) != '1']</xsl:text>
	        </xsl:variable>
	        <xsl:copy-of select="umbraco.library:GetXmlNodeByXPath($xpathQuery)" />
	
	
This example gets the top-level (@level = 1) nodes and dumps/outputs the XML in the page.

You can also use this method to check to see if a node exists:

    var node = umbraco.library.GetXmlNodeByXPath("//node[@nodeName='Something here' and contains(@path, '1234')]");
    
The above will return nodes that match the queried @nodeName and @path.


##GetXmlNodeCurrent
Returns the XML for the currently viewed node:

	<xsl:value-of select="umbraco.library:GetXmlNodeCurrent()"/> 

This is the same as:

	<xsl:value-of select="$currentPage"/> 

If using` xsl:include` to include other XSLT files into another. It is wise to use `umbraco.library:GetXmlNodeCurrent()` instead of `$currentPage`. This will minimize conflicts between XSLT files.




##HasAccess
`HasAccess()` is checking to see if a protected node is accessible to the current user. If it isn't protected then the whole test will fail.

	   <xsl:for-each select="$source/node [
	           string(data [@alias='umbracoNaviHide']) != '1' and umbraco.library:HasAccess(@id, @path) = true())]">
		    <a href="{umbraco.library:NiceUrl(@id)}">
	               <xsl:value-of select="@nodeName"/>
	           </a>
	   </xsl:for-each>


##HtmlEncode
Standard method, the same as you would use in day to day ASP.NET coding - Takes a string and HTML Encodes it

<xsl:value-of select="umbraco.library:HtmlEncode(data [@alias = 'bodyText'])" />


##IsProtected
Use this to determine if a node is protected or not. Returns bool(false/true)

	<xsl:value-of select="umbraco.library:IsProtected($currentPage/@id, $currentPage/@path)" />


##LongDate
The method is used to get return a formatted date from Umbraco's XML.

The method returns a string in the form:

22 April 2006 18:43:00

###Usage
	<xsl:value-of select="umbraco.library:LongDate(data[@alias='PublishDate']/text(), 1, ' ')"/>


###LongDate(String date, bool includeTime, String separator);
- String    date - date from Umbraco XML.
- Boolean   includeTime - include the time as well as the date.
- String    separator - character(s) to separate date and time components.



##md5
Creates an MD5 hash out of a string:

	<xsl:value-of select="umbraco.library:md5('value to hash')"/>

##NiceUrlFullPath
**NOTE:** This method was obsoleted in **Umbraco 4.10.0+**

Does the same as NiceUrl except it returns the full url with a domain for a given node in the Umbraco content section.

###XSLT Example
This example will return the friendly url for the Parent page that is currently being viewed.

	<xsl:value-of select="umbraco.library:NiceUrlFullPath($currentPage/../@id)" />



##QueryForNode
Gets the path back to the parent node of a given node. For instance, if  page 1057 was 3 pages deep and you called this function you might get:

	<xsl:value-of select="umbraco.library:QueryForNode(1057)"/> 
 	[@id = 1048]/node [@id = 1050]/node [@id = 1057]
 
 
##RegisterJavaScriptFile
This is a really useful when you write XSLT macros that require a Javascript library to be registered in the head block, rather than having to remember to add the LINK to the head section you can include it in the XSLT and that way you have easily deployable functionality that can be quickly added to a page with a single macro insert.

###Example
	<xsl:value-of select="umbraco.library:RegisterJavaScriptFile('uniqueKey', '/scripts/myJavaScriptFile.js')"/> 

**Note**: You MUST have runat="server" on the HEAD tag in your HTML template


##RemoveFirstParagraphTag
Removes the starting and ending paragraph tags in a string. Returns the string without starting and endning paragraph tags

Input: string
Output: the string without starting or ending paragraph tags.

Currently (v4.7.1) this code strips one <P> from the front, and one </P> from the end. Trimming is not done, and nothing is done if the string is less than 5 characters long. If the string starts with a P tag but does not end with a closing P tag, only the opening P tag is removed (middle-content of the string is not modified).

###Example
	<xsl:value-of select="umbraco.library:RemoveFirstParagraphTag(bodyText)" disable-output-escaping="yes" />

If you need to trim the string, use the xslt function normalize-space():

	<xsl:value-of select="umbraco.library:RemoveFirstParagraphTag(normalize-space(bodyText))" disable-output-escaping="yes" />


##Replace
Replace(String text, String oldValue, String newValue)

- String    text - the text that contains the charachters you want to replace 
- String    oldValue - The charachters you want to replace 
- String    newValue - The charachters, which should be used instead

###Usage
	<xsl:value-of select="umbraco.library:Replace('I like hot coffee', 'hot', 'strong')"/>


##ReplaceLineBreaks
Use this to replace non HTML line breaks with HTML` <br/>` breaks.

The Simple Editor datatype does not HTML encode line breaks so the following code can be used for that.

###Usage
	<xsl:value-of select="umbraco.library:ReplaceLineBreaks($currentPage/SimpleContent)" />
	

##Request
##RequestCookies
##RequestForm
##RequestQueryString
##RequestServerVariables
##SendMail
##Session
##SessionId
##setCookie
##setSession
##ShortDate
##ShortDateWithGlobal
##ShortDateWithTimeAndGlobal
##ShortTime
##Split
##StripHtml
##Tidy
##TruncateString
##UnPublishSingleNode
##UpdateDocumentCache
##UrlEncode
##GetXmlNodeById (1)
##Item
##ReplaceLineBreaks

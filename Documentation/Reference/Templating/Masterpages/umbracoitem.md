#Umbraco:item

_The `umbraco:item` element is used to pull a property from the page, currently being rendered, the below sample renders the value with the alias "`bodyText`" from the current page, if the value does not exist, nothing is rendered_

	<umbraco:item field="bodyText" runat="server" />

##insertTextBefore
The `insertTextBefore` allows you to add text before your field is outputted, only rendered if field contains a value

	<umbraco:item field="bodyText" insertTextBefore="bodyText field: " runat="server"/>

##insertTextAfter
The `insertTextAfter` allows you to add text before your field is outputted, only rendered if field contains a value

	<umbraco:item field="bodyText" insertTextAfter="I am some text after the field." runat="server"/>

##formatAsDate
`formatAsDate` allows you to ouput your field as a date - obviously not a richtext editor field but a field that stores dates.

	<umbraco:item field="startDate" formatAsDate="true" runat="server" />

##formatAsDateWithTime
This is just like formatAsDate but instead this will also ouput the time along with the date, if you use this attribute you will also need to use the `formatAsDateWithTimeSeperator` attribute.

	<umbraco:item field="startDate" formatAsDateWithTime="true" formatAsDateWithTimeSeperator=" " runat="server"/>


##formatAsDateWithTimeSeparator
This is just like `formatAsDate` but instead this will also ouput the time along with the date, if you use this attribute you will also need to use the `formatAsDateWithTimeSeparator` attribute.

	<umbraco:item field="startDate" formatAsDateWithTime="true" formatAsDateWithTimeSeperator=" " runat="server"/>

##useIfEmpty
The useIfEmpty attribute allows you to define an alternative field if the main field is empty/blank.

	<umbraco:item field="bodyText" useIfEmpty="altText" runat="server"/>

##textIfEmpty
The textIfEmpty attribute allows you to define an alternative textif the main field is empty/blank.

	<umbraco:item field="bodyText" textIfEmpty="I am the alternative text" runat="server" />

##convertLineBreaks
The convertLineBreaks attribute allows you to convert line breaks in a simple editor field (not a RichText editor) into <br/> tags.

	<umbraco:item field="bodyText" convertLineBreaks="true" runat="server"/>

##stripParagraph
The stripParagraph attribute allows you to remove the first <p> and last </p> tag in your field.

	<umbraco:item field="bodyText" stripParagraph="true" runat="server"/>

##case
The case attribute allows you to convert your field into lower or upper case.

	<umbraco:item field="bodyText" case="lower" runat="server"/>
	<umbraco:item field="bodyText" case="upper" runat="server"/>

##urlEncode
The urlEncode attribute allows you to encode your field into a URL encoded format

	<umbraco:item field="bodyText" urlEncode="true" runat="server"/>

##htmlEncode
The htmlEncode attribute allows you to encode your field into an HTML encoded format (so that special characters are converted to their HTML entity equivalent).

	<umbraco:item field="bodyText" htmlEncode="true" runat="server"/>

##Xslt and XsltDisableEscaping
The Xslt and XsltDisableEscaping attributes are particularly useful for manipulating complex content, such as that stored in a Content or Media Picker on a page.

For example, retrieving the URL to an image requires calling `umbraco.library:GetMedia` from within a macro - Razor, XSLT or otherwise. However, if a single image is being handled in a relatively simple manner, the following code snippet may be useful:

	<umbraco:Item Field="myImage" runat="server"
	              Xslt="umbraco.library:GetMedia({0},0)/umbracoFile"
	              insertTextBefore="&lt;img src='" insertTextAfter="' /&gt;" />
	              
Common uses will probably include calling single XSLT functions for parsing values prior to render.

Another useful attribute is XsltDisableEscaping, whereby the value returned by the transfrmation specified in the Xslt attribute requires escaping. This might be useful when parsing content or data that contains HTML, and therefore requires escaping to be succesfully rendered to the page.


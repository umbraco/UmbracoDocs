# Multilanguage sites
_This section features tips on how to translate labels for your document types like tabs, name and description. For more information on how to create a multilanguage frontend website please read this article [1-1 Multilingual Websites in Umbraco
](http://24days.in/umbraco/2012/multilingual-1-1/)_

## Multilanguage backoffice
To be able to translate the labels of tabs, name and description on your document types you can use the dictionary in Umbraco. You can also translate the name of your documents.

It's quite simple to translate these labels. Consider the following text on a document type:

**Tab**: Content<br/>
**Name**: Header<br/>
**Description**: This is the header of the page.

The name of document type is "Document".

If you create dictionary items for these fields with translations to other languages you can actually reference these, and then have these labels translated so the text appears in the language of the editor logged into Umbraco.
You use a special syntax to reference the name of the dictionary items as shown below:

**Tab**: #Content<br/>
**Name**: #Header<br/>
**Description**: #HeaderDescription

Likewise, the name of the document type can be referenced with #Document.

So it's the "hashtag" (#) symbol + the alias of dictionary item which will make Umbraco look in the Dictionary for the actual text content.

### Important!
At the time of this writing the default language of Umbraco is set to "en-us" and the default language of the administrator account is set to "en-uk". This can create some confusion if you try to do the above since it will just display as [#Header] on the name label for instance. Therefore you should change the language of the administrator account to "en-us".

This is currently neccesary for all version including and below Umbraco 6.1.1.

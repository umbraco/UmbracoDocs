#Templating

_Templating in Umbraco consists of 2 larger concepts, namely Templates, and Macros. Templates are used for the html layout of your pages, whereas macros are resuable dynamic components used for embedding navigation, forms, lists, and so-on in your templates._

##Template options

There are 2 types of templating technologies in Umbraco:

* MVC (views)
* WebForms (masterpages)

Umbraco recommends using MVC templates so if you are unsure what to choose then use MVC. 

It's easy to configure the default type, in the */Config/umbracoSettings.config* file, find this section and set the type you'd like to use (*Mvc* or *WebForms*):

	<templates>
		<defaultRenderingEngine>Mvc</defaultRenderingEngine>
	</templates>

*NOTE: MVC Templating is only available from v4.10+*

##[Managing templates](managing-templates.md)

Describes how to create/modify templates and describes nested templates.

##[Working with MVC 'views'](../Mvc/index.md)

Describes how to work with MVC views, the razor syntax and APIs available as well details on how to create forms, step-by-step guides and other advanced techniques.

##[Working with WebForms 'masterpages'](Masterpages/index.md)
Reference on the different components in the WebForms 'masterpages' templating syntax

##[Working with macros](Macros/index.md)
Introduction to setting up a macro, passing parameters, configuring caching

##Hybrid templates

Describes how you can use both WebForms and MVC templates together in the same Umbraco installation

##Related References
Documentation related to templating and macros

###[Umbraco.library](../Api/UmbracoLibrary/index.md)
Umbraco.library is a collection of helpers available to both Razor and Xslt

###[Razor syntax](Macros/Razor/index.md)
Introduction to razor, going through the basics of scripting in razor.

###[Xslt overview](Macros/Xslt/index.md)
Information, examples and best practices according to readability and performance in your XSLT/XPath snippets.
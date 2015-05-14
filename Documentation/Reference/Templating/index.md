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

##[Working with MVC](Mvc/index.md)

Describes how to work with MVC views, the razor syntax and APIs available as well details on how to create forms, step-by-step guides and other advanced techniques.

##[Working with WebForms 'masterpages'](Masterpages/index.md)
Reference on the different components in the WebForms 'masterpages' templating syntax

##[Working with Macros](Macros/index.md)
Describes how to set up a macro, use macro parameters & configuring caching. Defines the different types of macros and provides details on the different macro engine APIs and their usage. 

##Hybrid templates

Describes how you can use both WebForms and MVC templates together in the same Umbraco installation

*Coming soon...*

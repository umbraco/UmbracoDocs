#Templating

_Templating in Umbraco consists of 2 larger concepts, namely Templates, and Macros. Templates are used for the html layout of your pages, whereas macros are resuable dynamic components used for embedding navigation, forms, lists, and so-on in your templates._

##[Managing templates](managing-templates.md)

Describes how to create/modify templates and describes nested templates.

##Template options

There are 2 types of templating technologies in Umbraco:

* MVC (views)
* WebForms (masterpages)

By default Umbraco uses MVC templates.

##[Working with MVC (views, razor, etc...)](Mvc/index.md)

Describes how to work with MVC views, the razor syntax and APIs available as well details on how to create forms, step-by-step guides and other advanced techniques.

##[Working with WebForms (masterpages, usercontrols, etc...)](Masterpages/index.md)

Describes how to work with WebForms (masterpages) templating syntax and it's various components like UserControls, etc...

If you prefer to work with Webforms, you can change the default template engine in the */Config/umbracoSettings.config* file, find this section and set the type you'd like to use (*Mvc* or *WebForms*):

	<templates>
		<defaultRenderingEngine>WebForms</defaultRenderingEngine>
	</templates>

##[Working with Macros](Macros/index.md)

Describes how to set up a macro, use macro parameters & configuring caching. Defines the different types of macros and provides details on the different macro engine APIs and their usage. 

##Hybrid templates

Umbraco can work with both MVC and Webforms templates at the same time, however there can only be one default. Umbraco will first check for an MVC view file before it checks for a Webforms master page file. For example, if a template was created in the back office called "Home", then when rendering a content page with this template Umbraco will check these locations and use the first one that is found:

~/Views/Home.cshtml
~/Masterpages/Home.master



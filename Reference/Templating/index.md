# Templating

_Templating in Umbraco consists of 2 larger concepts, namely Templates, and Macros. Templates are used for the HTML layout of your pages, whereas macros are reusable dynamic components used for embedding navigation, forms, lists, and so-on in your templates._

## Templates

There are 2 types of templating technologies in Umbraco:

* MVC (views)
* WebForms (masterpages)

By default Umbraco uses MVC templates.

#### [Working with MVC (views, razor, etc...)](Mvc/index.md)

Describes how to work with MVC views, the razor syntax and APIs available as well details on how to create forms, step-by-step guides and other advanced techniques.



#### [Working with WebForms (masterpages, usercontrols, etc...)](Masterpages/index.md)

Describes how to work with WebForms (masterpages) templating syntax and its various components like UserControls, etc...

If you prefer to work with Webforms, you can change the default template engine in the */Config/umbracoSettings.config* file, find this section and set the type you'd like to use (*Mvc* or *WebForms*):

	<templates>
		<defaultRenderingEngine>WebForms</defaultRenderingEngine>
	</templates>


#### Hybrid templates

Umbraco can work with both MVC and Webforms templates at the same time, however there can only be one default. Umbraco will first check for an MVC view file before it checks for a Webforms master page file. For example, if a template was created in the back office called "Home", then when rendering a content page with this template Umbraco will check these locations and use the first one that is found:

~/Views/Home.cshtml
~/Masterpages/Home.master

## [Macros](Macros/index.md)

Describes how to set up a macro, use macro parameters & configuring caching. Defines the different types of macros and provides details on the different macro engine APIs and their usage.

## [ModelsBuilder](Modelsbuilder/)
A tool that can generate a complete set of strongly-typed published content models for Umbraco. Models are available in controllers, views, anywhere. Runs either from the Umbraco UI, from the command line, or from Visual Studio.

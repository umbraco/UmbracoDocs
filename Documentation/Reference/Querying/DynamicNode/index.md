#DynamicNode

_DynamicNode is similar to the dynamic models that [UmbracoHelper](../UmbracoHelper/index.md) exposes but is available only to the legacy Razor Macros and inline razor macros. If you are using DynamicNode and Razor Macros, it is recommended to upgrade them to Partial View Macros and UmbracoHelper._ 

DynamicNode is the dynamic access to all the data stored in your Umbraco website. Also know as the Model of your site.
Model represents the page, currently being rendered, and is usually referenced on Templates or Macros

DynamicNode is a dynamic object, this gives us a number of obvious benefits, mostly a much lighter syntax for 
accessing data, as well as dynamic queries, based on the names of your DocumentTypes and their properties, but at the same time, it does not provide intellisense.


##Get started
To access the current page in your Razor macros or templates, copy-paste the below Razor code.

	@{
		var pageName = Model.Name;
		var childPages = Model.Children;
	}
	
	<h1>@pageName</h1>

##[Properties](Properties.md)
Listing and explanation of DynamicNode properties & standard helpers for Content and Media.

##[Collections & Filtering](Collections.md)
Methods for DynamicNode collections and filtering.

##[IsHelpers](IsHelpers.md)
A library of extension methods to simplify working with DynamicNodes in collections to modify your HTML output. Examples could be injecting CSS classes for alternating rows or to modify margins.

##[Library](Library.md)
Library contains a collection of additional useful methods for use in Razor templates.

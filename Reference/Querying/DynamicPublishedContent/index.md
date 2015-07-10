#DynamicPublishedContent

DynamicPublishedContent is the dynamic version of IPublishedContent, it allows for simpler access to property data 
but it does not provide intellisense.

##Get started
To access the current page in your macros or templates, copy-paste the below Razor code.

	@{
		var pageName = CurrentPage.Name;
		var childPages = CurrentPage.Children;
	}
	
	<h1>@pageName</h1>

##[Properties](Properties.md)
Listing and explanation of DynamicPublishedContent properties & standard helpers for Content and Media.

##[Collections & Filtering](Collections.md)
Methods for DynamicPublishedContent collections and filtering.

##[IsHelpers](IsHelpers.md)
A library of extension methods to simplify working with DynamicPublishedContents in collections to modify your HTML output. Examples could be injecting CSS classes for alternating rows or to modify margins.

##[Library](Library.md)
Library contains a collection of additional useful methods for use in Razor templates.

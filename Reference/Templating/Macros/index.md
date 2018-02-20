# Macros

_Describes how to set up a macro, use macro parameters & configuring caching. Defines the different types of macros and provides details on the different macro engine APIs and their usage_

## What is a macro?

A macro is 'wrapper' for a reusable piece of functionality that you can utilise in different places throughout your site. 

You can use macros in your templates, like MVC Partial views - however they differ in that they can be configured to work with Parameters and Caching, that can be updated easily by editors via the Umbraco Backoffice.
So if you allow a macro to be added to a Rich Text Editor or Grid cell, the editor, at the point of inserting the macro can supply the parameter values.

For example imagine adding an Image Gallery within a rich text editor, and at the point of insertion 'picking' the images to display.

![Insert Image Carousel](images/image-carousel-macro.png)

Define the parameters

![Define the parameters](images/image-carousel-macro-parameter.png)

Inserting into a Rich Text Area

![Define the parameters](images/pick-images-for-macro-example.png)

The same implementation logic can be used in lots of different places on your site, and the editor can customise the output by choosing different parameters.

## Macro types

All macro types will work in either MVC or WebForms templating engines, it is possible, (for mainly historical reasons) to be able to implement a Macro in four different ways:
* MVC Partial View - (aka Partial View Macros), [Details of implementing a Partial View Macro](Partial-View-Macros/index.md)  **This is the recommended macro type to use**, it uses the exact same syntax and objects as MVC views.
* XSLT - [Xslt macros Information](Xslt/index.md), examples and best practices according to readability and performance in your XSLT/XPath snippets.
* User Control - Asp.Net User Control
* Razor script - (aka known as Dynamic Node Razor), before it was possible to use true MVC Partial Views in Umbraco, there was a way to implement Macros using 'Razor-like' syntax.

## Rendering Macros

Here's a basic method to render macros:

	@Umbraco.RenderMacro("myMacroAlias")

### Rendering Macros with Parameters

This renders a macro with some parameters using an anonymous object:

	@Umbraco.RenderMacro("myMacroAlias", new { name = "Ned", age = 28 })

This renders a macro with some parameters using a dictionary

	@Umbraco.RenderMacro("myMacroAlias", new Dictionary<string, object> {{ "name", "Ned"}, { "age", 27}})

### Rendering Macros with Dynamic Parameters

For common Macro Parameter scenarios, for example taking the value from the querystring, or reading a value from the underlying content item of the page the Macro is on, Umbraco has the concept of *Dynamic Macro Parameters*

  @Umbraco.RenderMacro("myMacroAlias", new { name = "[#personName]", age = "[#personAge]", school="[$schoolName]", currentPage="[@page]"})

Notice the dynamic parameters are passed as strings (even for age which would normally take an integer), this example means take the personName and personAge from the document of the current page, read the schoolName from any ancestor property in the content tree, and read the current page value from a querystring parameter called 'page'.

#### What do all these symbols mean?

##### Request Collection

To retrieve a value from the request collection such as a query string parameter we specify it by prefixing with an "@" symbol.

To get a query string parameter with the key "productId" we would specify our parameter like this **[@productId]**

##### Document Type Property

Document type properties are specified by a leading "#" and then the alias of the document property.

To pass a property with the alias "bodyText" we would specify **[#bodyText]** in the parameter value. 

##### Recursive Document Type Property

Recursive Document type properties are specified by a leading "$" and then the alias of the document property.

Umbraco resolves recursive parameters by looking at the current page for a value and then traversing up the content tree until a value with that alias is found.

##### Session Collection

Retrieve values from the session collection or cookies by prefixing with a "%" symbol. 

To retrieve a value with the key "memberId" from the session collection we would specify our Macro parameter value as **[%memberId]**

#### Chaining Dynamic Macro Parameters

It's possible to set multiple dynamic sources for a Macro Parameter, and these will be parsed in turn, until a value is found for the Macro.

    @Umbraco.RenderMacro("ListStatusUpdates", new {numberOfItems="[@limit],[#limit],[$globalLimit],4"})

In this example the Macro will first look for a parameter on the querystring called limit to take it's value, then if this is missing it will look for a document type property called 'limit' on the current page, then seek a property called 'globalLimit' all the way recursively up the Umbraco Content Tree, finally settling on 4, as the value to use if the previous three do not exist.

### Caching Macro Output

For long running macros that return the same results, caching boosts site performance, you can specify caching levels for the Macro in the backoffice.

Options are:

* Cache by Period - set the number of seconds to cache the output of the Macro for
* Cache by Page - Whether to create a different cached instance of the macro for each page (think breadcrumb - you wouldn't want the same breadcrumb on every page)
* Cache Personalized - whether to create a difference cached instance of the macro for each site visitor (if your Macro says 'Hi Niels' using the currently logged in Members name, you wouldn't want this cached to be the same for every visitor to the site, unless they were all called Niels)



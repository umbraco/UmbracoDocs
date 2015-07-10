#Macros

_Describes how to set up a macro, use macro parameters & configuring caching. Defines the different types of macros and provides details on the different macro engine APIs and their usage_

##What is a macro?

A macro is a reusable piece of functionality that you can re-use throughout your site. Macros can be configured with parameters and be inserted into a Rich Text Editor. Your can define what macros are available for your editors to insert in to the rich text editor. When an editor inserts a macro into the rich text editor it will prompt them to fill out any of the defined parameters for the macro.

##[Managing macros](managing-macros.md)

Describes how to create/update a macro and its macro parameters

##Macro types

All macro types will work in either MVC or WebForms templating engines

###[Partial View Macros](Partial-View-Macros/index.md)

**This is the recommended macro type to use**, it uses the exact same syntax and objects as MVC views.

###[Xslt macros](Xslt/index.md)

Information, examples and best practices according to readability and performance in your XSLT/XPath snippets.

###[Razor macros](Razor/index.md)

***Razor macros have been superseded by Partial View Macros, if you are using an Umbraco version greater than 4.10+ it is recommended to use Partial View Macros***

Introduction to razor, going through the basics of scripting in razor.

##Basic Syntax:
This will insert a macro with the alias '`YourMacroAlias`' into the template 

	<umbraco:Macro Alias="YourMacroAlias" runat="server"></umbraco:Macro>

##Inline macros
Macros can also render inline code, directly in the template

	<umbraco:Macro runat="server" language="cshtml">
	    <h1>@Model.Name</h1>
	    @foreach(var child in Model.Children){
	        <a href="@Model.Url">@Model.Name</a>
	    }
	</umbraco:Macro>


##Defining Property Values
This will insert a macro with the alias 'YourMacroAlias' into the template and set the macro property named 'YourPropertyName' to the value 'hello'

	<umbraco:Macro Alias="YourMacroAlias" runat="server" YourPropertyName="hello"></umbraco:Macro>

##Passing a value from the current page, into a macro
This will insert a macro with the alias 'YourMacroAlias' into the template and set the macro property named 'YourPropertyName' to the current node ID of the content node currently being executed.

	<umbraco:Macro Alias="YourMacroAlias" runat="server" YourPropertyName="[#pageID]"></umbraco:Macro>

The syntax for passing in values for the currently executing node is: [#YourNodePropertyName]

	<umbraco:Macro Alias="YourMacroAlias" runat="server" YourPropertyName="[#PageTitle]"></umbraco:Macro>

**Example:** If the current executing node's Document Type defines a property with an alias 'PageTitle' and you would like to pass this value into a macro as a property, the syntax would be `[#PageTitle]`

The syntax for passing in values of node property that is defined on any adjacent node of currently executed node, so you want to get it recursively is: `[$YourNodePropertyName]`

	<umbraco:Macro Alias="YourMacroAlias" runat="server" YourPropertyName="[$PageTitle]"></umbraco:Macro>
	
Passing a value from the request collection, into a macro
Using the same technique, it is possible to send a value from the page's request collection

	<umbraco:Macro Alias="YourMacroAlias" runat="server" YourPropertyName="[@yourQueryString]"></umbraco:Macro>

Passing a cookie value, into a macro

	<umbraco:Macro Alias="YourMacroAlias" runat="server" YourPropertyName="[%cookieName]"></umbraco:Macro>

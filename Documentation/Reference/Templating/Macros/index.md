#Macros

##References
###[Razor](Razor/index.md)
Introduction to razor, going through the basics of scripting in razor.

###[Xslt](Xslt/index.md)
Information, examples and best practices according to readability and performance in your XSLT/XPath snippets.

###[Parameters](Parameters/index.md)
Working with the different macro parameter types and the values passed from them

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


##Definining Property Values
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
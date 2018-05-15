# Umbraco:macro

The umbraco:macro element renders the out of a macro with a given alias. Attributes on the element is passed to the macro as parameters for the rendering.  In the sample below, the macro with the alias "topnavigation" is rendered, and the parameter "className" is set to "greenList" which is passed on to the script associated with the macro.

	<umbraco:macro alias="topnavigation" className="greenList" runat="server" />

### Inline macros

The umbraco:macro element can also be used inline, so a macro is not required, instead, code can be inserted directly in the template.

	<umbraco:Macro runat="server" language="cshtml">
		<h1>@Model.Name</h1>
		@foreach(var child in Model.Children){
			<a href="@Model.Url">@Model.Name</a>
		}
	</umbraco:Macro>
	
### Defining Property Values
This will insert a macro with the alias 'YourMacroAlias' into the template and set the macro property named 'YourPropertyName' to the value 'hello'

	<umbraco:Macro Alias="YourMacroAlias" runat="server" YourPropertyName="hello"></umbraco:Macro>

### Passing a value from the current page, into a macro
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
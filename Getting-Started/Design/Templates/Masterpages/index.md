#Masterpages

_Umbraco (since version 4) uses [ASP.NET master pages](http://www.asp.net/web-forms/tutorials/master-pages), so if you are familiar with these you will find this a breeze._

_When creating a new template via the backoffice, Umbraco simply generates a masterpage file that inherits from
"~/umbraco/masterpages/default.master", whilst storing the newly created template in 
"~/masterpages/[Template_Alias].master"._

##Declaration
When a new template is created, it will by default contain 3 lines of predefined markup:

	<%@ Master Language="C#" MasterPageFile="~/umbraco/masterpages/default.master" AutoEventWireup="true" %>
	
	<asp:Content ContentPlaceHolderID="ContentPlaceHolderDefault" runat="server">
	 	
	</asp:Content>

The first line, is the template declaration, it tells Umbraco what language the template is written in, and if it inherits from another template. Masterpages in Umbraco will always inherit from another Masterpage, if its a root template, it will inherite from
`/umbraco/masterpages/default.master` which is the default umbraco masterpage, which is needed for the templating system to work.
    

##[umbraco:item](umbracoitem.md)
The `umbraco:item` element is used to pull a property from the page, currently being rendered, the below sample renders the value with the alias "bodyText" from the current page, if the value does not exist, nothing is rendered

	<umbraco:item field="bodyText" runat="server" />

There are several advanced options for using` umbraco:item`, for controlling fall-back values, recursive lookups, casing, encoding and so on:

	<umbraco:Item field="bodyText" useIfEmpty="contents" textIfEmpty="Fallback value" case="upper" recursive="true" runat="server" />
                  

[See the full umbraco:item reference](umbracoitem.md)

##[umbraco:image](umbracoimage.md)
Introduced in **Umbraco 4.11.0**, the `umbraco:image` control enables you to easily add images from your content to your templates. The control is used as such:

	<umbraco:image runat="server" field="bannerImage" />

This will output an `<img/>` tag when the template renders:

	<img src="/media/19/imagename.jpg" />

[See the full umbraco:image reference](umbracoimage.md)

##[umbraco:macro](../Macros/index.md)
The umbraco:macro element renders the out of a macro with a given alias. Attributes on the element is passed to the macro as parameters for the rendering.  In the sample below, the macro with the alias "topnavigation" is rendered, and the parameter "className" is set to "greenList" which is passed on to the script associated with the macro.

	<umbraco:macro alias="topnavigation" className="greenList" runat="server" />

The umbraco:macro element can also be used inline, so a macro is not required, instead, code can be inserted directly in the template.

	<umbraco:Macro runat="server" language="cshtml">
		<h1>@Model.Name</h1>
		@foreach(var child in Model.Children){
			<a href="@Model.Url">@Model.Name</a>
		}
	</umbraco:Macro>
	
When attributes are passed into a macro, you can use the following syntax to send data from the current state to your macro.

CurrentPage property value: [#propertyAlias]
Recursive value: [$propertyAlias]
Cookie value: [%cookieValueKey]
Value from request collection: [@requestValueKey]


[See the full umbraco:macro reference](umbracomacro.md)
    
    
##Template inheritance
Templates can inherite other templates and uses 2 elements to merge them. `<asp:contentplaceholder>` and `<asp:content>` To connect one template with another, use the dropdownlist in Umbraco to specify the master template, this will change the template declation and make a database change.

Lets imagine we have define the below template structure.

- Master.master
	- Homepage.master
	- Textpage.master

For inheritance to work, the parent template (master.master) needs to have a placeholder, and the child-templates needs to have a content area which matches the placeholder alias.

So in master.master we have the default asp:content element, and inside of that, we have a placeholder with id "myarea"
	
	<%@ Master Language="C#" MasterPageFile="~/umbraco/masterpages/default.master" AutoEventWireup="true" %>
	<asp:Content ContentPlaceHolderID="ContentPlaceHolderDefault" runat="server">
	 	<div id="myDiv">
	 		<asp:contentplaceholder id="myarea" runat="server"/>
	 	</div>
	</asp:Content>

In the child templates, we will now need to have a asp:content area which matches the placeholder id
	
	<%@ Master Language="C#" MasterPageFile="master.master" AutoEventWireup="true" %>
	<asp:Content ContentPlaceHolderID="myarea" runat="server">
	 	<h1>this is my child template</h1>
	 	<p>body text</p>
	</asp:Content>

When the page is rendered, the resulting html in the browser will look like this:

	<div id="myDiv">
	 	<h1>this is my child template</h1>
	 	<p>body text</p>
	 </div>


###asp:contentplaceholder
ContentPlaceholder is, as the name implies a placeholder for content being merged from another template. The element requires a `Id`, and `runat="server"` 

	<asp:contentplaceholder id="myArea" runat="server" />
	
A placeholder can also contain a default value, incase it is not used by a inheriting template

	<asp:contentplaceholder id="myArea" runat="server">
		<p>Show this, if no inheritance</p>
	</asp:contentplaceholder>

###asp:content
Content requires a placeholder in its master template to function, so the `contentplaceholderId` attribute must match the id of `contentplaceholder` element in the parent template, or you will get a YSOD detailing what content element cannot find its placeholder. All html in the Umbraco templates must be wrapped in a asp:content element.

	<asp:content runat="server" contentplaceholderid="placeholder">



##inline code
it is possible to run C# code diretly in the template, but is not in any way recommended. However, if it is required, the standard masterpages syntax can be used:

	<%
		if(SomeCondition){
			throw new Exception("Explosion!");
		}
	%>

##client dependency



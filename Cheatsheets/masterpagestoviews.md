# Converting Masterpages to Views
Covers how you convert common syntax in Umbraco 4 Masterpages to Umbraco 4.11+ Views.

## Page declaration and reference to parent template  ##
**Masterpage**

    <%@ master language="C#" masterpagefile="~/masterpages/umbMaster.master">

**Razor View**

	@inherits Umbraco.Web.Mvc.UmbracoTemplatePage    
	@{  
		Layout= "~/Views/umbMaster.cshtml";
	}

## Server side forms ##
**Masterpage**
	
	<form runat="server">
        
**Razor View**

Remove, not required in views


## Content area ##
**Masterpage**
	
	<asp:content contentplaceholderid="footer"> 
		<p>Hello</p> 
	</asp:content>
        
**Razor View**

	@section footer { 
		<p>Hello</p>
	} 

## Content placeholder ##
**Masterpage**
	
	<asp:contentplaceholder id="footer"> 
        
**Razor View**

	@RenderSection("footer")

If the View that inherits from this view is not required to define a "footer" section then you can add an extra `false` parameter (if you omit the boolean, it defaults to `true`):

	@RenderSection("footer", false)

If you want to render the main body area then you can simply do the following (only allowed once per View): 

	@RenderBody() 


## Umbraco item ##
**Masterpage**
	
	<umbraco:item field="bodyText" /> 
        
**Razor View**

	@CurrentPage.bodyText 
	

## Umbraco item with parameters ##
**Masterpage**
	
	<umbraco:Item field="PostDate" useIfEmpty="createDate" formatAsDate="true" runat="server" /> 
        
**Razor View**

	@Umbraco.Field("PostDate", altFieldAlias: "CreateDate", formatAsDate: true)  
	
## Umbraco Macro ##
**Masterpage**
	
	<umbraco:macro alias="topNavigation" /> 
        
**Razor View**

	@Umbraco.RenderMacro("topNavigation") 
	

## Umbraco Macro with parameters ##
**Masterpage**
	
	<umbraco:macro alias="topNavigation" nodeId="1082" name="John" /> 
        
**Razor View**

	@Umbraco.RenderMacro("topNavigation" new{ nodeId = 1082, name="John" })



## ASP.NET Textbox Control ##
**Masterpage**
	
	<asp:textbox id="tb_member" runat="server" />
        
**Razor View**

	@Html.TextBoxFor(model => model.MemberId)

Or with some styling and a placeholder:

	@Html.TextAreaFor(model => model.MemberId, 
 			htmlAttributes: new { @class="span9 tokeninput", placeholder="Who should be notified?" })

Or even in mostly plain HTML:

	<input type="text" name="MemberId" value="@Model.MemberId" 
		class="span9 tokeninput" placeholder="Who should be notified?" />


# Converting Masterpages to Views
Covers how you convert common syntax in Umbraco Masterpages to Umbraco Views.

## Page declaration and reference to parent template  ##
**Masterpage**

```csharp
<%@ master language="C#" masterpagefile="~/masterpages/umbMaster.master">
```

**Razor View**

```csharp
@inherits Umbraco.Web.Mvc.UmbracoTemplatePage    
@{  
	Layout= "~/Views/umbMaster.cshtml";
}
```

## Server side forms ##
**Masterpage**

```csharp	
<form runat="server">
```

**Razor View**

Remove, not required in views


## Content area ##
**Masterpage**

```csharp	
<asp:content contentplaceholderid="footer"> 
	<p>Hello</p> 
</asp:content>
```

**Razor View**

```csharp
@section footer { 
	<p>Hello</p>
} 
```

## Content placeholder ##
**Masterpage**

```csharp	
<asp:contentplaceholder id="footer"> 
```

**Razor View**

```csharp
@RenderSection("footer")
```

If the View that inherits from this view is not required to define a "footer" section then you can add an extra `false` parameter (if you omit the boolean, it defaults to `true`):

```csharp
@RenderSection("footer", false)
```

If you want to render the main body area then you can simply do the following (only allowed once per View): 

```csharp
@RenderBody() 
```

## Umbraco item ##
**Masterpage**

```csharp
<umbraco:item field="bodyText" /> 
```

**Razor View**

```csharp
@CurrentPage.bodyText 
```

## Umbraco item with parameters ##
**Masterpage**

```csharp	
<umbraco:Item field="PostDate" useIfEmpty="createDate" formatAsDate="true" runat="server" /> 
```

**Razor View**

```csharp
@Umbraco.Field("PostDate", altFieldAlias: "CreateDate", formatAsDate: true)  
```

## Umbraco Macro ##
**Masterpage**

```csharp	
<umbraco:macro alias="topNavigation" /> 
```

**Razor View**

```csharp
@Umbraco.RenderMacro("topNavigation") 
```

## Umbraco Macro with parameters ##
**Masterpage**

```csharp
<umbraco:macro alias="topNavigation" nodeId="1082" name="John" /> 
```

**Razor View**

```csharp
@Umbraco.RenderMacro("topNavigation" new{ nodeId = 1082, name="John" })
```

## ASP.NET Textbox Control ##
**Masterpage**

```csharp	
<asp:textbox id="tb_member" runat="server" />
```

**Razor View**

```csharp
@Html.TextBoxFor(model => model.MemberId)
```

Or with some styling and a placeholder:

```csharp
@Html.TextAreaFor(model => model.MemberId, 
		htmlAttributes: new { @class="span9 tokeninput", placeholder="Who should be notified?" })
```

Or even in mostly plain HTML:

```csharp
<input type="text" name="MemberId" value="@Model.MemberId" 
	class="span9 tokeninput" placeholder="Who should be notified?" />
```
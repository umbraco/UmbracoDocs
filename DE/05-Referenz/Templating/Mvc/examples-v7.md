---
versionFrom: 7.0.0
---

# View/Razor Examples

_Lots of examples of using various techniques to render data in a view_

## Rendering a field with UmbracoHelper

```csharp
@Umbraco.Field("bodyContent")
```

## Rendering a field with UmbracoHelper with optional parameters

```csharp
@Umbraco.Field("bodyContent", insertBefore : "<h2>", insertAfter : "</h2>")
```

## Rendering the raw value of a field from IPublishedContent

```csharp
@Model.Content.Properties["bodyContent"].Value
```

Or alternatively:

```csharp
@Model.Content.GetPropertyValue("bodyContent")
```

## Rendering the converted value of a field from IPublishedContent

```csharp
@Model.Content.GetPropertyValue<double>("amount")
@Model.Content.GetPropertyValue<RawXElement>("xmlContents")
```

## Rendering a field using @CurrentPage (dynamically)

```csharp
@CurrentPage.bodyContent
```

## Rendering a macro

```csharp
@Umbraco.RenderMacro("myMacroAlias")
```

## Rendering a macro with parameters using an anonymous object

```csharp
@Umbraco.RenderMacro("myMacroAlias", new { name = "Ned", age = 28 })
```

## Rendering a macro with parameters using a dictionary

```csharp
@Umbraco.RenderMacro("myMacroAlias", new Dictionary<string, object> {{ "name", "Ned"}, { "age", 27}})
```

## Rendering some member data

```csharp
@if(Members.IsLoggedIn()){
    var profile = Members.GetCurrentMemberProfileModel();
    var umbracomember = Members.GetByUsername(profile.UserName);

    <h1>@umbracomember.Name</h1>
    <p>@umbracomember.GetPropertyValue<string>("bio")</p>
}
```

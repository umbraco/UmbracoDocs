---


---

# View/Razor Examples

_Lots of examples of using various techniques to render data in a view_

## Rendering the raw value of a field from IPublishedContent

```csharp
@Model.Value("bodyContent")
```

## Rendering the converted value of a field from IPublishedContent

```csharp
@Model.Value<double>("amount")
@Model.Value<IHtmlString>("bodyContent")
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
    <p>@umbracomember.Value<string>("bio")</p>
}
```

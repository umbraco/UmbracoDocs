# Umbraco Helper 

use `@Umbraco` in a Template

```csharp
// variable to hold Content/Media GUID
var udi = Guid.Parse("GUID")
```

## Getting things by Id

```csharp
.Content(udi)
.Content(udi) as Blogpost
.Media(udi)
.Media(udi) as Image / Audio

.ContentAtRoot()
.GetDictionaryValue("dictionaryKey", altText: "a default value");
.MediaAtRoot()
.RenderMacroAsync("macroAlias", new{parameterKey=parameterValue})
.ContentAtXPath("XPathExpression")
.ContentSingleAtXPath("XPathExpression")

.AssignedContentItem
.CultureDictionary.Culture.TwoLetterISOLanguageName
```

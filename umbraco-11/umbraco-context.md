# Umbraco Context

use `@UmbracoContext` in a template

```csharp
.Content.GetByRoute("/")
.Media.GetAtRoot()
.IsDebug
.InPreviewMode
.CleanedUmbracoUrl
.OriginalRequestUrl
.Domains.GetAll()
```

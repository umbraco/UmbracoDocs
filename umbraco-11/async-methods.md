# Async methods

Increasingly methods have async versions.

When choosing async methods in a Template you need to use `@await`.

Example:

```csharp
@await Umbraco.RenderMacroAsync("myMacroAlias")
```
